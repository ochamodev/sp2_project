import sqlalchemy as sa
from setup import db


class DTEReceptor(db.Model):
    __tablename__ = "DTEReceptor"
    idDteReceptor = sa.Column(sa.Integer, primary_key=True)
    nit = sa.Column(sa.String(25), nullable=False, unique=True)
    fullnameReceptor = sa.Column(sa.String(255), nullable=False)
    dte_documents = db.relationship('DTEDocument', backref="dteReceptor")
