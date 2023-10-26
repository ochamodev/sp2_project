
from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.sales_performance_dto import SalesPerformanceDTO, MonthlySalesPerYearItemDTO, SalesPerformanceItemDTO, YearFilterDTO, MonthlyStandardDeviationDTO


def get_sales_performance_use_case(companyCode: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()

        cursor.execute(
            "CALL ExistingBillingYears({em})".format(em=companyCode)
        )
        yearsResult = list(cursor.fetchall())
        cursor.close()
        yearFilters = []
        monthlyItems = {}
        monthlyVarianceItem = {}
        for year in yearsResult:
            yearItem = year[0]
            yearFilters.append(YearFilterDTO(yearItem))
            monthlyItemList = get_monthly_total_sales(companyCode, yearItem)
            monthlyItems.update(
                {f'{yearItem}': monthlyItemList})
            monthVarianceList = get_monthly_variance(companyCode, yearItem)
            monthlyVarianceItem.update({f'{yearItem}': monthVarianceList})

        connection = db.engine.raw_connection()
        cursor = connection.cursor()
        cursor.execute("CALL GetSalesPerformance({em})".format(em=companyCode))
        results = list(cursor.fetchall())

        items = []
        for row in results:
            dto = SalesPerformanceItemDTO(row[0], row[1], row[2])
            items.append(dto)

        salesPerformanceData = SalesPerformanceDTO(yearFilters=yearFilters,
                                                   monthlySalesPerYear=monthlyItems, salesPerformanceElements=items, monthlyStandardDeviation=monthlyVarianceItem)
        return BaseResponseDTO(data=salesPerformanceData, success=True)
    finally:
        connection.close()


def get_monthly_total_sales(companyCode: int, year: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        s = f"CALL TotalSalesPerMonthByYear({companyCode}, {year})"
        print("string = ", s)
        cursor.execute(
            s
        )
        monthlySalesResult = list(cursor.fetchall())
        items = []
        for it in monthlySalesResult:
            items.append(MonthlySalesPerYearItemDTO(
                it[0], it[1], it[2], it[3]))
        cursor.close()

        return items

    finally:
        connection.close()


def get_monthly_variance(companyCode: int, year: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        s = f"CALL StandardDeviationPerMonthByYear({companyCode}, {year})"
        print("string = ", s)
        cursor.execute(
            s
        )
        monthlySalesResult = list(cursor.fetchall())
        items = []
        for it in monthlySalesResult:
            items.append(MonthlyStandardDeviationDTO(
                it[0], it[1], it[2]))
        cursor.close()

        return items

    finally:
        connection.close()


# subir el archivo en el background.
#
