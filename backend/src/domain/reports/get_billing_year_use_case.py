

from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.sales_performance_dto import SalesPerformanceDTO, MonthlySalesPerYearItemDTO, SalesPerformanceItemDTO, YearFilterDTO, MonthlyStandardDeviationDTO


def get_billing_years_use_case(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        cursor.execute(
            "CALL ExistingBillingYears({em})".format(em=companyCode)
        )
        yearsResult = list(cursor.fetchall())
        cursor.close()
        yearFilters = []
        for year in yearsResult:
            yearItem = year[0]
            yearFilters.append(YearFilterDTO(yearItem))

        return BaseResponseDTO(success=True, data={'filters': yearFilters})
    finally:
        connection.close()
