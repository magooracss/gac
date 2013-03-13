unit dmpropiedades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, StrHolder, ZDataset
  ,dmgeneral
  ;

const
  IDX_BUS_CALLE = 0;
  IDX_BUS_FALTA = 1;
  IDX_BUS_ALQUILER = 2;
  IDX_BUS_TIPO = 3;
  IDX_BUS_LOCALIDAD = 4;


type

  { TDM_Propiedades }

  TDM_Propiedades = class(TDataModule)
    qBusPorFechaAlta: TZQuery;
    qBusPorMontoAlquiler: TZQuery;
    qBusPorTipo: TZQuery;
    qBusPorLocalidad: TZQuery;
    qCuotasBorrar: TZQuery;
    qDELPropietario: TZQuery;
    qCuotasPropiedad: TZQuery;
    strHCuotasBorradas: TStrHolder;
    tbCuotasCuotaFin: TLongintField;
    tbCuotasCuotaInicio: TLongintField;
    tbCuotasidPropiedadPrecio: TStringField;
    tbCuotasnMonto: TFloatField;
    tbCuotasrefPropiedad: TStringField;
    tbPropiedades: TRxMemoryData;
    qINSPropietario: TZQuery;
    tbCuotasINS: TZQuery;
    tbCuotasSEL: TZQuery;
    tbCuotasUPD: TZQuery;
    tbPropiedadescCatastro: TStringField;
    tbPropiedadescPisoDto: TStringField;
    tbPropietarios: TRxMemoryData;
    tbPropiedadesDEL: TZQuery;
    tbPropiedadesINS: TZQuery;
    qPropietariosPropiedad: TZQuery;
    tbPropiedadestxNotasPropietarios: TStringField;
    tbResultados: TRxMemoryData;
    tbPropietariosApyNom: TStringField;
    tbPropietariosidPropietario: TStringField;
    tbCuotas: TRxMemoryData;
    tbResultadosCalle: TStringField;
    tbResultadosfAlta: TDateTimeField;
    tbResultadosidPropiedad: TStringField;
    tbResultadosLocalidad: TStringField;
    tbResultadosnAlquiler: TFloatField;
    tbResultadosnExpensas: TFloatField;
    tbResultadospropiedadTipo: TStringField;
    tugLocalidades: TZQuery;
    tbPropiedadesUPD: TZQuery;
    tbPropiedadesSEL: TZQuery;
    tbPropiedadesaltura: TStringField;
    tbPropiedadesbVisible: TLongintField;
    tbPropiedadesCalle: TStringField;
    tbPropiedadesfAlta: TDateField;
    tbPropiedadesidPropiedad: TStringField;
    tbPropiedadesnAlquiler: TFloatField;
    tbPropiedadesnExpensas: TFloatField;
    tbPropiedadesrefLocalidad: TLongintField;
    tbPropiedadesrefTipo: TLongintField;
    tbPropiedadestxDatosGenerales: TStringField;
    qBusPorCalle: TZQuery;
    tugPropiedadesTipos: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbCuotasAfterInsert(DataSet: TDataSet);
    procedure tbPropiedadesAfterInsert(DataSet: TDataSet);
    procedure tbPropietariosAfterScroll(DataSet: TDataSet);
  private
    function getIdLocalidadActual: integer;
    function getIdPropiedadActual: GUID_ID;
    function getidPropiedadBuscada: GUID_ID;
    function getIdPropietarioActual: GUID_ID;
    function getIdTipoActual: integer;

    procedure Buscar (parametro: string; var consulta: TZQuery);
    function getPropiedad: string;
    function ProximaCuotaIni: integer;
    procedure BorrarCuotas;
  public
    property idPropiedad: GUID_ID read getIdPropiedadActual;
    property idLocalidad: integer read getIdLocalidadActual;
    property idTipo: integer read getIdTipoActual;
    property idPropietarioActual: GUID_ID read getIdPropietarioActual;
    property idPropiedadBusqueda: GUID_ID read getidPropiedadBuscada;
    property Propiedad: string read getPropiedad;

    procedure AjustarCombos (refLocalidad, refTipo: integer);
    procedure Grabar;
    procedure Nueva;
    procedure LevantarPropiedad (refPropiedad: GUID_ID);
    procedure BorrarPropiedad (refPropiedad: GUID_ID );

    procedure LevantarPropietarios (refPropiedad: GUID_ID);
    procedure AgregarPropietario (refPropietario: GUID_ID);
    procedure QuitarPropietario (refPropietario: GUID_ID);

    procedure BuscarPorCalle (cadena: string);
    procedure BuscarPorFechaAlta (fecha: TDate);
    procedure BuscarPorMontoAlquiler (monto: double);
    procedure BuscarPorTipo (elIdTipo: integer);
    procedure BuscarPorLocalidad (elIdLocalidad: integer);

    procedure NuevaCuota;
    procedure LevantarCuotas (refPropiedad: GUID_ID);
    procedure EliminarCuotaActual;
    procedure GrabarCuotas;

  end; 

var
  DM_Propiedades: TDM_Propiedades;

implementation
{$R *.lfm}
uses
  dmpropietarios
  ;

{ TDM_Propiedades }

procedure TDM_Propiedades.tbPropiedadesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idPropiedad').asString:= DM_General.CrearGUID;
    FieldByName('refLocalidad').asInteger:= 0;
    FieldByName('refTipo').asInteger:= 0;
    FieldByName('nAlquiler').AsFloat:= 0;
    FieldByName('nExpensas').asFloat:= 0;
    FieldByName('fAlta').AsDateTime:= Now;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_Propiedades.tbPropietariosAfterScroll(DataSet: TDataSet);
begin
  DM_Propietarios.LevantarPropietario(tbPropietarios.FieldByName('idPropietario').asString);
end;

function TDM_Propiedades.getIdLocalidadActual: integer;
begin
  if (tbPropiedades.Active) and (tbPropiedades.State in dsWriteModes) then
   tbPropiedades.Post;
  if ((tbPropiedades.Active) and (tbPropiedades.RecordCount > 0)) then
    Result:= tbPropiedades.FieldByName('refLocalidad').AsInteger
  else
    Result:= 0;
end;

function TDM_Propiedades.getIdPropiedadActual: GUID_ID;
begin
  if (tbPropiedades.Active) and (tbPropiedades.State in dsWriteModes) then
   tbPropiedades.Post;
  if ((tbPropiedades.Active) and (tbPropiedades.RecordCount > 0)) then
    Result:= tbPropiedades.FieldByName('idPropiedad').asString
  else
    Result:= GUIDNULO;
end;

function TDM_Propiedades.getidPropiedadBuscada: GUID_ID;
begin
  with tbResultados do
  begin
    if Active and (RecordCount > 0) then
      Result:= FieldByName('idPropiedad').asString
    else
      Result:= GUIDNULO;
  end;
end;

function TDM_Propiedades.getIdPropietarioActual: GUID_ID;
begin
  if (tbPropietarios.Active) and (tbPropietarios.State in dsWriteModes) then
   tbPropietarios.Post;
  if ((tbPropietarios.Active) and (tbPropietarios.RecordCount > 0)) then
    Result:= tbPropietarios.FieldByName('idPropietario').asString
  else
    Result:= GUIDNULO;
end;

function TDM_Propiedades.getIdTipoActual: integer;
begin
  if (tbPropiedades.Active) and (tbPropiedades.State in dsWriteModes) then
   tbPropiedades.Post;
  if ((tbPropiedades.Active) and (tbPropiedades.RecordCount > 0)) then
    Result:= tbPropiedades.FieldByName('refTipo').AsInteger
  else
    Result:= 0;
end;

function TDM_Propiedades.getPropiedad: string;
begin
  if (tbPropiedades.Active) and (tbPropiedades.State in dsWriteModes) then
   tbPropiedades.Post;
  if ((tbPropiedades.Active) and (tbPropiedades.RecordCount > 0)) then
    Result:= tbPropiedades.FieldByName('Calle').AsString
             + ' '
             + tbPropiedades.FieldByName('Altura').AsString
  else
    Result:= EmptyStr;
end;



procedure TDM_Propiedades.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDatamodule(self),True);
end;

procedure TDM_Propiedades.AjustarCombos(refLocalidad, refTipo: integer);
begin
  With tbPropiedades do
  begin
    Edit;
    FieldByName('refLocalidad').asInteger:= refLocalidad;
    FieldByName('refTipo').asInteger:= refTipo;
    Post;
  end;
end;

procedure TDM_Propiedades.Grabar;
begin
  DM_General.GrabarDatos(tbPropiedadesSEL, tbPropiedadesINS, tbPropiedadesUPD, tbPropiedades,'idPropiedad');
end;

procedure TDM_Propiedades.Nueva;
begin
  DM_General.ReiniciarTabla(tbPropiedades);
  DM_General.ReiniciarTabla(tbPropietarios);

  tbPropiedades.Insert;
end;

procedure TDM_Propiedades.LevantarPropiedad(refPropiedad: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPropiedades);
  DM_General.ReiniciarTabla(tbPropietarios);
  With tbPropiedadesSEL do
  begin
    if active then close;
    ParamByName('idPropiedad').asString:= refPropiedad;
    Open;
    tbPropiedades.LoadFromDataSet(tbPropiedadesSEL, 0, lmAppend);
  end;
  LevantarPropietarios(refPropiedad);
  LevantarCuotas(refPropiedad);
end;

procedure TDM_Propiedades.BorrarPropiedad(refPropiedad: GUID_ID);
begin
  with tbPropiedadesDEL do
  begin
    ParamByName('idPropiedad').asString:= refPropiedad;
    ExecSQL;
  end;
end;

procedure TDM_Propiedades.LevantarPropietarios(refPropiedad: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPropietarios);
  with qPropietariosPropiedad do
  begin
    if active then close;
    ParamByName('refPropiedad').AsString:= refPropiedad;
    Open;
    tbPropietarios.LoadFromDataSet(qPropietariosPropiedad, 0, lmAppend);
    close;
  end;
  DM_Propietarios.LevantarPropietario(tbPropietarios.FieldByName('idPropietario').asString);
end;

procedure TDM_Propiedades.AgregarPropietario(refPropietario: GUID_ID);
begin
  with qINSPropietario do
  begin
    ParamByName('IDPROPIETARIOPROPIEDAD').asString:= DM_General.CrearGUID;
    ParamByName('REFPROPIETARIO').asString:= refPropietario;
    ParamByName('REFPROPIEDAD').asString:= idPropiedad;
    ExecSQL;
  end;
end;

procedure TDM_Propiedades.QuitarPropietario(refPropietario: GUID_ID);
begin
  with qDELPropietario do
  begin
    ParamByName('refPropietario').asString:= refPropietario;
    ParamByName('refPropiedad').asString:= idPropiedad;
    ExecSQL;
  end;
end;


procedure TDM_Propiedades.Buscar(parametro: string; var consulta: TZQuery);
begin
  DM_General.ReiniciarTabla(tbResultados);
  with consulta do
  begin
    if Active then close;
    case ParamByName('parametro').DataType of
       ftString: ParamByName('parametro').AsString:= parametro;
       ftFloat, ftCurrency: ParamByName('parametro').AsFloat:= StrToFloatDef(parametro, 0);
       ftDate, ftDateTime: ParamByName('parametro').AsDateTime:= StrToDateDef(parametro, now);
       ftInteger, ftLargeint, ftAutoInc: ParamByName('parametro').AsInteger:= StrToIntDef(parametro, 0);
      else
        ParamByName('parametro').AsString:= parametro;
    end;
    Open;
    if RecordCount > 0 then
      tbResultados.LoadFromDataSet(consulta, 0, lmAppend);
  end;
end;


procedure TDM_Propiedades.BuscarPorCalle(cadena: string);
begin
  Buscar(cadena, qBusPorCalle);
  tbResultados.SortOnFields('calle');
end;

procedure TDM_Propiedades.BuscarPorFechaAlta(fecha: TDate);
begin
  Buscar(DateToStr(fecha), qBusPorFechaAlta);
  tbResultados.SortOnFields('fAlta');
end;

procedure TDM_Propiedades.BuscarPorMontoAlquiler(monto: double);
begin
  Buscar(FloatToStr(monto), qBusPorMontoAlquiler);
  tbResultados.SortOnFields('nAlquiler; Localidad; calle');
end;

procedure TDM_Propiedades.BuscarPorTipo(elIdTipo: integer);
begin
  Buscar(IntToStr(elIdTipo), qBusPorTipo);
  tbResultados.SortOnFields('Calle');
end;

procedure TDM_Propiedades.BuscarPorLocalidad(elIdLocalidad: integer);
begin
  Buscar(IntToStr(elIdLocalidad), qBusPorLocalidad);
  tbResultados.SortOnFields('calle');
end;

(*******************************************************************************
***  CUOTAS
*******************************************************************************)

procedure TDM_Propiedades.tbCuotasAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idPropiedadPrecio').asString:= DM_General.CrearGUID;
    FieldByName('refPropiedad').asString:= tbPropiedades.FieldByName('idPropiedad').asString;
    FieldByName('CuotaInicio').asInteger:= 0;
    FieldByName('CuotaFin').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
  end;
end;

function TDM_Propiedades.ProximaCuotaIni: integer;
begin
  with tbCuotas do
  begin
    DisableControls;
    if RecordCount > 0 then
    begin;
      SortOnFields('CuotaFin',True, True);
      First;
      Result:= FieldByName('CuotaFin').asInteger + 1;
    end
    else
      Result:= 1;
    EnableControls;
  end;
end;


procedure TDM_Propiedades.NuevaCuota;
var
  ini: integer;
begin
  With tbCuotas do
  begin
    if State in dsEditModes then
     Post;
    ini:= ProximaCuotaIni;
    Insert;
    FieldByName('CuotaInicio').asInteger:= ini;
    FieldByName('CuotaFin').asInteger:= ini;
  end;
end;

procedure TDM_Propiedades.LevantarCuotas(refPropiedad: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbCuotas);
  strHCuotasBorradas.Clear;
  with qCuotasPropiedad do
  begin
    if active then close;
    ParamByName('refPropiedad').asString:= refPropiedad;
    Open;
    tbCuotas.LoadFromDataSet(qCuotasPropiedad, 0, lmAppend);
    Close;
  end;
  tbCuotas.SortOnFields('CuotaInicio');
end;

procedure TDM_Propiedades.EliminarCuotaActual;
begin
  with tbCuotas do
  begin
    if RecordCount > 0 then
    begin
      strHCuotasBorradas.Strings.Add(FieldByName('idPropiedadPrecio').asString);
      Delete;
    end;
  end;
end;

procedure TDM_Propiedades.BorrarCuotas;
var
  i: integer;
begin
  with strHCuotasBorradas do
  begin
    for i:= 0 to Strings.Count - 1 do
    begin
      with qCuotasBorrar do
      begin
        ParamByName('refPropiedadPrecio').asString:= Strings[i];
        ExecSQL;
      end;
    end;
  end;
end;

procedure TDM_Propiedades.GrabarCuotas;
begin
  BorrarCuotas;
  DM_General.GrabarDatos(tbCuotasSEL, tbCuotasINS, tbCuotasUPD, tbCuotas, 'idPropiedadPrecio');
  tbCuotas.SortOnFields('CuotaInicio');
end;

end.

