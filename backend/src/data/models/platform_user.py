import sqlalchemy as sa
from setup import db


class PlatformUser(db.Model):
    __tablename__ = "PlatformUser"
    idUser = db.Column(db.Integer, primary_key=True)
    nitEmitter = db.Column(
        db.Integer, db.ForeignKey('emitterDTE.idEmitterDte'), nullable=False
    )
    userName = sa.Column(sa.String(255), nullable=False)
    userLastName = sa.Column(sa.String(255), nullable=False)
    userEmail = sa.Column(sa.String(255), nullable=False)
