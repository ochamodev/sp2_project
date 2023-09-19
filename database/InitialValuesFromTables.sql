USE ProyectoSP2;

INSERT INTO proyectosp2.dtedocumentestatus(descriptionEstatus)
	VALUES('Vigente');
    
INSERT INTO proyectosp2.dtedocumentestatus(descriptionEstatus)
	VALUES('Anulado');
    
SELECT * FROM proyectosp2.dtedocumentestatus;
    
INSERT INTO proyectosp2.dtereceptor(nit, fullnameReceptor)
	VALUES('CF', 'CONSUMIDOR FINAL');
