import sqlalchemy as sa
from setup import db


class EmitterDTE(db.Model):
    __tablename__ = "EmitterDTE"
    idEmitterDte = sa.Column(sa.Integer, primary_key=True)
    nit = sa.Column(sa.String(25), nullable=False)
    nameEmitter = sa.Column(sa.String(255), nullable=False)
    platformUsers = db.relationship('PlatformUser', backref='emitterDTE')
    establishments = db.relationship('Establishment', backref="emitterDTE")
