import sqlalchemy as sa
from setup import db


class Establishment(db.Model):
    __tablename__ = "Establishment"
    idEstablishment = sa.Column(sa.Integer, primary_key=True)
    nitEmitter = db.Column(
        db.Integer, db.ForeignKey('emitterDTE.idEmitterDte'), nullable=False
    )
    nameEmitter = sa.Column(
        sa.String(255), nullable=False
    )
    dte_documents = db.relationship("Establishment", backref="establishment")
