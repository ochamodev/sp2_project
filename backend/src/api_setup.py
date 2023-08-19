from flask_restx import Api
from service.user_service import api as userNamespace
from service.file_upload_service import api as fileUploadNameSpace

apiSp2 = Api(
    title='Seminario profesional 2',
    version="1.0"
)

apiSp2.add_namespace(userNamespace)
apiSp2.add_namespace(fileUploadNameSpace)
