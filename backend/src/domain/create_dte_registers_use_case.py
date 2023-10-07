from decimal import Decimal
import pandas as pd
import re
from datetime import datetime
from sqlalchemy import exc
from data.models.db_models import db, DTEDocument, EmitterDTE, DTEReceptor, Establishment, DTEReceptor, CertifierDte, DteDocumentEstatus
from domain.dte_excel_keys import DTEExcelKeys
from domain.dto.base_response_dto import BaseResponseDTO

format_string_withTimezone = "%Y-%m-%dT%H:%M:%S.%f%z"
format_string_noTimezone = "%Y-%m-%dT%H:%M:%S"
format_string_noTimezoneAfterDot = "%Y-%m-%dT%H:%M:%S.%f"


def createDteRegisterUseCase(df: pd.DataFrame):
    try:
        with db.session.no_autoflush:
            for index, row in df.iterrows():
                authNumber = row[DTEExcelKeys.numAuth]
                if (checkIfDteExists(authNumber=authNumber)):
                    continue
                else:
                    dteDocument = DTEDocument()
                    dteDocument.emissionDate = convertStringToDatetime(
                        row[DTEExcelKeys.fecha_emision])
                    dteDocument.authNumber = authNumber
                    dteDocument.seriesNumber = row[DTEExcelKeys.serie]
                    dteDocument.amountGrandTotal = Decimal(
                        row[DTEExcelKeys.montoTotal])
                    dteDocument.amountIva = Decimal(
                        row[DTEExcelKeys.ivaImpuesto])
                    dteDocument.petroleumTax = row[DTEExcelKeys.petroleoImpuesto]
                    dteDocument.tourismHospitalityTax = row[DTEExcelKeys.turismoHospedaje]
                    dteDocument.tourismPasajeTax = row[DTEExcelKeys.turismoPasaje]
                    dteDocument.tourismPasajeTax = row[DTEExcelKeys.turismoPasaje]
                    dteDocument.timbreDePrensaTax = row[DTEExcelKeys.timbrePrensa]
                    dteDocument.firefightersTax = row[DTEExcelKeys.bomberos]
                    dteDocument.municipalFeeTax = row[DTEExcelKeys.tasaMunicipal]
                    dteDocument.alcoholicDrinksTax = row[DTEExcelKeys.bebidasAlcoholicas]
                    dteDocument.noAlcoholicDrinksTax = row[DTEExcelKeys.bebidasNoAlcoholicas]
                    dteDocument.tabaccoTax = row[DTEExcelKeys.tabaco]
                    dteDocument.cementTax = row[DTEExcelKeys.cemento]
                    dteDocument.protuarieFeeTax = row[DTEExcelKeys.tarifaPortuaria]

                    emitter = findEmitter(
                        row[DTEExcelKeys.nitEmisor]
                    )
                    if (emitter is None):
                        emitter = EmitterDTE()
                        emitter.nameEmitter = row[DTEExcelKeys.nombreCompletoEmisor]
                        emitter.nit = row[DTEExcelKeys.nitEmisor]
                        db.session.add(emitter)
                        establishment = Establishment()
                        establishment.emitterDTE = emitter
                        establishment.establishmentCode = row[DTEExcelKeys.codigoEstablecimiento]
                        establishment.nameEmitter = row[DTEExcelKeys.nombreEstablecimiento]
                        establishment.dte_documents.append(dteDocument)
                        db.session.add(establishment)
                    else:
                        establishment = findEstablishment(
                            code=row[DTEExcelKeys.codigoEstablecimiento],
                            emitter=emitter
                        )
                        if (establishment is None):
                            establishment = Establishment()
                            establishment.emitterDTE = emitter
                            establishment.establishmentCode = row[DTEExcelKeys.codigoEstablecimiento]
                            establishment.nameEmitter = row[DTEExcelKeys.nombreEstablecimiento]
                            establishment.dte_documents.append(dteDocument)
                            db.session.add(establishment)
                        else:
                            dteDocument.establishmentData = establishment

                    certifier = findCertifier(
                        row[DTEExcelKeys.nitEmisor])

                    if (certifier is None):
                        certifier = CertifierDte()
                        certifier.nitCertifier = row[DTEExcelKeys.nitCertificador]
                        certifier.fullNameCertifier = row[DTEExcelKeys.nombreCompletoCertificador]
                        certifier.dte_documents.append(dteDocument)
                        db.session.add(certifier)
                    else:
                        dteDocument.certifierData = certifier

                    receptor = findReceptor(row[DTEExcelKeys.idReceptor])
                    if (receptor is None):
                        receptor = DTEReceptor()
                        receptor.fullnameReceptor = row[DTEExcelKeys.nombreCompletoReceptor]
                        receptor.nit = row[DTEExcelKeys.idReceptor]
                        receptor.dte_documents.append(dteDocument)
                        db.session.add(receptor)
                    else:
                        dteDocument.dteReceptor = receptor

                    dteDocumentEstatus = findDocumentEstatus(
                        row[DTEExcelKeys.marcaAnulado]
                    )
                    if (row[DTEExcelKeys.marcaAnulado] == "Si"):
                        dteDocument.isMarkedCancelled = 1
                        dteDocument.amountGrandTotal = 0
                        dteDocument.amountIva = 0
                    else:
                        dteDocument.isMarkedCancelled = 0

                    dteDocument.dteDocumentEstatus = dteDocumentEstatus

                    db.session.add(dteDocument)
                    db.session.commit()
        return BaseResponseDTO(data={"message": 'Carga exitosa'}, success=True)
    except exc.SQLAlchemyError as e:
        print(e)
        db.session.rollback()
        return BaseResponseDTO(data={'error': 'Error en la carga del archivo'}, success=False)


def checkIfDteExists(authNumber: str):
    dte = DTEDocument.query.filter_by(
        authNumber=authNumber
    ).first()
    return dte is not None


def convertStringToDatetime(strDate: str):
    pattern = r"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3})?(?:-?\d{2}:\d{2})?"
    # Check if the string matches the pattern
    if re.match(pattern, strDate):
        # String matches the pattern, so proceed with parsing

        format_string = "%Y-%m-%dT%H:%M:%S"

    # Check if ".000" is present and adjust the format string accordingly
        if "." in strDate:
            format_string += ".%f"

        # Check if the timezone is present and adjust the format string accordingly
        if strDate.endswith("Z"):
            format_string += "Z"

        if strDate.endswith('-06:00'):
            format_string += "%z"

        date_obj = datetime.strptime(strDate, format_string)
        return date_obj


def findCertifier(nit: str):
    return CertifierDte.query.filter_by(nitCertifier=nit).first()


def findEmitter(nit: str):
    return EmitterDTE.query.filter_by(nit=nit).first()


def findEstablishment(code: str, emitter: EmitterDTE):
    return db.session.query(Establishment).with_parent(emitter).filter(Establishment.establishmentCode == code).first()


def findReceptor(nitReceptor: str):
    return DTEReceptor.query.filter_by(
        nit=nitReceptor
    ).first()


def findDocumentEstatus(IsMarkedCancelled: str):
    if (IsMarkedCancelled == "No"):
        return DteDocumentEstatus.query.filter_by(
            idDteDocumentEstatus=1
        ).first()
    else:
        return DteDocumentEstatus.query.filter_by(
            idDteDocumentEstatus=2
        ).first()
