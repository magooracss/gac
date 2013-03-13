unit dmpropietarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmConexion
  , db
  , dmgeneral;

type

  { TDM_Propietarios }

  TDM_Propietarios = class(TDataModule)
    qBusDocumento: TZQuery;
    qBusCUIT: TZQuery;
    qtugBancos: TZQuery;
    qBancosProp: TZQuery;
    tbContactos: TRxMemoryData;
    tbBancos: TRxMemoryData;
    tbContactosDEL: TZQuery;
    tbBancosDEL: TZQuery;
    qContactosProp: TZQuery;
    tbContactosINS: TZQuery;
    tbBancosINS: TZQuery;
    tbContactosSEL: TZQuery;
    tbBancosSEL: TZQuery;
    tbContactosUPD: TZQuery;
    tbBancosUPD: TZQuery;
    tbDomicilios: TRxMemoryData;
    tbDomiciliosDEL: TZQuery;
    qDomiciliosProp: TZQuery;
    tbDomiciliosINS: TZQuery;
    tbDomiciliosSEL: TZQuery;
    tbDomiciliosUPD: TZQuery;
    tbPropietarios: TRxMemoryData;
    tbBusqueda: TRxMemoryData;
    tbPropietariosDEL: TZQuery;
    tbPropietariosINS: TZQuery;
    tbPropietariosSEL: TZQuery;
    qBusApellido: TZQuery;
    tbPropietariosUPD: TZQuery;
    procedure tbBancosAfterInsert(DataSet: TDataSet);
    procedure tbContactosAfterInsert(DataSet: TDataSet);
    procedure tbContactosAfterPost(DataSet: TDataSet);
    procedure tbDomiciliosAfterInsert(DataSet: TDataSet);
    procedure tbPropietariosAfterInsert(DataSet: TDataSet);
  private
    procedure CargarTablaDomicilio (direccion: string; idLocalidad: integer);
    procedure CargarTablaBancos (idBanco: integer; cuenta, cbu,
  Notas: string);
    function Buscar (var laTabla: TZQuery; elParametro: string): boolean;
    function getApellidoActual: string;
    function getDocumentoActual: string;
    function getIdBusquedaActual: GUID_ID;
    function getNombreActual: string;
    procedure ReiniciarTablasPropietario;
  public
    property idBusquedaActual: GUID_ID read getIdBusquedaActual;
    property Apellido: string read getApellidoActual;
    property Nombre: string read getNombreActual;
    property Documento: string read getDocumentoActual;

    procedure Nuevo;
    procedure Grabar;
    procedure BorrarPropietario (idPropietario: GUID_ID);
    procedure LevantarPropietario (idPropietario: GUID_ID);

    procedure AltaContacto (idFormaContacto: integer; Contacto: string);
    procedure EditarContacto (idFormaContacto: integer; Contacto: string);
    procedure EliminarContacto;


    procedure AltaDomicilio (direccion: String; idLocalidad: integer);
    procedure EditarDomicilio (direccion: String; idLocalidad: integer);
    procedure EliminarDomicilio;

    procedure AgregarBanco(idBanco: integer; cuenta, cbu, Notas: string);
    procedure EditarBanco(idBanco: integer; cuenta, cbu, Notas: string);
    procedure EliminarCuenta;

    procedure InicializarBusquedas;
    function BuscarPropietarioApellido (dato: string): boolean;
    function BuscarPropietarioDocumento (dato: string): boolean;
    function BuscarPropietarioCUIT (dato: string): boolean;
  end;

var
  DM_Propietarios: TDM_Propietarios;

implementation
{$R *.lfm}
uses
 dmpersonas
  ;

{ TDM_Propietarios }

procedure TDM_Propietarios.tbPropietariosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idPropietario').asString:= DM_General.CrearGUID;
    FieldByName('refTipoDocumento').asInteger:= 1;
    FieldByName('fAlta').AsDateTime:= Now;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;


procedure TDM_Propietarios.tbDomiciliosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idDomicilio').AsString:= DM_General.CrearGUID;
    FieldByName('refLocalidad').AsInteger:= 0;
    FieldByName('refRelacion').asString:= tbPropietarios.FieldByName('idPropietario').asString;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Propietarios.tbContactosAfterInsert(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('idContacto').asString:= DM_General.CrearGUID;
    FieldByName('refTipoContacto').asInteger:= 0;
    FieldByName('refRelacion').asString:= tbPropietarios.FieldByName('idPropietario').asString;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Propietarios.tbBancosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idPropietarioBanco').asString:= DM_General.CrearGUID;
    FieldByName('refBanco').asInteger:= 0;
    FieldByName('refPropietario').asString:= tbPropietarios.FieldByName('idPropietario').asString;
    FieldByName('CBU').asString:= EmptyStr;
    FieldByName('Cuenta').asString:= EmptyStr;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Propietarios.tbContactosAfterPost(DataSet: TDataSet);
begin
  with DataSet do
  begin
    Edit;
    FieldByName('lxTipoContacto').asString:= DM_Personas.TipoContacto(Dataset.FieldByName('refTipoContacto').AsInteger);
  end;
end;


procedure TDM_Propietarios.ReiniciarTablasPropietario;
begin
  DM_General.ReiniciarTabla(tbPropietarios);
  DM_General.ReiniciarTabla(tbContactos);
  DM_General.ReiniciarTabla(tbDomicilios);
  DM_General.ReiniciarTabla(tbBancos);
end;

procedure TDM_Propietarios.Nuevo;
begin
  ReiniciarTablasPropietario;
  tbPropietarios.Insert;
end;

procedure TDM_Propietarios.Grabar;
begin
  DM_General.GrabarDatos(tbPropietariosSEL, tbPropietariosINS, tbPropietariosUPD, tbPropietarios, 'idPropietario');
  DM_General.GrabarDatos(tbDomiciliosSEL, tbDomiciliosINS, tbDomiciliosUPD, tbDomicilios, 'idDomicilio');
  DM_General.GrabarDatos(tbContactosSEL, tbContactosINS, tbContactosUPD, tbContactos, 'idContacto');
  DM_General.GrabarDatos(tbBancosSEL, tbBancosINS, tbBancosUPD, tbBancos, 'idPropietarioBanco');
end;

procedure TDM_Propietarios.BorrarPropietario(idPropietario: GUID_ID);
begin
  tbPropietariosDEL.ParamByName('idPropietario').asString:= idPropietario;
  tbPropietariosDEL.ExecSQL;
end;

procedure TDM_Propietarios.LevantarPropietario(idPropietario: GUID_ID);
begin
  ReiniciarTablasPropietario;
  with tbPropietariosSEL do
  begin
    if active then close;
    ParamByName('idPropietario').asString:= idPropietario;
    Open;
    tbPropietarios.LoadFromDataSet(tbPropietariosSEL, 0, lmAppend);
    close;
  end;

  with qDomiciliosProp do
  begin
    if active then close;
    ParamByName('idPropietario').asString:= idPropietario;
    Open;
    tbDomicilios.LoadFromDataSet(qDomiciliosProp, 0, lmAppend);
    close;
  end;

  with qContactosProp do
  begin
    if active then close;
    ParamByName('idPropietario').asString:= idPropietario;
    Open;
    tbContactos.LoadFromDataSet(qContactosProp, 0, lmAppend);
    close;
  end;

  with qBancosProp do
  begin
    if active then close;
    ParamByName('idPropietario').asString:= idPropietario;
    Open;
    tbBancos.LoadFromDataSet(qBancosProp, 0, lmAppend);
    close;
  end;

end;

procedure TDM_Propietarios.AltaContacto(idFormaContacto: integer;
  Contacto: string);
begin
  With tbContactos do
  begin
    Insert;
    FieldByName('refTipoContacto').asInteger:= idFormaContacto;
    FieldByName('contacto').asString:= Contacto;
    Post;
  end;
end;

procedure TDM_Propietarios.EditarContacto(idFormaContacto: integer;
  Contacto: string);
begin
  With tbContactos do
  begin
    Edit;
    FieldByName('refTipoContacto').asInteger:= idFormaContacto;
    FieldByName('contacto').asString:= Contacto;
    FieldByName('lxTipoContacto').asString:= DM_Personas.TipoContacto (idFormaContacto);
    Post;
  end;
end;

procedure TDM_Propietarios.EliminarContacto;
begin
  if tbContactos.RecordCount > 0 then
  begin
    tbContactosDEL.ParamByName('idContacto').asString:= tbContactos.FieldByName('idContacto').asString;
    tbContactosDEL.ExecSQL;
    tbContactos.Delete;
  end;
end;


procedure TDM_Propietarios.CargarTablaDomicilio(direccion: string;
  idLocalidad: integer);
begin
  with tbDomicilios do
  begin
    FieldByName('Direccion').asString:= direccion;
    FieldByName('refLocalidad').asInteger:= idLocalidad;
    FieldByName('lxLocalidad').asString:= DM_Personas.ObtenerLocalidad (idLocalidad);
  end;
end;

procedure TDM_Propietarios.AltaDomicilio(direccion: String; idLocalidad: integer);
begin
  with tbDomicilios do
  begin
    Insert;
    CargarTablaDomicilio (direccion, idLocalidad);
    Post;
  end;
end;

procedure TDM_Propietarios.EditarDomicilio(direccion: String;
  idLocalidad: integer);
begin
  with tbDomicilios do
  begin
    Edit;
    CargarTablaDomicilio (direccion, idLocalidad);
    Post;
  end;
end;

procedure TDM_Propietarios.EliminarDomicilio;
begin
  if tbDomicilios.RecordCount > 0 then
  begin
    tbDomiciliosDEL.ParamByName('idDomicilio').asString:= tbDomicilios.FieldByName('idDomicilio').asString;
    tbDomiciliosDEL.ExecSQL;
    tbDomicilios.Delete;
  end;
end;

procedure TDM_Propietarios.CargarTablaBancos(idBanco: integer; cuenta, cbu,
  Notas: string);
begin
  With tbBancos do
  begin
    FieldByName('refBanco').asInteger:= idBanco;
    FieldByName('cuenta').asString:= cuenta;
    FieldByName('cbu').asString:= cbu;
    FieldByName('txNotas').asString:= Notas;
    FieldByName('lxBanco').asString:= DM_Personas.ObtenerBanco(idBanco);
  end;
end;


procedure TDM_Propietarios.AgregarBanco(idBanco: integer; cuenta, cbu,
  Notas: string);
begin
  with tbBancos do
  begin
    Insert;
    CargarTablaBancos (idBanco, cuenta, cbu, Notas);
    Post;
  end;
end;

procedure TDM_Propietarios.EditarBanco(idBanco: integer; cuenta, cbu,
  Notas: string);
begin
  with tbBancos do
  begin
    Edit;
    CargarTablaBancos (idBanco, cuenta, cbu, Notas);
    Post;
  end;
end;

procedure TDM_Propietarios.EliminarCuenta;
begin
  if tbBancos.RecordCount > 0 then
  begin
    tbBancosDEL.ParamByName('idPropietarioBanco').AsString:= tbBancos.FieldByName('idPropietarioBanco').asString;
    tbBancosDEL.ExecSQL;
    tbBancos.Delete;
  end;
end;


function TDM_Propietarios.getApellidoActual: string;
begin
  if (tbPropietarios.Active) and (tbPropietarios.RecordCount > 0) then
    Result:= tbPropietarios.FieldByName('cApellidos').asString
  else
    Result:= EmptyStr;
end;

function TDM_Propietarios.getNombreActual: string;
begin
  if (tbPropietarios.Active) and (tbPropietarios.RecordCount > 0) then
    Result:= tbPropietarios.FieldByName('cNombres').asString
  else
    Result:= EmptyStr;
end;


function TDM_Propietarios.getDocumentoActual: string;
begin
  if (tbPropietarios.Active) and (tbPropietarios.RecordCount > 0) then
    Result:= tbPropietarios.FieldByName('Documento').asString
  else
    Result:= EmptyStr;
end;

(*******************************************************************************
*** Búsquedas
*******************************************************************************)
function TDM_Propietarios.Buscar(var laTabla: TZQuery; elParametro: string): boolean;
begin
  DM_General.ReiniciarTabla(tbBusqueda);
  With laTabla do
  begin
    if active then close;
    ParamByName('parametro').AsString:= elParametro;
    Open;
    tbBusqueda.LoadFromDataSet(laTabla, 0, lmAppend);
    Result:= (tbBusqueda.RecordCount > 0);
    close;
  end;
end;


procedure TDM_Propietarios.InicializarBusquedas;
begin
  DM_General.ReiniciarTabla(tbBusqueda);
end;


function TDM_Propietarios.getIdBusquedaActual: GUID_ID;
begin
  if tbBusqueda.RecordCount > 0 then
    Result:= tbBusqueda.FieldByName('idPropietario').asString
  else
    Result:= GUIDNULO;
end;

function TDM_Propietarios.BuscarPropietarioApellido(dato: string): boolean;
begin
  Result:= Buscar (qBusApellido, dato);
end;

function TDM_Propietarios.BuscarPropietarioDocumento(dato: string): boolean;
begin
  Result:= Buscar (qBusDocumento, dato);
end;

function TDM_Propietarios.BuscarPropietarioCUIT(dato: string): boolean;
begin
  Result:= Buscar (qBusCUIT, dato);
end;

end.

