CREATE DOMAIN "guid"
  AS VARCHAR(38)
  CHARACTER SET ASCII
  DEFAULT '{00000000-0000-0000-0000-000000000000}';

CREATE TABLE tbPropiedades
(
		idPropiedad			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	, calle						varchar(500)
	,	altura					varchar(20)
	,	refLocalidad		integer		DEFAULT 0
	, refTipo					integer		DEFAULT 0
	, fAlta						date
	, txDatosGenerales	blob sub_type 0
	, nAlquiler				float			DEFAULT 0
	, nExpensas				float			DEFAULT 0
	, txNotasPropietarios		blob
	, bVisible				smallint	DEFAULT 1
);

CREATE TABLE tbPropiedadesFotos
(
		idPropiedadFoto	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	, refPropiedad		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	titulo					varchar (500)
	,	foto						blob		
);


CREATE TABLE tugLocalidades 
(
   idLocalidad        int 		DEFAULT -1
  ,Localidad          varchar (250) 
  ,CodigoPostal       varchar (15) 
  ,bVisible			  smallint	    DEFAULT 1
);
 

CREATE GENERATOR genLocalidad;
SET GENERATOR genLocalidad TO 2;
 
DROP TRIGGER ins_tugLocalidad ;

SET TERM ^ ;

CREATE TRIGGER ins_tugLocalidad FOR tugLocalidades
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idLocalidad = -1) then
   New.idLocalidad = GEN_ID(genLocalidad,1);
END^

SET TERM ; ^

INSERT INTO tugLocalidades
(idLocalidad, Localidad, CodigoPostal, bVisible)
VALUES
(0,'DESCONOCIDO', 'DESCONOCIDO',0);

INSERT INTO tugLocalidades
(idLocalidad, Localidad, CodigoPostal, bVisible)
VALUES
(1,'La Plata', '1900',1);

INSERT INTO tugLocalidades
(idLocalidad, Localidad, CodigoPostal, bVisible)
VALUES
(2,'Rio Grande', '9420',1);


	CREATE TABLE tugTiposDocumento (
	   idTipoDocumento     int  		DEFAULT -1
	  ,tipoDocumento       varchar (250) 
	  ,abTipoDocumento     varchar (5)
	  ,bVisible			   smallint	    DEFAULT 1
	  );
 

CREATE GENERATOR genTipoDocumento;
SET GENERATOR genTipoDocumento TO 0;
 
DROP TRIGGER ins_tugTipoDocumento ;

SET TERM ^ ;

CREATE TRIGGER ins_tugTipoDocumento FOR tugTiposDocumento
ACTIVE BEFORE INSERT POSITION 3
AS
BEGIN
  If (New.idTipoDocumento = -1) then
   New.idTipoDocumento = GEN_ID(genTipoDocumento,1);
END^

SET TERM ; ^

INSERT INTO tugTiposDocumento
(idTipoDocumento, tipoDocumento, abTipoDocumento, bVisible)
VALUES
(0,'DESCONOCIDO', 'DESC.',0);

INSERT INTO tugTiposDocumento
(idTipoDocumento, tipoDocumento, abTipoDocumento, bVisible)
VALUES
(1,'Documento Nacional de Identidad', 'DNI',1);

INSERT INTO tugTiposDocumento
(idTipoDocumento, tipoDocumento, abTipoDocumento, bVisible)
VALUES
(2,'Libreta Cívica', 'LC',1);

INSERT INTO tugTiposDocumento
(idTipoDocumento, tipoDocumento, abTipoDocumento, bVisible)
VALUES
(3,'Pasaporte', 'PAS',1);


CREATE TABLE tbDomicilios 
(
   idDomicilio        "guid"	DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
  ,	Direccion         varchar (250) 
  ,	refLocalidad      integer      DEFAULT 0
  ,	txNotas           blob
  ,	refRelacion		   	"guid" NOT NULL	 
  ,	bVisible			   	smallint	    DEFAULT 1
);


CREATE TABLE tbContactos
(
    idContacto       "guid" DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
  ,	Contacto	        varchar (250) 
  ,	refTipoContacto   integer       DEFAULT 0
  ,	txNotas          	blob
  ,	refRelacion		   	"guid" NOT NULL	 
  ,	bVisible			   	smallint	    DEFAULT 1
);


CREATE TABLE tugTiposContacto 
(
   idTipoContacto     int 		DEFAULT -1
  ,tipoContacto       varchar (50) 
  ,bVisible			  smallint	    DEFAULT 1
);
 

CREATE GENERATOR genTipoContacto;
SET GENERATOR genTipoContacto TO 0;
 
DROP TRIGGER ins_tugTipoContacto ;

SET TERM ^ ;

CREATE TRIGGER ins_tugTipoContacto FOR tugTiposContacto
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
  If (New.idTipoContacto = -1) then
   New.idTipoContacto = GEN_ID(genTipoContacto,1);
END^

SET TERM ; ^

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(0,'DESCONOCIDO',0);

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(1,'Telefono',1);

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(2,'FAX',1);

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(3,'Correo electronico',1);

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(4,'Web',1);

INSERT INTO tugTiposContacto
(idTipoContacto, tipoContacto, bVisible)
VALUES
(5,'Celular',1);



CREATE TABLE tugPropiedadesTipos 
(
    idPropiedadTipo		integer 		DEFAULT -1
  , propiedadTipo      varchar (250) 
  , bVisible		    	  smallint	  DEFAULT 1
);
 

CREATE GENERATOR genPropiedadTipo;
SET GENERATOR genPropiedadTipo TO 5;
 
DROP TRIGGER ins_tugPropiedadesTipos ;

SET TERM ^ ;

CREATE TRIGGER ins_tugPropiedadesTipos FOR tugPropiedadesTipos
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idPropiedadTipo = -1) then
   New.idPropiedadTipo = GEN_ID(genPropiedadTipo,1);
END^

SET TERM ; ^

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(0,'DESCONOCIDO',0);

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(1,'Departamento', 1);

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(2,'Casa', 1);

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(3,'Chalet', 1);

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(4,'Local', 1);

INSERT INTO tugPropiedadesTipos
(idPropiedadTipo, propiedadTipo, bVisible)
VALUES
(5,'Monoambiente', 1);

CREATE TABLE tbPropietarios
(
		idPropietario		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	cApellidos			varchar (500)
	,	cNombres				varchar (500)
	,	refTipoDocumento	integer	DEFAULT 0
	,	documento				varchar (20)
	,	CUIT						varchar	(20)
	,	fAlta						date
	,	txNotas					blob
);

CREATE TABLE tbPropietariosBancos
(
		idPropietarioBanco	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	refPropietario			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	, refBanco						integer		DEFAULT 0
	, cuenta							varchar(50)
	, CBU									varchar(20)
	, txNotas							blob
	, bVisible						smallint	DEFAULT 1 
);



CREATE TABLE tugBancos 
(
    idBanco						integer 		DEFAULT -1
  , Banco							varchar (250) 
  , bVisible		    	smallint	  DEFAULT 1
);
 

CREATE GENERATOR genTugBancos;
SET GENERATOR genTugBancos TO 3;
 
DROP TRIGGER ins_tugBancos ;

SET TERM ^ ;

CREATE TRIGGER ins_tugBancos FOR tugBancos
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idBanco = -1) then
   New.idBanco = GEN_ID(genTugBancos,1);
END^

SET TERM ; ^

INSERT INTO tugBancos
(idBanco, Banco, bVisible)
VALUES
(0,'DESCONOCIDO',0);

INSERT INTO tugBancos
(idBanco, Banco, bVisible)
VALUES
(1,'Nacion', 1);

INSERT INTO tugBancos
(idBanco, Banco, bVisible)
VALUES
(2,'Provincia', 1);

INSERT INTO tugBancos
(idBanco, Banco, bVisible)
VALUES
(3,'Patagonia', 1);

CREATE TABLE tbInquilinos
(
		idInquilino		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	cApellidos		varchar(500)
	,	cNombres			varchar(500)
	, refTipoDocumento	integer	DEFAULT 0
	, documento			varchar(20)
	, CUIT					varchar(20)
	, txNotas				blob
	, bVisible			smallint	DEFAULT 1
);

CREATE TABLE tbGarantes
(
		idGarante 		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	cApellidos		varchar(500)
	,	cNombres			varchar(500)
	, refTipoDocumento	integer	DEFAULT 0
	, documento			varchar(20)
	, CUIT					varchar(20)
	, txNotas				blob
	, bVisible			smallint	DEFAULT 1
);

CREATE TABLE tbContratos
(
		idContrato		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	carpeta				integer		DEFAULT 0
	, codigo				varchar (50)
	, refTipoContrato	integer	DEFAULT 0
	, fInicio				date
	, fFinalizacion	date
	, nSena					float			DEFAULT 0
	, nPorcGastosAdm	float			DEFAULT 0
	, nSellado			float			DEFAULT 0
	, nHonorarios		float			DEFAULT 0
	, nPorcPunitoriosDiarios float	DEFAULT 0
	, bLiqPropietarioBanco	smallint	DEFAULT 0
	, refCuentaPropietario	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 
	,	txNotas				blob
	,	bVisible			smallint	DEFAULT 1
);



CREATE TABLE tugContratosTipos 
(
    idContratoTipo		integer 		DEFAULT -1
  , ContratoTipo			varchar (250) 
  , bVisible		    	smallint	  DEFAULT 1
);
 

CREATE GENERATOR genTugContratosTipo;
SET GENERATOR genTugContratosTipo TO 2;
 
DROP TRIGGER ins_tugContratosTipo ;

SET TERM ^ ;

CREATE TRIGGER ins_tugContratosTipo FOR tugContratosTipos
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idContratoTipo = -1) then
   New.idContratoTipo = GEN_ID(genTugContratosTipo,1);
END^

SET TERM ; ^

INSERT INTO tugContratosTipos
(idContratoTipo, ContratoTipo, bVisible)
VALUES
(0,'DESCONOCIDO',0);

INSERT INTO tugContratosTipos
(idContratoTipo, ContratoTipo, bVisible)
VALUES
(1,'Alquiler', 1);

INSERT INTO tugContratosTipos
(idContratoTipo, ContratoTipo, bVisible)
VALUES
(2,'Renovacion', 1);

CREATE TABLE tbGastosMensuales
(
		idGastoMensual	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	refContrato			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 
	, refGasto				integer		DEFAULT 0
	, nMonto					float			DEFAULT 0
	, bInquilino			smallint	DEFAULT 0
	, bPropietario		smallint	DEFAULT 0
	, bVisible				smallint	DEFAULT 1
);



CREATE TABLE tugGastosMensuales
(
    idGastoMensual		integer 		DEFAULT -1
	,	GastoMensual			varchar (250) 
	,	nMonto						float				DEFAULT 0
	,	bVisible		    	smallint	  DEFAULT 1
);
 

CREATE GENERATOR genTugGastosMensuales;
SET GENERATOR genTugGastosMensuales TO 2;
 
DROP TRIGGER ins_tugGastosMensuales ;

SET TERM ^ ;

CREATE TRIGGER ins_tugGastosMensuales FOR tugGastosMensuales
ACTIVE BEFORE INSERT POSITION 0
AS
BEGIN
  If (New.idGastoMensual = -1) then
   New.idGastoMensual = GEN_ID(genTugGastosMensuales,1);
END^

SET TERM ; ^

INSERT INTO tugGastosMensuales
(idGastoMensual, GastoMensual, nMonto ,bVisible)
VALUES
(0,'DESCONOCIDO', 0, 0);

INSERT INTO tugGastosMensuales
(idGastoMensual, GastoMensual, nMonto, bVisible)
VALUES
(1,'Expensas', 0 ,1);

INSERT INTO tugGastosMensuales
(idGastoMensual, GastoMensual, nMonto, bVisible)
VALUES
(2,'Telefono', 0, 1);

CREATE TABLE tbContratosCobros
(
		idContratoCobro		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,	refContrato				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 
	,	fVencimiento			date
	,	nMonto						float			DEFAULT 0
	,	nMes							integer		DEFAULT 0
	,	nAno							integer		DEFAULT	0
	,	nPagado						float			DEFAULT 0
);

CREATE TABLE tbContratosPagares
(
		idContratoPagare	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 	
	,	refContrato				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, fVencimiento			date
	,	nMonto						float			DEFAULT 0
	, bCobrado					smallint	DEFAULT 0
);

CREATE TABLE tbReparaciones
(
	idReparacion			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refPropiedad		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 	
	,	fReclamo				date
	,	txReclamo				blob
	,	refTomadoPor		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' 	
	,	fReparacion			date
	,	txReparacion		blob
	,	nMonto					float		DEFAULT 0
	,	nMontoPropietario	float		DEFAULT 0
	,	bCobroPropietario	smallint	DEFAULT 1
	,	nMontoInquilino		float		DEFAULT 0
	,	bMontoInquilino		smallint	DEFAULT 0
	,	bVisible				smallint	DEFAULT 1
);

CREATE TABLE tbUsuarios
(
	idUsuario				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	Usuario				varchar(15)	DEFAULT 'usuario'
	,	clave					varchar(15) DEFAULT	'123456'
	,	bVisible			smallint	DEFAULT 1
);

CREATE TABLE tbMovimientosCaja
(
	idMovimientoCaja		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	fecha					date
	,	refLiquidacion		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	Factura				varchar(50)
	,	Recibo				varchar(50)
	,	fFactura			date
	,	fRecibo				date
	,	nMonto				float		DEFAULT 0
	,	tipoMovimiento		varchar(1)	
);

CREATE TABLE tbLiqInqCabecera
(
	idLiqInqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	fecha					date
	,	Nro						int			DEFAULT -1
	,	Monto					float		DEFAULT 0
	,	bAnulada			smallint	DEFAULT 0
	,	fAnulada			date
	,	txNota				blob
	,	refInquilino	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	refContrato		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);	

CREATE TABLE tbLiqInqMeses
(
	idLiqInqMes		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refContratoCobro	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, refLiqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, fVencimiento			date
	,	nMonto						float			DEFAULT 0
	, nPunitorios				float			DEFAULT 0
	,	nTotal						float			DEFAULT	0 	
);

CREATE TABLE tbLiqInqPagares
(
	idLiqInqPagare			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refLiqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	
	,	refContratoPagare	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	fVencimiento			date
	,	nMonto						float
	,	nPunitorios				float
	,	nTotal						float
);

CREATE TABLE tbLiqInqGastos
(
	idLiqInqGasto				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refLiqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	refReparacion			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	gasto							varchar(500)
	,	nMonto						float			DEFAULT 0
);

CREATE TABLE tbLiqInqDescuentos
(
	idLiqInqDescuento		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refLiqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	descuento					varchar(500)
	,	nMonto						float			DEFAULT 0
);

CREATE TABLE tbLiqPropCabecera
(
	idLiquPropCabecera	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	fecha							date
	,	nro								integer		DEFAULT -1
	,	nMonto						float			DEFAULT 0
	,	bAnulada					smallint	DEFAULT 0
	,	fAnulada					date
	,	txNotas						blob
);

CREATE TABLE tbLiqPropPagos
(
	idLiqPropPago				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	nMes							integer 	DEFAULT 0
	,	nAno							integer		DEFAULT 0
	, nMonto						float			DEFAULT 0
	,	refLiqPropCabecera	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

CREATE TABLE tbLiqPropDescuentos
(
	idLiqPropDescuento	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	,	refLiqPropCabecera	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	refReparacion			"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,	gasto							varchar(500)
	,	nMonto						float			DEFAULT 0
);

CREATE TABLE trPropietariosPropiedades
(
	idPropietarioPropiedad		 	  "guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,refPropietario								"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refPropiedad									"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

CREATE TABLE trContratosInquilinos
(
	idContratoInquilino		 	  "guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL
	,refContrato								"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	,refInquilino									"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);
