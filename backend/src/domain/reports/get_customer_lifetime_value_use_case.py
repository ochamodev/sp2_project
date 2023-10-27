
from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.customer_lifetime_value_dto import CustomerLifetimeValueResponseDTO, CustomerLifetimeValueItemDTO


def get_customer_lifetime_value_use_case(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        # fetch total clients
        cursor.execute(
            "CALL GetTotalClients({em})".format(em=companyCode)
        )
        totalClients = list(cursor.fetchall())
        cursor.close()
        totalClientsCount = 0
        for row in totalClients:
            totalClientsCount = row[0]

        # fetch total clients

        # fetch avg month
        connection = db.engine.raw_connection()
        cursor = connection.cursor()
        cursor.execute("CALL GetAvgActiveMonth({em})".format(em=companyCode))
        totalAvgMonths = list(cursor.fetchall())
        totalAvgMonthsActive = 0
        cursor.close()
        for row in totalAvgMonths:
            totalAvgMonthsActive = row[0]
        # fetch avg month

        # fetch avg frequency month
        connection = db.engine.raw_connection()
        cursor = connection.cursor()
        cursor.execute(
            "CALL GetAvgFrequencyPurchase({em})".format(em=companyCode)
        )
        avgFrequencyMonths = list(cursor.fetchall())
        totalAvgFrequencyMonth = 0
        cursor.close()
        for row in avgFrequencyMonths:
            totalAvgFrequencyMonth = row[0]
        # fetch avg frequency month

        # fetch avg purchase
        connection = db.engine.raw_connection()
        cursor = connection.cursor()
        cursor.execute(
            "CALL GetAvgPurchase({em})".format(em=companyCode)
        )
        avgPurchases = list(cursor.fetchall())
        totalAvgPurchase = 0
        cursor.close()
        for row in avgPurchases:
            totalAvgPurchase = row[0]
        # fetch avg purchase

        # fetch list of customer value
        customerLifetimeValuePerYearItems = get_customer_lifetime_value_list(
            companyCode=companyCode)
        # fetch list of customer value

        dto = CustomerLifetimeValueResponseDTO(totalClients=totalClientsCount, avgMonthActive=totalAvgMonthsActive,
                                               avgPurchase=totalAvgPurchase, avgFrequencyMonth=totalAvgFrequencyMonth, customerValuePerYear=customerLifetimeValuePerYearItems)

        baseResponseDto = BaseResponseDTO(data=dto, success=True)
        return baseResponseDto
    finally:
        connection.close()


def get_customer_lifetime_value_list(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()

        cursor.execute(
            "CALL ExistingBillingYears({em})".format(em=companyCode)
        )
        yearsResult = list(cursor.fetchall())
        cursor.close()
        customerLifetimeValueItems = []
        yearlyItems = {}
        for year in yearsResult:
            yearItem = year[0]
            customerLifetimeValueItems = get_customer_lifetime_elements(
                companyCode, yearItem)
            yearlyItems.update({f'{yearItem}': customerLifetimeValueItems})

        return yearlyItems

    finally:
        connection.close()


def get_customer_lifetime_elements(companyCode: int, yearToRequest: int):
    connection = db.engine.raw_connection()
    try:
        items = []
        cursor = connection.cursor()
        cursor.execute(
            "CALL CustomerValue({em}, {yearToRequest})".format(
                em=companyCode, yearToRequest=yearToRequest)
        )
        customerLifetimeValues = list(cursor.fetchall())
        cursor.close()
        for it in customerLifetimeValues:
            yearT = it[0]
            monthT = it[1]
            amount = it[2]
            clientCount = it[3]
            quantity = it[4]
            customerValue = it[5]
            purchaseRate = it[6]
            purchaseValue = it[7]
            dto = CustomerLifetimeValueItemDTO(yearT=yearT, monthT=monthT, amount=amount, clientCount=clientCount,
                                               quantity=quantity, customerValue=customerValue, purchaseRate=purchaseRate, purchaseValue=purchaseValue)
            items.append(dto)
        return items
    finally:
        connection.close()
