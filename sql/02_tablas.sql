CREATE TABLE tbPropiedadesPrecios
(
	idPropiedadPrecio			"guid"		NOT NULL
	,CuotaInicio				integer		DEFAULT 0
	,CuotaFin					integer		DEFAULT 0
	,nMonto						float		DEFAULT 0
	,refPropiedad				"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
);

alter table tbContratos add nDiaVencimiento integer default 10;
alter table tbContratos add bAlqGarantizado smallint default 0;

drop table tbLiqInqMeses;

CREATE TABLE tbLiqInqMeses
(
	idLiqInqMes		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'	NOT NULL
	, refContratoCobro	"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, refLiqCabecera		"guid"		DEFAULT '{00000000-0000-0000-0000-000000000000}'
	, fVencimiento			date
	, nMonto	  		    float			DEFAULT 0
	, nPunitorios			float			DEFAULT 0
	, nTotal				float			DEFAULT	0 	
	, nMes					integer			DEFAULT 0
	, nAno					integer			DEFAULT 0
	, bVisible				smallint		DEFAULT 1
);
