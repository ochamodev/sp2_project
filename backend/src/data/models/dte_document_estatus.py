import sqlalchemy as sa
from setup import db


class DteDocumentStatus(db.Model):
    __tablename__ = "DteDocumentEstatus"
    idDteDocumentStatus = sa.Column(sa.Integer, primary_key=True)
    descriptionEstatus = sa.Column(sa.String(255))
    dte_documents = db.relationship('DTEDocument', backref="dteDocumentStatus")
