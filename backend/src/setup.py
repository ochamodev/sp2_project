from dotenv import load_dotenv
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_injector import FlaskInjector
import injector

from api_setup import apiSp2

# Reference of initialization
# https://pypi.org/project/Flask-SQLAlchemy/
app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+mysqlconnector://root:root@localhost:3306/proyectosp2"
# setup DB ORM
db = SQLAlchemy(app)
# setup apis
apiSp2.init_app(app)


def configure(binder):
    binder.bind(
        SQLAlchemy,
        to=db,
        scope=injector.SingletonScope
    )


FlaskInjector(app=app, modules=[configure])
