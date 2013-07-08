alter table tbUsuarios add pPropiedades varchar(4) DEFAULT 'N';
alter table tbUsuarios add pPropietarios varchar(4) DEFAULT 'N';
alter table tbUsuarios add pInquilinos varchar(4) DEFAULT 'N';
alter table tbUsuarios add pContratos varchar(4) DEFAULT 'N';
alter table tbUsuarios add pCajaInquilinos varchar(4) DEFAULT 'N';
alter table tbUsuarios add pCajaMovimientos varchar(4) DEFAULT 'N';
alter table tbUsuarios add pCajaPropietarios varchar(4) DEFAULT 'N';
alter table tbUsuarios add pCajaPropietarios varchar(4) DEFAULT 'N';
alter table tbUsuarios add pAplicacion varchar (4) DEFAULT 'N';
alter table tbLiqInqGastos add refContrato "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}';
alter table tbLiqInqGastos add bVisible int DEFAULT 1;
alter table tbLiqInqCaja add refContrato "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}';
alter table tbliqInqDescuentos add refContrato "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}';
alter table tbLiqInqDescuentos add bVisible int DEFAULT 1;
alter table tbLiqInqPagares add bVisible int DEFAULT 1;

CREATE TABLE tugCajaTipoMovimientos
(
   idCajaTipoMovimiento      int 		DEFAULT -1
  ,TipoMovimiento            varchar (50) 
  ,refOperacion              integer DEFAULT 0
  ,refAfecta                 integer DEFAULT 0
  ,bVisible			  smallint	    DEFAULT 1

);

CREATE GENERATOR genCajaTipoMovimiento;
SET GENERATOR genCajaTipoMovimiento TO 3;
 
DROP TRIGGER ins_tugCajaTipoMovimientos ;

SET TERM ^ ;

CREATE TRIGGER ins_tugCajaTipoMovimientos FOR tugCajaTipoMovimientos
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idCajaTipoMovimiento = -1) then
   New.idCajaTipoMovimiento = GEN_ID(genCajaTipoMovimiento,1);
END^

SET TERM ; ^

INSERT INTO tugCajaTipoMovimientos
(idCajaTipoMovimiento, TipoMovimiento, refOperacion, refAfecta, bVisible)
VALUES
(0,'DESCONOCIDO', 0,0,0);

INSERT INTO tugCajaTipoMovimientos
(idCajaTipoMovimiento, TipoMovimiento, refOperacion, refAfecta, bVisible)
VALUES
(1,'LIQUIDACION',0,0,1);

INSERT INTO tugCajaTipoMovimientos
(idCajaTipoMovimiento, TipoMovimiento, refOperacion, refAfecta, bVisible)
VALUES
(1,'PAGO',2,0,1);

INSERT INTO tugCajaTipoMovimientos
(idCajaTipoMovimiento, TipoMovimiento, refOperacion, refAfecta, bVisible)
VALUES
(2,'COBRO',1,0,1);
