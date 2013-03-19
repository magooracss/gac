CREATE TABLE tugTiposLiquidaciones 
(
   idTipoLiquidacion   int  		DEFAULT -1
  ,tipoLiquidacion       varchar (250) 
  ,bVisible			   smallint	    DEFAULT 1
);
 

CREATE GENERATOR genTipoLiquidacion;


SET GENERATOR genTipoLiquidacion TO 4;
 
SET TERM ^ ;

CREATE TRIGGER ins_tugTipoLiquidacion FOR tugTiposLiquidaciones
ACTIVE BEFORE INSERT POSITION 3
AS
BEGIN
  If (New.idTipoLiquidacion = -1) then
   New.idTipoLiquidacion = GEN_ID(genTipoLiquidacion,1);
END^

SET TERM ; ^

INSERT INTO tugTiposLiquidaciones
(idTipoLiquidacion, tipoLiquidacion, bVisible)
VALUES
(0,'DESCONOCIDO',0);

INSERT INTO tugTiposLiquidaciones
(idTipoLiquidacion, tipoLiquidacion, bVisible)
VALUES
(1,'Mensualidad',1);

INSERT INTO tugTiposLiquidaciones
(idTipoLiquidacion, tipoLiquidacion, bVisible)
VALUES
(2,'Gastos Administrativos',1);

INSERT INTO tugTiposLiquidaciones
(idTipoLiquidacion, tipoLiquidacion, bVisible)
VALUES
(3,'Gastos Reparaciones',1);

CREATE TABLE tbLiqInqCaja
(
     idLiqInqCaja          "guid"
    , refLiqInqCabecera    "guid"
    , Descripcion          varchar(1000)
    , Monto                float
    , fVencimiento         date
    , fPago                date
    , Pagado               float
    , refTipo              smallint
    , referencia           "guid"
    , bVisible             smallint default 1
);
