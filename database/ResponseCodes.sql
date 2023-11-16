USE proyectosp2;


INSERT INTO responseCodes(respCode, respDescription)
	VALUES('U0','Cuenta creada');
    
INSERT INTO responseCodes(respCode, respDescription)
	VALUES('U1','No se pudo crear la cuenta');
    
INSERT INTO responseCodes(respCode, respDescription)
	VALUES('U2','Inicio de sesión exitoso');

INSERT INTO responseCodes(respCode, respDescription)
	VALUES('U3','No existe una cuenta con esos datos');

INSERT INTO responseCodes(respCode, respDescription)
	VALUES('U4','La cuenta ya existe');
    
INSERT INTO responseCodes(respCode, respDescription)
	VALUES('E0','Ya se registro la empresa con ese NIT');


INSERT INTO proyectosp2.dtedocumentestatus(idDteDocumentEstatus, descriptionEstatus)
	VALUES(1, 'Vigente');
    
INSERT INTO proyectosp2.dtedocumentestatus(idDteDocumentEstatus, descriptionEstatus)
	VALUES(2, 'Anulado');