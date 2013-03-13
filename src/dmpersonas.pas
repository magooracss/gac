unit dmpersonas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_Personas }

  TDM_Personas = class(TDataModule)
    qBancoPorID: TZQuery;
    tbDomicilios: TRxMemoryData;
    tbContactos: TRxMemoryData;
    tbPersonas: TRxMemoryData;
    tbDomiciliosDEL: TZQuery;
    tbContactosDEL: TZQuery;
    tbDomiciliosINS: TZQuery;
    tbContactosINS: TZQuery;
    tbPersonasSEL: TZQuery;
    tbPersonasINS: TZQuery;
    tbDomiciliosSEL: TZQuery;
    tbContactosSEL: TZQuery;
    tugLocalidades: TZQuery;
    qLocalidadPorID: TZQuery;
    qTipoContactoPorID: TZQuery;
    tugTiposDoc: TZQuery;
    tbPersonasUPD: TZQuery;
    tbPersonasDEL: TZQuery;
    tbDomiciliosUPD: TZQuery;
    tbContactosUPD: TZQuery;
    tugTiposContacto: TZQuery;
  private
    { private declarations }
  public
    function TipoContacto (idTipoContacto: integer):string;
    function ObtenerLocalidad (idLocalidad: integer): string;
    function ObtenerBanco (idBanco: integer): string;
  end; 

var
  DM_Personas: TDM_Personas;

implementation

{$R *.lfm}

{ TDM_Personas }

function TDM_Personas.TipoContacto(idTipoContacto: integer): string;
begin
  with qTipoContactoPorID do
  begin
    if active then close;
    ParamByName('idTipoContacto').asInteger:= idTipoContacto;
    Open;
    if RecordCount > 0 then
     Result:= FieldByName('TipoContacto').asString
    else
      Result:= EmptyStr;
  end;
end;

function TDM_Personas.ObtenerLocalidad(idLocalidad: integer): string;
begin
  with qLocalidadPorID do
  begin
    if active then close;
    ParamByName('idLocalidad').asInteger:= idLocalidad;
    Open;
    if RecordCount > 0 then
     Result:= FieldByName('Localidad').asString
    else
      Result:= EmptyStr;
  end;
end;

function TDM_Personas.ObtenerBanco(idBanco: integer): string;
begin
  with qBancoPorID do
  begin
    if active then close;
    ParamByName('idBanco').asInteger:= idBanco;
    Open;
    if RecordCount > 0 then
     Result:= FieldByName('Banco').asString
    else
      Result:= EmptyStr;
  end;
end;

end.

