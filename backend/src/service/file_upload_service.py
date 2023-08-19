from werkzeug.datastructures import FileStorage
from flask import jsonify
from flask_restx import Namespace, Resource, fields
import pandas as pd

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
        process_file(uploaded_file)
        return {'url': "hello"}


def process_file(file):
    # To read multiple sheets
    df: pd.DataFrame = pd.read_excel(file, sheet_name=None)
    print(df.keys())  # get
