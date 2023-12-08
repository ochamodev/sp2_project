from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.rfc_dto import RFCDTO, RFCItemDTO
# from domain.dto.customer_lifetime_value_dto import CustomerLifetimeValueResponseDTO, CustomerLifetimeValueItemDTO

# ---------------------DATA ANALYSIS LIBRARIES---------------------------------#

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import datetime as dt
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans


def get_rfc_analysis_use_case(company_code: int):
    try:
        # Fetch and analyze RFC data
        rfc_data = rfc(company_code)

        # Create RFCDTO
        rfc_dto = RFCDTO(
            premium=rfc_data["premium"],
            potential=rfc_data["potential"],
            sporadic=rfc_data["sporadic"]
        )

        # Create a BaseResponseDTO and return
        base_response_dto = BaseResponseDTO(data=rfc_dto, success=True)
        return base_response_dto

    except Exception as e:
        # Handle exceptions appropriately
        return BaseResponseDTO(data=None, success=False, message=str(e))

def rfc(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()

        # fetch data for analysis
        cursor.execute(
            "CALL RFC({em})".format(
                em = companyCode
            )
        )
        column_names = [desc[0] for desc in cursor.description]
        result_set = cursor.fetchall()
        df = pd.DataFrame(result_set, columns=column_names)
        #fetch data for analysis

        cluster_data = get_cluster_data(df=df)
        cluster_items = get_cluster_data_items(cluster_data=cluster_data)
        
        premium = [item for item in cluster_items if item.cluster_name.strip() == 'Cliente Premium']
        potential = [item for item in cluster_items if item.cluster_name.strip() == 'Cliente Potencial']
        sporadic = [item for item in cluster_items if item.cluster_name.strip() == 'Cliente Esporádico']

        return {
            "premium": premium,
            "potential": potential,
            "sporadic": sporadic
        }

    finally:
        cursor.close()  
        connection.close()


def get_cluster_data_items(cluster_data):
    items = []
    try:
        for item in cluster_data.itertuples(index=False):
            idReceptor_index = cluster_data.columns.get_loc('idReceptor')
            idReceptor = item[idReceptor_index]
            name_index = cluster_data.columns.get_loc('name')
            name = item[name_index]
            # amount_index = cluster_data.columns.get_loc('amount')
            # amount = item[amount_index]
            rfm_score_index = cluster_data.columns.get_loc('rfm_score')
            rfm_score = item[rfm_score_index]
            recency_index = cluster_data.columns.get_loc('recency')
            recency = item[recency_index]
            frequency_index = cluster_data.columns.get_loc('frequency')
            frequency = item[frequency_index]
            monetary_index = cluster_data.columns.get_loc('monetary')
            monetary = item[monetary_index]
            cluster_index = cluster_data.columns.get_loc('cluster')
            cluster = item[cluster_index]
            cluster_name_index = cluster_data.columns.get_loc('cluster_name')
            cluster_name = item[cluster_name_index]
            dto = RFCItemDTO(idReceptor=idReceptor, name=name,  
                                rfm_score=rfm_score, recency=recency, frequency=frequency, monetary=monetary, 
                                cluster=cluster, cluster_name=cluster_name)
            # dto = RFCItemDTO(idReceptor=idReceptor, name=name, amount=amount, 
            #                     rfm_score=rfm_score, recency=recency, frequency=frequency, monetary=monetary, 
            #                     cluster=cluster, cluster_name=cluster_name)
            items.append(dto)
    finally:
        return items


def get_cluster_data(df):
    # make a copy of the dataframe for data transformation
    rfm_df = df
    rfm_df

    rfm_df['date'] = pd.to_datetime(rfm_df['date'])

    # current date for analysis
    current_date = rfm_df['date'].max()

    rfm_df['reciente'] = (current_date - df['date']).dt.days

    rfm = rfm_df.groupby('idReceptor').agg({
        'reciente' : 'min',
        'date': 'count',
        'amount' : 'sum'
    }).reset_index()

    # rename columns for RFM
    rfm.columns = ['idReceptor', 'recency', 'frequency', 'monetary']

    rfm[['recency', 'frequency', 'monetary']] = rfm[['recency', 'frequency', 'monetary']].apply(pd.to_numeric)

    # transform recency, smaller values are better customers
    rfm['recency'] = rfm['recency'].max() - rfm['recency']
    rfm

    print(rfm[rfm.duplicated()])
    print(rfm[rfm.duplicated(subset=['idReceptor'])])

    # separate into quintiles (in 5 groups based on RFM values obtained above)
    quintiles = rfm[['recency', 'frequency', 'monetary']].quantile([0.2,0.4,0.6,0.8])
    quintiles

    def assign_quintile(score, quintile_values):
        if score <= quintile_values[0.2]:
            return 1
        elif score <= quintile_values[0.4]:
            return 2
        elif score <= quintile_values[0.6]:
            return 3
        elif score <= quintile_values[0.8]:
            return 4
        else:
            return 5

    rfm['recency_quintile'] = rfm['recency'].apply(assign_quintile, args = (quintiles['recency'], ))
    rfm['frequency_quintile'] = rfm['frequency'].apply(assign_quintile, args = (quintiles['frequency'], ))
    rfm['monetary_quintile'] = rfm['monetary'].apply(assign_quintile, args = (quintiles['monetary'], ))

    # Assign score based on all values for RFM
    rfm['rfm_score'] = (rfm['recency_quintile'] + rfm['frequency_quintile'] + rfm['monetary_quintile'])/15

    # Adjust data scale for clustering
    # Clustering uses the distance between two data points, so we normalize so that we eliminate outliers and it's easier for the algorithm to cluster
    scaler = StandardScaler()
    scaled_data = scaler.fit_transform(rfm[['recency', 'frequency', 'monetary']])

    # static cluster number
    optimal_cluster_num = 3
    print(optimal_cluster_num)
    kmeans = KMeans(n_clusters = 3, random_state = 42)
    rfm['cluster'] = kmeans.fit_predict(scaled_data)

    # obtain tuples for recency, frequency and monetary for each cluster
    cluster_summary = rfm.groupby('cluster')[['recency', 'monetary', 'frequency', 'rfm_score']].mean()
    sorted_clusters = cluster_summary.sort_values('rfm_score').index


    # Create a mapping dictionary based on the sorted clusters for assigning final cluster names
    final_cluster_mapping = {
        sorted_clusters[0]: 'Cliente Esporádico',
        sorted_clusters[1]: 'Cliente Potencial',
        sorted_clusters[2]: 'Cliente Premium',
    }

    # Map final cluster names based on sorted clusters and create the 'cluster_name' column
    rfm['cluster_name'] = rfm['cluster'].map(final_cluster_mapping)

    rfm_df = rfm_df.drop_duplicates(subset=['idReceptor'])
    data_with_clusters = pd.merge(rfm, rfm_df, on='idReceptor', how='left')
    data_with_clusters = data_with_clusters.sort_values(by='rfm_score', ascending=True)
    
    return data_with_clusters