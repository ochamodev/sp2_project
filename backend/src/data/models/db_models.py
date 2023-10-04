from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()


class ResponseCodes(db.Model):
    __tablename__ = "ResponseCodes"
    idResponse = db.Column(db.Integer, primary_key=True)
    respCode = db.Column(db.String, unique=True)
    respDescription = db.Column(db.String)


class CertifierDte(db.Model):
    __tablename__ = "CertifierDTE"
    idNitCertifier = db.Column(db.Integer, primary_key=True)
    fullNameCertifier = db.Column(db.String)
    nitCertifier = db.Column(db.String(25), nullable=False)
    dte_documents = db.relationship("DTEDocument", backref="certifierData")


class DteDocumentEstatus(db.Model):
    __tablename__ = "DteDocumentEstatus"
    idDteDocumentEstatus = db.Column(db.Integer, primary_key=True)
    descriptionEstatus = db.Column(db.String(255))
    dte_documents = db.relationship(
        'DTEDocument', backref="dteDocumentEstatus")


class DTEReceptor(db.Model):
    __tablename__ = "DTEReceptor"
    idDteReceptor = db.Column(db.Integer, primary_key=True)
    nit = db.Column(db.String(25), nullable=False, unique=True)
    fullnameReceptor = db.Column(db.String(255), nullable=False)
    dte_documents = db.relationship('DTEDocument', backref="dteReceptor")


class EmitterDTE(db.Model):
    __tablename__ = "EmitterDTE"
    idEmitterDte = db.Column(db.Integer, primary_key=True)
    nit = db.Column(db.String(25), nullable=False)
    nameEmitter = db.Column(db.String(255), nullable=False)
    platformUsers = db.relationship('PlatformUser', backref='emitterDTE')
    establishments = db.relationship('Establishment', backref="emitterDTE")


class Establishment(db.Model):
    __tablename__ = "Establishment"
    idEstablishment = db.Column(db.Integer, primary_key=True)
    establishmentCode = db.Column(db.Integer, nullable=False)
    nitEmitter = db.Column(
        db.Integer, db.ForeignKey('EmitterDTE.idEmitterDte'), nullable=False
    )
    nameEmitter = db.Column(
        db.String(255), nullable=False
    )
    dte_documents = db.relationship("DTEDocument", backref="establishmentData")


class PlatformUser(db.Model):
    __tablename__ = "PlatformUser"
    idUser = db.Column(db.Integer, primary_key=True, autoincrement=True)
    nitEmitter = db.Column(
        db.Integer, db.ForeignKey('EmitterDTE.idEmitterDte'), nullable=False
    )
    userName = db.Column(db.String(255), nullable=False)
    userLastName = db.Column(db.String(255), nullable=False)
    userEmail = db.Column(db.String(255), nullable=False)
    userPassword = db.Column(db.String(255), nullable=False)


class DTEDocument(db.Model):
    __tablename__ = "DTEDocument"
    idDTEDocument = db.Column(db.Integer, primary_key=True)
    idEstablishment = db.Column(
        db.Integer, db.ForeignKey("Establishment.idEstablishment")
    )
    idCertifier = db.Column(
        db.Integer, db.ForeignKey("CertifierDTE.idNitCertifier")
    )
    idReceptor = db.Column(
        db.Integer, db.ForeignKey("DTEReceptor.idDteReceptor")
    )
    idDteDocumentEstatus = db.Column(
        db.Integer, db.ForeignKey("DteDocumentEstatus.idDteDocumentEstatus")
    )
    authNumber = db.Column(db.String)
    seriesNumber = db.Column(db.String)
    emissionDate = db.Column(db.Date)
    cancellationDate = db.Column(db.DateTime)
    isMarkedCancelled = db.Column(db.Integer, nullable=False)
    amountGrandTotal = db.Column(db.DECIMAL, nullable=False)
    amountIva = db.Column(db.DECIMAL, nullable=False)
    petroleumTax = db.Column(db.DECIMAL, nullable=False)
    tourismHospitalityTax = db.Column(db.DECIMAL, nullable=False)
    tourismPasajeTax = db.Column(db.DECIMAL, nullable=False)
    timbreDePrensaTax = db.Column(db.DECIMAL, nullable=False)
    firefightersTax = db.Column(db.DECIMAL, nullable=False)
    municipalFeeTax = db.Column(db.DECIMAL, nullable=False)
    alcoholicDrinksTax = db.Column(db.DECIMAL, nullable=False)
    tabaccoTax = db.Column(db.DECIMAL, nullable=False)
    cementTax = db.Column(db.DECIMAL, nullable=False)
    noAlcoholicDrinksTax = db.Column(db.DECIMAL, nullable=False)
    protuarieFeeTax = db.Column(db.DECIMAL, nullable=False)
