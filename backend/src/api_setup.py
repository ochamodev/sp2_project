from flask_restx import Api
from service.user_service import api as userNamespace

apiSp2 = Api(
    title='Seminario profesional 2',
    version="1.0"
)

apiSp2.add_namespace(userNamespace)
