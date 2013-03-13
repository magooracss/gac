unit dmcontratos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;


const
   IDX_BUS_PROPIEDAD = 0;
   IDX_BUS_CARPETA = 1;
   IDX_BUS_CODIGO = 2;
   IDX_BUS_FFIN = 3;
   IDX_BUS_INQ = 4;
   IDX_BUS_PROP = 5;
  IDX_BUS_FVIGENCIA = 6;




type

  { TDM_Contratos }

  TDM_Contratos = class(TDataModule)
    qBusPorInquilino: TZQuery;
    qBusPorPropietario: TZQuery;
    qInquilinosContrato: TZQuery;
    qGarantesContrato: TZQuery;
    qLevantarCuotasContratoPorPropiedad: TZQuery;
    qPropietarios: TZQuery;
    qBusPropiedad: TZQuery;
    qBusCarpeta: TZQuery;
    qBusCodigo: TZQuery;
    qBusFVigencia: TZQuery;
    qBusFFin: TZQuery;
    tbContratosbAlqGarantizado: TLongintField;
    tbContratosGarantesDEL: TZQuery;
    tbContratosGarantesINS: TZQuery;
    tbContratosGarantesSEL: TZQuery;
    tbContratosGarantesUPD: TZQuery;
    tbContratosnDepDocumento: TFloatField;
    tbContratosnDepEfectivo: TFloatField;
    tbContratosnDiaVencimiento: TLongintField;
    qContratosActivos: TZQuery;
    tbContratosnDiligenc: TFloatField;
    tbContratosnHonorCuotas: TLongintField;
    tbResultados: TRxMemoryData;
    tbContratosbLiqPropietarioBanco1: TLongintField;
    tbContratosbVisible1: TLongintField;
    tbContratosCarpeta1: TLongintField;
    tbContratosCodigo1: TStringField;
    tbContratosfFinalizacion1: TDateField;
    tbContratosfInicio1: TDateField;
    tbContratosidContrato1: TStringField;
    tbContratosnHonorarios1: TFloatField;
    tbContratosnPorcGastosAdm1: TFloatField;
    tbContratosnPorcPunitoriosDiarios1: TFloatField;
    tbContratosnSellado1: TFloatField;
    tbContratosnSena1: TFloatField;
    tbContratosrefCuentaPropietario1: TStringField;
    tbContratosrefPropiedad1: TStringField;
    tbContratosrefTipoContrato1: TLongintField;
    tbContratosSEL: TZQuery;
    tbContratosDEL: TZQuery;
    tbContratosINS: TZQuery;
    tbContratostxNotas1: TStringField;
    tbContratosUPD: TZQuery;
    tbContratosInquilinosDEL: TZQuery;
    tbContratosInquilinosINS: TZQuery;
    tbContratosInquilinosSEL: TZQuery;
    tbContratosInquilinosUPD: TZQuery;
    tbResultadosAltura: TStringField;
    tbResultadosCalle: TStringField;
    tbResultadosidPropiedad: TStringField;
    tbResultadosPersona: TStringField;
    trContratosGarantescApellidos: TStringField;
    trContratosGarantescNombres: TStringField;
    trContratosGarantesDocumento: TStringField;
    trContratosGarantesidContratoGarante: TStringField;
    trContratosGarantesrefContrato: TStringField;
    trContratosGarantesrefGarante: TStringField;
    trContratosInquilinos: TRxMemoryData;
    tbGastosContratobInquilino: TLongintField;
    tbGastosContratobPropietario: TLongintField;
    tbGastosContratobVisible: TLongintField;
    tbGastosContratoidGastoMensual: TStringField;
    tbGastosContratolxGasto: TStringField;
    tbGastosContratonMonto: TFloatField;
    tbGastosContratorefContrato: TStringField;
    tbGastosContratorefGasto: TLongintField;
    tbGastosContratoSEL: TZQuery;
    tbGastosContratoINS: TZQuery;
    qGastosContrato: TZQuery;
    tbGastosContratoUPD: TZQuery;
    tbGastosContratoDEL: TZQuery;
    trContratosGarantes: TRxMemoryData;
    trContratosInquilinoscApellidos1: TStringField;
    trContratosInquilinoscNombres1: TStringField;
    trContratosInquilinosDocumento1: TStringField;
    trContratosInquilinosidContratoInquilino: TStringField;
    trContratosInquilinosrefContrato: TStringField;
    trContratosInquilinosrefInquilino: TStringField;
    tugGastosMensuales: TZQuery;
    tbContratosrefPropiedad: TStringField;
    tbCuentasPropietarios: TRxMemoryData;
    tbGastosContrato: TRxMemoryData;
    tbCuentasPropietariosBancoCuentaCBU: TStringField;
    tbCuentasPropietariosidPropietarioBanco: TStringField;
    tbPropietarios: TRxMemoryData;
    tbPropietarioscApellidos: TStringField;
    tbPropietarioscNombres: TStringField;
    tbPropietariosDocumento: TStringField;
    tbPropietariosidPropietario: TStringField;
    tugTiposContrato: TZQuery;
    tbContratos: TRxMemoryData;
    tbContratosbLiqPropietarioBanco: TLongintField;
    tbContratosbVisible: TLongintField;
    tbContratosCarpeta: TLongintField;
    tbContratosCodigo: TStringField;
    tbContratosfFinalizacion: TDateField;
    tbContratosfInicio: TDateField;
    tbContratosidContrato: TStringField;
    tbContratosnHonorarios: TFloatField;
    tbContratosnPorcGastosAdm: TFloatField;
    tbContratosnPorcPunitoriosDiarios: TFloatField;
    tbContratosnSellado: TFloatField;
    tbContratosnSena: TFloatField;
    tbContratosrefCuentaPropietario: TStringField;
    tbContratosrefTipoContrato: TLongintField;
    tbContratostxNotas: TStringField;
    qLevantarCuentasPropietario: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbContratosAfterInsert(DataSet: TDataSet);
    procedure tbGastosContratoAfterInsert(DataSet: TDataSet);
    procedure trContratosGarantesAfterInsert(DataSet: TDataSet);
    procedure trContratosInquilinosAfterInsert(DataSet: TDataSet);
  private
    function getidContratoBusqueda: string;
    function getidCuentaPropietario: string;
    function getIdGastoSeleccionado: integer;
    function getidTipoContrato: integer;
    function getMontoGastoSeleccionado: double;
    function getPropiedad: string;

    procedure LevantarInquilinos (refContrato: GUID_ID);
    procedure LevantarGarantes (refContrato: GUID_ID);
    procedure LevantarPropietarios (refPropiedad: GUID_ID);
    procedure setIdCuentaPropietario(const AValue: string);
    procedure setidTipoContrato(const AValue: integer);

    procedure Buscar (parametro: string; consulta: TZQuery);

  public
    property Propiedad: string read getPropiedad;
    property idGastoSeleccionado: integer  read getIdGastoSeleccionado;
    property MontoGastoSeleccionado: double read getMontoGastoSeleccionado;
    property idCuentaPropietario: string read getidCuentaPropietario write setIdCuentaPropietario;
    property idTipoContrato: integer read getidTipoContrato write setidTipoContrato;
    property idContratoBusqueda: string read getidContratoBusqueda;

    function Nuevo: GUID_ID;

    procedure LevantarCuentasPropietarios (refPropiedad: GUID_ID);
    procedure CargarPropiedad (refPropiedad: GUID_ID);

    procedure LevantarGastosContrato (refContrato: GUID_ID);
    procedure AltaGasto (refGasto: integer; elMonto: double; bInquilino,bPropietario: integer);
    procedure BajaGasto;

    procedure LevantarTugGastos;

    procedure LevantarContrato (refContrato: string);
    procedure LevantarContratosMayorFechaFin (laFechaFin: TDateTime);

    procedure AltaInquilino (refInquilino: GUID_ID);
    procedure BajaInquilino;

    procedure AltaGarante (refGarante: GUID_ID);
    procedure BajaGarante;

    procedure Grabar;

    procedure BuscarPorPropiedad (laPropiedad: string);
    procedure BuscarPorCarpeta(laCarpeta: integer);
    procedure BuscarPorCodigo (elCodigo: string);
    procedure BuscarPorFVigencia (laFVigencia: TDate);
    procedure BuscarPorFFin(laFFin: TDate);
    procedure BuscarPorPropietario (elPropietario: string);
    procedure BuscarPorInquilino (elInquilino: string);

    procedure BorrarContrato (refContrato: string);

    procedure GenerarCuotasPorPropiedad(refPropiedad: GUID_ID);
  end;

var
  DM_Contratos: TDM_Contratos;

implementation
{$R *.lfm}
uses
  dmpropiedades
  ;

{ TDM_Contratos }

procedure TDM_Contratos.tbContratosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idContrato').asString:= DM_General.CrearGUID;
    FieldByName('Carpeta').asInteger:= -1;
    FieldByName('refTipoContrato').asInteger:= 0;
    FieldByName('fInicio').AsDateTime:= Now;
    FieldByName('fFinalizacion').AsDateTime:= Now;
    FieldByName('nSena').asFloat:= 0;
    FieldByName('nPorcGastosAdm').asFloat:= 0;
    FieldByName('nSellado').asFloat:= 0;
    FieldByName('nHonorarios').asFloat:= 0;
    FieldByName('nPorcPunitoriosDiarios').asFloat:= 0;
    FieldByName('bLiqPropietarioBanco').AsInteger:= 0;
    FieldByName('refCuentaPropietario').asString:= GUIDNULO;
    FieldByName('refPropiedad').asString:= GUIDNULO;
    FieldByName('nDiaVencimiento').asInteger:= DIA_VENCIMIENTO;
    FieldByName('bAlqGarantizado').asInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Contratos.tbGastosContratoAfterInsert(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('idGastoMensual').asString:= DM_General.CrearGUID;
    FieldByName('refContrato').asString:= tbContratos.FieldByName('idContrato').asString;
    FieldByName('refGasto').asInteger:= 0;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('bInquilino').asInteger:= 0;
    FieldByName('bPropietario').asInteger:= 0;
    FieldByName('bVisible').AsInteger:= 1;
  end;
end;

procedure TDM_Contratos.trContratosGarantesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idContratoGarante').asString:= DM_General.CrearGUID;
    FieldByName('refContrato').asString:= tbContratos.FieldByName('idContrato').asString;
    FieldByName('refGarante').asString:= GUIDNULO;
  end;
end;

procedure TDM_Contratos.trContratosInquilinosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idContratoInquilino').asString:= DM_General.CrearGUID;
    FieldByName('refContrato').asString:= tbContratos.FieldByName('idContrato').asString;
    FieldByName('refInquilino').asString:= GUIDNULO;
  end;
end;

function TDM_Contratos.getidContratoBusqueda: string;
begin
  with tbResultados do
  begin
    if active and (RecordCount > 0 ) then
     Result:= FieldByName('idContrato').asString
    else
      Result:= GUIDNULO;
  end;

end;

function TDM_Contratos.getidCuentaPropietario: string;
begin
  with tbContratos do
  begin
    if active and (RecordCount > 0 ) then
     Result:= FieldByName('refCuentaPropietario').asString
    else
      Result:= GUIDNULO;
  end;
end;

function TDM_Contratos.getIdGastoSeleccionado: integer;
begin
  with tugGastosMensuales do
  begin
    if active and (RecordCount > 0) then
      Result:= FieldByName('idGastoMensual').asInteger
    else
      Result:= 0;
  end;
end;

function TDM_Contratos.getidTipoContrato: integer;
begin
  with tbContratos do
  begin
    if active and (RecordCount > 0) then
      Result:= FieldByName('refTipoContrato').asInteger
    else
      Result:= 0;
  end;
end;

function TDM_Contratos.getMontoGastoSeleccionado: double;
begin
  with tugGastosMensuales do
  begin
    if active and (RecordCount > 0) then
      Result:= FieldByName('nMonto').asFloat
    else
      Result:= 0;
  end;
end;

procedure TDM_Contratos.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDataModule(DM_Contratos), True);
end;

function TDM_Contratos.getPropiedad: string;
begin
  with tbContratos do
  begin
    if (Active) and (RecordCount > 0) and
     (NOT FieldByName('refPropiedad').IsNull) then
    begin
      DM_Propiedades.LevantarPropiedad(FieldByName('refPropiedad').asString);
      Result:= DM_Propiedades.Propiedad;
    end
    else
      Result:= 'SIN PROPIEDAD ASIGNADA';
  end;

end;

procedure TDM_Contratos.LevantarInquilinos(refContrato: GUID_ID);
begin
  DM_General.ReiniciarTabla(trContratosInquilinos);
  with qInquilinosContrato do
  begin
    if active then close;
    ParamByName('refContrato').AsString:= refContrato;
    Open;
    trContratosInquilinos.LoadFromDataSet(qInquilinosContrato, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Contratos.LevantarGarantes(refContrato: GUID_ID);
begin
  DM_General.ReiniciarTabla(trContratosGarantes);
  with qGarantesContrato do
  begin
    if active then close;
    ParamByName('refContrato').AsString:= refContrato;
    Open;
    trContratosGarantes.LoadFromDataSet(qGarantesContrato, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Contratos.LevantarPropietarios(refPropiedad: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbPropietarios);
  with qPropietarios do
  begin
    if active then close;
    ParamByName('refPropiedad').asString:= refPropiedad;
    Open;
    tbPropietarios.LoadFromDataSet(qPropietarios, 0, lmAppend);
    close;
  end;
end;

procedure TDM_Contratos.setIdCuentaPropietario(const AValue: string);
begin
  with tbContratos do
  begin
    if State IN dsWriteModes then
     post;
    Edit;
    FieldByName('refCuentaPropietario').asString:= AValue;
    Post;
  end;
end;

procedure TDM_Contratos.setidTipoContrato(const AValue: integer);
begin
  with tbContratos do
  begin
    if State IN dsWriteModes then
     post;
    Edit;
    FieldByName('refTipoContrato').asInteger:= AValue;
    Post;
  end;
end;


function TDM_Contratos.Nuevo: GUID_ID;
begin
  DM_General.ReiniciarTabla(tbContratos);
  DM_General.ReiniciarTabla(tbPropietarios);
  DM_General.ReiniciarTabla(tbCuentasPropietarios);
  DM_General.ReiniciarTabla(tbGastosContrato);
  DM_General.ReiniciarTabla(trContratosInquilinos);

  tbContratos.Insert;
  Result:= tbContratos.FieldByName('idContrato').asString;
end;

procedure TDM_Contratos.LevantarCuentasPropietarios (refPropiedad: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbCuentasPropietarios);
  with qLevantarCuentasPropietario do
  begin
    if active then  close;
    ParamByName('refPropiedad').asString:= refPropiedad;
    Open;
    while NOT EOF do
    begin
      tbCuentasPropietarios.Insert;
      tbCuentasPropietarios.FieldByName ('idPropietarioBanco').asString:= FieldByName('idPropietarioBanco').asString;
      tbCuentasPropietarios.FieldByName ('BancoCuentaCBU').asString:= TRIM(FieldByName('cApellidos').asString)
                                                                      +' / '
                                                                      +TRIM(FieldByName('Banco').asString)
                                                                      +' / '
                                                                      +TRIM(FieldByName('Cuenta').asString)
                                                                      ;
      tbCuentasPropietarios.Post;
      Next;
    end;

  end;
  LevantarPropietarios(refPropiedad);
end;

procedure TDM_Contratos.CargarPropiedad(refPropiedad: GUID_ID);
begin
  with tbContratos do
  begin
    Edit;
    FieldByName('refPropiedad').asString:= refPropiedad;
    Post;
  end;
end;

procedure TDM_Contratos.LevantarGastosContrato(refContrato: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbGastosContrato);
  with qGastosContrato do
  begin
    if active then close;
    ParamByName('refContrato').asString:= refContrato;
    Open;
    tbGastosContrato.LoadFromDataSet(qGastosContrato, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Contratos.AltaGasto(refGasto: integer; elMonto: double;
  bInquilino, bPropietario: integer);
begin
  with tbGastosContrato do
  begin
    Insert;
    FieldByName('nMonto').asFloat:= elMonto;
    FieldByName('refGasto').asInteger:= refGasto;
    FieldByName('bInquilino').asInteger:= bInquilino;
    FieldByName('bPropietario').asInteger:= bPropietario;
    Post;
  end;
  DM_General.GrabarDatos(tbGastosContratoSEL, tbGastosContratoINS, tbGastosContratoUPD, tbGastosContrato, 'idGastoMensual');
  LevantarGastosContrato(tbContratos.FieldByName('idContrato').asString);
end;

procedure TDM_Contratos.BajaGasto;
begin
  if tbGastosContrato.RecordCount > 0 then
  begin
    with tbGastosContratoDEL do
    begin
      ParamByName('idGastoMensual').asString:= tbGastosContrato.FieldByName('idGastoMensual').asString;
      ExecSQL;
    end;
    tbGastosContrato.Delete;
  end;
end;

procedure TDM_Contratos.LevantarTugGastos;
begin
  with tugGastosMensuales do
  begin
    if active then close;
    open;
  end;
end;

procedure TDM_Contratos.LevantarContrato(refContrato: string);
begin
  DM_General.ReiniciarTabla(tbContratos);
  with tbContratosSEL do
  begin
    if active then close;
    ParamByName('idContrato').asString:= refContrato;
    Open;
    tbContratos.LoadFromDataSet(tbContratosSEL, 0, lmAppend);
    Close;
  end;
  LevantarPropietarios(tbContratos.FieldByName('refPropiedad').asString);
  LevantarCuentasPropietarios(tbContratos.FieldByName('refPropiedad').asString);
  LevantarGastosContrato (refContrato);
  LevantarInquilinos (refContrato);
end;

procedure TDM_Contratos.LevantarContratosMayorFechaFin(laFechaFin: TDateTime);
begin
  with qContratosActivos do
  begin
    if active then close;
    ParamByName('FechaFin').AsDateTime:= laFechaFin;
    Open;
  end;
end;

procedure TDM_Contratos.AltaInquilino(refInquilino: GUID_ID);
begin
  with trContratosInquilinos do
  begin
    Insert;
    FieldByName('refInquilino').asString:= refInquilino;
    Post;
  end;
  DM_General.GrabarDatos (tbContratosInquilinosSEL, tbContratosInquilinosINS, tbContratosInquilinosUPD, trContratosInquilinos ,'idContratoInquilino');
  LevantarInquilinos(trContratosInquilinos.FieldByName('refContrato').AsString);
end;

procedure TDM_Contratos.BajaInquilino;
begin
  if trContratosInquilinos.RecordCount > 0 then
  begin
    with tbContratosInquilinosDEL do
    begin
      ParamByName('idContratoInquilino').asString:= trContratosInquilinos.FieldByName('idContratoinquilino').asString;
      ExecSQL;
    end;
    trContratosInquilinos.Delete;
  end;

end;

procedure TDM_Contratos.AltaGarante(refGarante: GUID_ID);
begin
  with trContratosGarantes do
  begin
    Insert;
    FieldByName('refGarante').asString:= refGarante;
    Post;
  end;
  DM_General.GrabarDatos (tbContratosGarantesSEL, tbContratosGarantesINS, tbContratosGarantesUPD, trContratosGarantes ,'idContratoGarante');
  LevantarGarantes(trContratosGarantes.FieldByName('refContrato').AsString);
end;

procedure TDM_Contratos.BajaGarante;
begin
  if trContratosGarantes.RecordCount > 0 then
  begin
    with tbContratosGarantesDEL do
    begin
      ParamByName('idContratoGarante').asString:= trContratosGarantes.FieldByName('idContratoGarante').asString;
      ExecSQL;
    end;
    trContratosGarantes.Delete;
  end;
end;

procedure TDM_Contratos.Grabar;
begin
  DM_General.GrabarDatos (tbContratosSEL, tbContratosINS, tbContratosUPD, tbContratos, 'idContrato');
end;


(*******************************************************************************
***   BÚSQUEDAS
********************************************************************************)

procedure TDM_Contratos.Buscar(parametro: string; consulta: TZQuery);
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

procedure TDM_Contratos.BuscarPorPropiedad(laPropiedad: string);
begin
  Buscar(laPropiedad, qBusPropiedad);
end;

procedure TDM_Contratos.BuscarPorCarpeta(laCarpeta: integer);
begin
  Buscar(IntToStr(laCarpeta), qBusCarpeta);
end;

procedure TDM_Contratos.BuscarPorCodigo(elCodigo: string);
begin
  Buscar (elCodigo, qBusCodigo);
end;

procedure TDM_Contratos.BuscarPorFVigencia(laFVigencia: TDate);
begin
  Buscar (DateToStr(laFVigencia), qBusFVigencia);
end;

procedure TDM_Contratos.BuscarPorFFin(laFFin: TDate);
begin
  Buscar (DateToStr(laFFin), qBusFFin);
end;

procedure TDM_Contratos.BuscarPorPropietario(elPropietario: string);
begin
  Buscar (TRIM(elPropietario), qBusPorPropietario);
end;

procedure TDM_Contratos.BuscarPorInquilino(elInquilino: string);
begin
  Buscar (TRIM(elInquilino), qBusPorInquilino);
end;

procedure TDM_Contratos.BorrarContrato(refContrato: string);
begin
  with tbContratosDEL do
  begin
    ParamByName('idContrato').asString:= refContrato;
    ExecSQL;
  end;
end;

procedure TDM_Contratos.GenerarCuotasPorPropiedad(refPropiedad: GUID_ID);
begin
  with qLevantarCuotasContratoPorPropiedad do
  begin
    if Active then close;
    ParamByName('refPropiedad').asString:= refPropiedad;
    Open;
  end;
end;


end.

