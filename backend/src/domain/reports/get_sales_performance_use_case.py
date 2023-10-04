
from sqlalchemy import text
from sqlalchemy import select
from datetime import datetime
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO
from domain.dto.sales_performance_dto import SalesPerformanceDTO


def get_sales_performance_use_case(emitter: int):
    try:
        result = db.session.execute(
            text("CALL GetSalesPerformance(:em)"),
            {'em': emitter}
        )

        items = []
        for row in result:
            # dto = SalesPerformanceDTO(row[0], row[1], row[2])
            # items.append(dto)
            print(row)
        # db.session.close()
        return BaseResponseDTO(data=items, success=True)
    except Exception as e:
        print(e)
        return BaseResponseDTO(data={'error': 'error'}, success=False)


def get_sales_performance_use_case2(emitter: int):
    connection = db.engine.raw_connection()
    try:
        cursor = connection.cursor()
        cursor.execute("CALL GetSalesPerformance({em})".format(em=emitter))
        results = list(cursor.fetchall())
        items = []
        for row in results:
            dto = SalesPerformanceDTO(row[0], row[1], row[2])
            items.append(dto)
        cursor.close()
        return BaseResponseDTO(data=items, success=True)
    finally:
        connection.close()


def get_sales_performance_use_case3(emitter: int):
    connection = db.engine.raw_connection()
    try:
        connection = db.engine.raw_connection()
        cursor_obj = connection.cursor()
        cursor_obj.execute(
            'CALL GetSalesPerformance(%s);', [emitter])
        results = list(cursor_obj.fetchall())

        for row in results:
            print(row)
            print(row[0])
            print(row[1])
        cursor_obj.close()
        # connection.commit()

        return BaseResponseDTO(data={}, success=True)
    finally:
        connection.close()
