from werkzeug.datastructures import FileStorage
from flask import jsonify
from flask_restx import Namespace, Resource, fields
import pandas as pd

from domain.create_dte_registers_use_case import createDteRegisterUseCase
from domain.dto.base_response_dto import BaseResponseDTO

api = Namespace('fileUpload', 'File upload operations')

upload_parser = api.parser()
upload_parser.add_argument('file', location='files',
                           type=FileStorage, required=True)


@api.route('/upload/')
@api.expect(upload_parser)
class Upload(Resource):
    def post(self):
        args = upload_parser.parse_args()
        uploaded_file = args['file']  # This is FileStorage instance
        # url = do_something_with_file(uploaded_file)
        dataframe = process_file(uploaded_file)
        result = createDteRegisterUseCase(dataframe)
        return BaseResponseDTO.Schema().dump(result)


def process_file(file):
    # To read multiple sheets
    df: pd.DataFrame = pd.read_excel(
        file, sheet_name="InformacionDTE-FEL")
    df.columns = df.columns.str.replace(' ', '')
    df = df.rename(columns={
        'Fechadeemisión': '0',
        'NúmerodeAutorización': '1',
        'TipodeDTE(nombre)': '2',
        'Serie': '3',
        'NúmerodelDTE': '4',
        'NITdelemisor': '5',
        'Nombrecompletodelemisor': '6',
        'Códigodeestablecimiento': '7',
        'Nombredelestablecimiento': '8',
        'IDdelreceptor': '9',
        'Nombrecompletodelreceptor': '10',
        'NITdelCertificador': '11',
        'NombrecompletodelCertificador': '12',
        'Moneda': '13',
        'Monto(GranTotal)': '14',
        'Estado': '15',
        'Marcadeanulado': '16',
        'Fechadeanulación': '17',
        'IVA(montodeesteimpuesto)': '18',
        'Petróleo(montodeesteimpuesto)': '19',
        'TurismoHospedaje(montodeesteimpuesto)': '20',
        'TurismoPasajes(montodeesteimpuesto)': '21',
        'TimbredePrensa(montodeesteimpuesto)': '22',
        'Bomberos(montodeesteimpuesto)': '23',
        'TasaMunicipal(montodeesteimpuesto)': '24',
        'Bebidasalcohólicas(montodeesteimpuesto)': '25',
        'Tabaco(montodeesteimpuesto)': '26',
        'Cemento(montodeesteimpuesto)': '27',
        'BebidasnoAlcohólicas(montodeesteimpuesto)': '28',
        'TarifaPortuaria(montodeesteimpuesto)': '29'
    })
    return df
    # Iterate over the rows
    # print("this are the keys")
    # print(df.columns)
    # for index, row in df.iterrows():
    # Now 'row' contains the data for each row
    # print(row)
    # print(index)
