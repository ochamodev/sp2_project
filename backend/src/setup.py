from datetime import timedelta
from dotenv import load_dotenv
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager


# Reference of initialization
# https://pypi.org/project/Flask-SQLAlchemy/


def create_application():
    app = Flask(__name__)
    app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+mysqlconnector://root:rootpassword@localhost:3306/proyectosp2"

    # Setup the Flask-JWT-Extended extension
    app.config["JWT_SECRET_KEY"] = "super-secret"  # Change this!
    app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(days=5)
    app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(days=30)
    jwt = JWTManager(app)

    # setup models
    from data.models.db_models import db
    db.init_app(app)
    # setup apis
    from api_setup import apiSp2

    apiSp2.init_app(app)

    from flask_cors import CORS
    CORS(app)

    return app
