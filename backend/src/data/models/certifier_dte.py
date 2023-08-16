import sqlalchemy as sa
from setup import db


class CertifierDte(db.Model):
    __tablename__ = "CertifierDTE"
    idNitCertifier = sa.Column(sa.Integer, primary_key=True)
    fullNameCertifier = sa.Column(sa.String)
    nitCertifier = sa.Column(sa.String(25), nullable=False)
