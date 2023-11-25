from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
# from domain.dto.customer_lifetime_value_dto import CustomerLifetimeValueResponseDTO, CustomerLifetimeValueItemDTO

# ---------------------DATA ANALYSIS LIBRARIES---------------------------------#

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import datetime as dt
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans


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
        cluster_list = get_cluster_list(cluster_items)

    finally:
        connection.close()


def get_cluster_list(cluster_items):
    return []


def get_cluster_data_items(cluster_data):
    items = []
    try:
        for it in cluster_data:
            idReceptor = it ['idReceptor']
            name = it ['name']
            amount = it['amount']
            rfm_score = it['rfm_score']
            recency = it ['recency']
            frequency = it ['frequency']
            monetary = it ['monetary']
            cluster = it ['cluster']
            cluster_name = it ['cluster_name']
            dto = RFCItemDTO(idReceptor=idReceptor, name=name, amount=amount, 
                                rfm_score=rfm_score, recency=recency, frequency=frequency, monetary=monetary, 
                                cluster=cluster, cluster_name=cluster_name)
            items.append(dto)
    finally:
        return items


def get_cluster_data(df):
    # current date for analysis
    current_date = df['date'].max()

    # make a copy of the dataframe for data transformation
    rfm_df = df
    rfm_df

    # define recency frequency monetary variables per customer
    # rfm_df['recency'] = (current_date - df['date']).dt.days
    # rfm = rfm_df.groupby('idReceptor').agg({
    #     'recency' : 'min',
    #     'date': 'count',
    #     'amount' : 'sum'
    # }).reset_index()

    rfm = rfm_df.groupby('idReceptor').agg({
        'recency' : lambda x: (current_date - x.min()).days,
        'date': 'count',
        'amount' : 'sum'
    }).reset_index()

    rfm.info()

    # rename columns for RFM
    rfm.columns = ['idReceptor', 'recency', 'frequency', 'monetary']

    # transform recency, smaller values are better customers
    rfm['recency'] = rfm['recency'].max() - rfm['recency']
    rfm

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
    rfm['rfm_score'] = rfm['recency_quintile'] + rfm['frequency_quintile'] + rfm['monetary_quintile']

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
    cluster_summary = rfm.groupby('cluster')[['recency', 'monetary', 'frequency']].mean()
    print(cluster_summary)

    # Create a mapping dictionary to rename clusters
    cluster_mapping = {
        0: 'Cliente Premium',
        1: 'Cliente Potencial',
        2: 'Cliente Esporádico',
    }

    rfm['cluster_name'] = rfm['cluster'].map(cluster_mapping)

    data_with_clusters = pd.merge(rfm_df, rfm, on='customer_id', how='left')
    data_with_clusters = data_with_clusters.sort_values(by='rfm_score', ascending=True)

    return data_with_clusters