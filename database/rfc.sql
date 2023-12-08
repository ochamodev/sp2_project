USE proyectosp2;

DROP PROCEDURE IF EXISTS RFC;

DELIMITER $$

CREATE PROCEDURE RFC(
    IN emitterID INT
)

BEGIN
	SELECT 
    Establishment.nitEmitter,
    YEAR(DteDocument.emissionDate) AS 'yearT',
    MONTH(DteDocument.emissionDate) AS 'monthT',
    DteDocument.emissionDate as 'date',
    DteDocument.idReceptor,
    DteDocument.amountGrandTotal as 'amount',
    DTEReceptor.fullnameReceptor as 'name'
	FROM DteDocument
	INNER JOIN Establishment
		ON Establishment.idEstablishment = DteDocument.idEstablishment
	INNER JOIN DTEReceptor
		ON DTEReceptor.idDteReceptor = DteDocument.idReceptor
	WHERE DteDocument.idDteDocumentEstatus = 1
		AND Establishment.nitEmitter = emitterID
		AND DTEReceptor.fullnameReceptor != "CONSUMIDOR FINAL";

END $$

DELIMITER ;

CALL RFC(1);