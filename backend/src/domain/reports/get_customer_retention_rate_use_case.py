
from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.customer_retention_rate_dto import CustomerRetentionRateItemDTO, CustomerRetentionResponseDTO


def get_customer_retention_use_case(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        # fetch list of customer value
        customerRetentionPerYearItems = get_customer_retention_rate_list(
            companyCode=companyCode)
        # fetch list of customer value

        dto = CustomerRetentionResponseDTO(customerRetentionPerYear=customerRetentionPerYearItems)

        baseResponseDto = BaseResponseDTO(data=dto, success=True)
        return baseResponseDto
    finally:
        connection.close()
    

def get_customer_retention_rate_list(companyCode: int):
    connection = db.engine.raw_connection()

    try:
        cursor = connection.cursor()

        cursor.execute(
            "CALL ExistingBillingYears({em})".format(em=companyCode)
        )
        yearsResult = list(cursor.fetchall())
        cursor.close()
        customerRetentionRateItems = []
        yearlyItems = {}
        for year in yearsResult:
            yearItem = year[0]
            customerRetentionRateItems = get_customer_retention_elements(
                companyCode, yearItem)
            yearlyItems.update({f'{yearItem}': customerRetentionRateItems})

        return yearlyItems

    finally:
        connection.close()


def get_customer_retention_elements(companyCode: int, requestedYear: int):
    connection = db.engine.raw_connection()
    try:
        items = []
        cursor = connection.cursor()
        cursor.execute(
            "CALL CustomerRetention({em}, {requestedYear})".format(
                em=companyCode, requestedYear=requestedYear)
        )
        customerRetentionRates = list(cursor.fetchall())
        cursor.close()
        for it in customerRetentionRates:
            yearT = it[0]
            monthT = it[1]
            newClients = it[2]
            newAmount = it[3]
            cancelledClients = it[4]
            cancelledAmount = it[5]
            retainedClients = it[6]
            retainedAmount = it[7]
            customerRetention = it[8]
            dto = CustomerRetentionRateItemDTO(yearT = yearT, monthT = monthT, newClients = newClients, newAmount = newAmount, cancelledClients = cancelledClients, cancelledAmount = cancelledAmount, retainedClients = retainedClients, retainedAmount = retainedAmount, customerRetention = customerRetention)
            items.append(dto)
        return items

    finally:
        connection.close()