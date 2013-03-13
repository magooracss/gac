unit dminquilinos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral;

type

  { TDM_Inquilinos }

  TDM_Inquilinos = class(TDataModule)
    qBusDocumento: TZQuery;
    qBusCuit: TZQuery;
    tbInquilinos: TRxMemoryData;
    qBusApellido: TZQuery;
    tbInquilinoscEmail: TStringField;
    tbInquilinoscTelFijo: TStringField;
    tbInquilinoscTelMovil: TStringField;
    tbResultados: TRxMemoryData;
    tbInquilinosbVisible: TLongintField;
    tbInquilinoscApellidos: TStringField;
    tbInquilinoscNombres: TStringField;
    tbInquilinosCUIT: TStringField;
    tbInquilinosDocumento: TStringField;
    tbInquilinosidInquilino: TStringField;
    tbInquilinosrefTipoDocumento: TLongintField;
    tbInquilinostxNotas: TStringField;
    tbInquilinosDEL: TZQuery;
    tbInquilinosINS: TZQuery;
    tbInquilinosSEL: TZQuery;
    tbInquilinosUPD: TZQuery;
    tbResultadosbVisible: TLongintField;
    tbResultadoscApellidos: TStringField;
    tbResultadoscNombres: TStringField;
    tbResultadosCUIT: TStringField;
    tbResultadosDocumento: TStringField;
    tbResultadosidInquilino: TStringField;
    tbResultadosrefTipoDocumento: TLongintField;
    tbResultadostxNotas: TStringField;
    procedure tbInquilinosAfterInsert(DataSet: TDataSet);
  private
    function getApellido: string;
    function getIdInquilinoSeleccionado: GUID_ID;
    procedure setTipoDocumento(const AValue: integer);
    function Buscar (var laTabla: TZQuery; elParametro: string): boolean;
  public
    property refTipoDocumento:integer write setTipoDocumento;
    property Apellido: string read getApellido;
    property idInquilinoSeleccionado: GUID_ID read getIdInquilinoSeleccionado;
    procedure Grabar;
    procedure LevantarInquilino (refInquilino: GUID_ID);
    procedure Nuevo;
    procedure BorrarInquilino (refInquilino: GUID_ID);

    procedure InicializarBusquedas;
    function BuscarInquilinoApellido (dato: string): boolean;
    function BuscarInquilinoDocumento (dato: string): boolean;
    function BuscarInquilinoCUIT (dato: string): boolean;
  end; 

var
  DM_Inquilinos: TDM_Inquilinos;

implementation

{$R *.lfm}

{ TDM_Inquilinos }

procedure TDM_Inquilinos.tbInquilinosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idInquilino').AsString:= DM_General.CrearGUID;
    FieldByName('refTipoDocumento').asInteger:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

function TDM_Inquilinos.getApellido: string;
begin
  with tbInquilinos do
  begin
    if ((active) and (RecordCount > 0)) then
    begin
      Result:= FieldByName('cApellidos').asString;
    end
    else
      Result:= EmptyStr;
  end;
end;

function TDM_Inquilinos.getIdInquilinoSeleccionado: GUID_ID;
begin
  with tbResultados do
  begin
    if ((active) and (RecordCount > 0)) then
    begin
      Result:= FieldByName('idinquilino').asString;
    end;
  end;
end;

procedure TDM_Inquilinos.setTipoDocumento(const AValue: integer);
begin
  with tbInquilinos do
  begin
    Edit;
    FieldByName('refTipoDocumento').asInteger:= AValue;
    Post;
  end;
end;

function TDM_Inquilinos.Buscar(var laTabla: TZQuery; elParametro: string
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

procedure TDM_Inquilinos.Grabar;
begin
  DM_General.GrabarDatos(tbInquilinosSEL, tbInquilinosINS, tbInquilinosUPD, tbInquilinos,'idInquilino');
end;

procedure TDM_Inquilinos.LevantarInquilino(refInquilino: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbInquilinos);
  with tbInquilinosSEL do
  begin
    if active then close;
    ParamByName('idInquilino').asString:= refInquilino;
    Open;

    tbInquilinos.LoadFromDataSet(tbInquilinosSEL, 0, lmAppend);

    close;
  end;
end;

procedure TDM_Inquilinos.Nuevo;
begin
  DM_General.ReiniciarTabla(tbInquilinos);
  tbInquilinos.Insert;
end;

procedure TDM_Inquilinos.BorrarInquilino(refInquilino: GUID_ID);
begin
  with tbInquilinosDEL do
  begin
    ParamByName('idInquilino').asString:= refInquilino;
    ExecSQL;
  end;
end;

procedure TDM_Inquilinos.InicializarBusquedas;
begin
  DM_General.ReiniciarTabla(tbResultados);
end;

function TDM_Inquilinos.BuscarInquilinoApellido(dato: string): boolean;
begin
  Result:= Buscar (qBusApellido, dato);
end;

function TDM_Inquilinos.BuscarInquilinoDocumento(dato: string): boolean;
begin
  Result:= Buscar (qBusDocumento, dato);
end;

function TDM_Inquilinos.BuscarInquilinoCUIT(dato: string): boolean;
begin
  Result:= Buscar (qBusCuit, dato);
end;

end.

