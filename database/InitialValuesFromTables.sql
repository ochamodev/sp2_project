INSERT INTO proyectosp2.dtedocumentestatus(idDteDocumentEstatus, descriptionEstatus)
	VALUES(1, 'Vigente');
    
INSERT INTO proyectosp2.dtedocumentestatus(idDteDocumentEstatus, descriptionEstatus)
	VALUES(2, 'Anulado');
    
SELECT * FROM proyectosp2.dtedocumentestatus;
    
INSERT INTO proyectosp2.dtereceptor(nit, fullnameReceptor)
	VALUES('CF', 'CONSUMIDOR FINAL');


DELETE FROM dtedocument
	WHERE idDTEDocument >=1;