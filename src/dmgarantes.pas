unit dmgarantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral;

type

  { TDM_Garantes }

  TDM_Garantes = class(TDataModule)
    qBusDocumento: TZQuery;
    qBusCuit: TZQuery;
    tbGarantes: TRxMemoryData;
    qBusApellido: TZQuery;
    tbGarantesbVisible: TLongintField;
    tbGarantescApellidos: TStringField;
    tbGarantescEmail: TStringField;
    tbGarantescNombres: TStringField;
    tbGarantescTelFijo: TStringField;
    tbGarantescTelMovil: TStringField;
    tbGarantesCUIT: TStringField;
    tbGarantesDocumento: TStringField;
    tbGarantesidGarante: TStringField;
    tbGarantesrefTipoDocumento: TLongintField;
    tbGarantestxNotas: TStringField;
    tbResultados: TRxMemoryData;
    tbGarantesDEL: TZQuery;
    tbGarantesINS: TZQuery;
    tbGarantesSEL: TZQuery;
    tbGarantesUPD: TZQuery;
    tbResultadosbVisible: TLongintField;
    tbResultadoscApellidos: TStringField;
    tbResultadoscNombres: TStringField;
    tbResultadosCUIT: TStringField;
    tbResultadosDocumento: TStringField;
    tbResultadosidGarante: TStringField;
    tbResultadosrefTipoDocumento: TLongintField;
    tbResultadostxNotas: TStringField;
    procedure tbGarantesAfterInsert(DataSet: TDataSet);
  private
    function getApellido: string;
    function getIdGaranteSeleccionado: GUID_ID;
    procedure setTipoDocumento(const AValue: integer);
    function Buscar (var laTabla: TZQuery; elParametro: string): boolean;
  public
    property refTipoDocumento:integer write setTipoDocumento;
    property Apellido: string read getApellido;
    property idGaranteSeleccionado: GUID_ID read getIdGaranteSeleccionado;
    procedure Grabar;
    procedure LevantarGarante (refGarante: GUID_ID);
    procedure Nuevo;
    procedure BorrarGarante (refGarante: GUID_ID);

    procedure InicializarBusquedas;
    function BuscarGaranteApellido (dato: string): boolean;
    function BuscarGaranteDocumento (dato: string): boolean;
    function BuscarGaranteCUIT (dato: string): boolean;
  end; 

var
  DM_Garantes: TDM_Garantes;

implementation

{$R *.lfm}

{ TDM_Garantes }

procedure TDM_Garantes.tbGarantesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idGarante').AsString:= DM_General.CrearGUID;
    FieldByName('refTipoDocumento').asInteger:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

function TDM_Garantes.getApellido: string;
begin
  with tbGarantes do
  begin
    if ((active) and (RecordCount > 0)) then
    begin
      Result:= FieldByName('cApellidos').asString;
    end
    else
      Result:= EmptyStr;
  end;
end;

function TDM_Garantes.getIdGaranteSeleccionado: GUID_ID;
begin
  with tbResultados do
  begin
    if ((active) and (RecordCount > 0)) then
    begin
      Result:= FieldByName('idGarante').asString;
    end;
  end;
end;

procedure TDM_Garantes.setTipoDocumento(const AValue: integer);
begin
  with tbGarantes do
  begin
    Edit;
    FieldByName('refTipoDocumento').asInteger:= AValue;
    Post;
  end;
end;

function TDM_Garantes.Buscar(var laTabla: TZQuery; elParametro: string
  ): boolean;
begin
  DM_General.ReiniciarTabla(tbResultados);
  With laTabla do
  begin
    if active then close;
    ParamByName('parametro').AsString:= elParametro;
    Open;
    tbResultados.LoadFromDataSet(laTabla, 0, lmAppend);
    Result:= (tbResultados.RecordCount > 0);
    close;
  end;
end;

procedure TDM_Garantes.Grabar;
begin
  DM_General.GrabarDatos(tbGarantesSEL, tbGarantesINS, tbGarantesUPD, tbGarantes,'idGarante');
end;

procedure TDM_Garantes.LevantarGarante(refGarante: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbGarantes);
  with tbGarantesSEL do
  begin
    if active then close;
    ParamByName('idGarante').asString:= refGarante;
    Open;

    tbGarantes.LoadFromDataSet(tbGarantesSEL, 0, lmAppend);

    close;
  end;
end;

procedure TDM_Garantes.Nuevo;
begin
  DM_General.ReiniciarTabla(tbGarantes);
  tbGarantes.Insert;
end;

procedure TDM_Garantes.BorrarGarante(refGarante: GUID_ID);
begin
  with tbGarantesDEL do
  begin
    ParamByName('idGarante').asString:= refGarante;
    ExecSQL;
  end;
end;

procedure TDM_Garantes.InicializarBusquedas;
begin
  DM_General.ReiniciarTabla(tbResultados);
end;

function TDM_Garantes.BuscarGaranteApellido(dato: string): boolean;
begin
  Result:= Buscar (qBusApellido, dato);
end;

function TDM_Garantes.BuscarGaranteDocumento(dato: string): boolean;
begin
  Result:= Buscar (qBusDocumento, dato);
end;

function TDM_Garantes.BuscarGaranteCUIT(dato: string): boolean;
begin
  Result:= Buscar (qBusCuit, dato);
end;

end.

