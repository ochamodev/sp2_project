import sqlalchemy as sa
from setup import db


class DTEDocument(db.Model):
    __tablename__ = "DTEDocument"
    idDTEDocument = sa.Column(sa.Integer, primary_key=True)
    idEstablishment = sa.Column(
        sa.Integer, sa.ForeignKey("Establishment.idEstablishment")
    )
    idCertifier = sa.Column(
        sa.Integer, sa.ForeignKey("CertifierDTE.idNitCertifier")
    )
    idReceptor = sa.Column(
        sa.Integer, sa.ForeignKey("DTEReceptor.idDteReceptor")
    )
    idDteDocumentEstatus = sa.Column(
        sa.Integer, sa.ForeignKey("DteDocumentStatus.idDteDocumentStatus")
    )
    authNumber = sa.Column(sa.String)
    seriesNumber = sa.Column(sa.String)
    emissionDate = sa.Column(sa.DateTime)
    cancellationDate = sa.Column(sa.DateTime)
    isMarkedCancelled = sa.Column(sa.Integer, nullable=False)
    amountGrandTotal = sa.Column(sa.DECIMAL, nullable=False)
    amountIva = sa.Column(sa.DECIMAL, nullable=False)
    petroleumTax = sa.Column(sa.DECIMAL, nullable=False)
    tourismHospitalityTax = sa.Column(sa.DECIMAL, nullable=False)
    tourismPasajeTax = sa.Column(sa.DECIMAL, nullable=False)
    timbreDePrensaTax = sa.Column(sa.DECIMAL, nullable=False)
    firefightersTax = sa.Column(sa.DECIMAL, nullable=False)
    municipalTax = sa.Column(sa.DECIMAL, nullable=False)
    municipalFeeTax = sa.Column(sa.DECIMAL, nullable=False)
    alcoholicDrinksTax = sa.Column(sa.DECIMAL, nullable=False)
    tabaccoTax = sa.Column(sa.DECIMAL, nullable=False)
    cementTax = sa.Column(sa.DECIMAL, nullable=False)
    noAlcoholicDrinksTax = sa.Column(sa.DECIMAL, nullable=False)
    protuarieFeeTax = sa.Column(sa.DECIMAL, nullable=False)
