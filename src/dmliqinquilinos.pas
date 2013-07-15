unit dmliqinquilinos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral
  ;

const
  INQ_ITEM_MENSUALIDAD = 1;
  INQ_ITEM_GASTO = 2;

type

  { TDM_LIQINQ }

  TDM_LIQINQ = class(TDataModule)
    qCajaPorContrato: TZQuery;
    qDescuentosPorContrato: TZQuery;
    qPagaresPorContrato: TZQuery;
    qLevantarCuotasContrato: TZQuery;
    qLevantarCuotasLiquidadas: TZQuery;
    qGastosPorContrato: TZQuery;
    qVencimientosMes: TZQuery;
    tbLiqInqItems: TRxMemoryData;
    tbLiqInqItemsbVisible: TLongintField;
    tbLiqInqItemsidLiqInqItems: TStringField;
    tbLiqInqItemsmontoPagado: TFloatField;
    tbLiqInqItemsrefLiqInqCabecera: TStringField;
    tbLiqInqItemsrefLiqInqItem: TStringField;
    tbLiqInqItemstipoItem: TLongintField;
    tbLiquidacion: TRxMemoryData;
    tbLiqInqCajabVisible: TLongintField;
    tbLiqInqCajaDescripcion: TStringField;
    tbLiqInqCajafPago: TDateTimeField;
    tbLiqInqCajafVencimiento: TDateField;
    tbLiqInqCajaidLiqInqCaja: TStringField;
    tbLiqInqCajaMonto: TFloatField;
    tbLiqInqCajaPagado: TFloatField;
    tbLiqInqCajarefContrato: TStringField;
    tbLiqInqCajareferencia: TStringField;
    tbLiqInqCajarefLiqInqCabecera: TStringField;
    tbLiqInqCajarefTipo: TLongintField;
    tbLiquidacionbAnulada: TLongintField;
    tbLiquidacionfAnulada: TDateTimeField;
    tbLiquidacionFecha: TDateTimeField;
    tbLiquidacionidLiqInqCabecera: TStringField;
    tbLiquidacionMonto: TFloatField;
    tbLiquidacionNro: TLongintField;
    tbLiquidacionrefContrato: TStringField;
    tbLiquidacionrefInquilino: TStringField;
    tbLiquidaciontxNota: TBlobField;
    tbPagareINS: TZQuery;
    tbLiqInqPagaresbVisible: TLongintField;
    tbLiqInqPagaresfVencimiento: TDateField;
    tbLiqInqPagaresidLiqInqPagare: TStringField;
    tbLiqInqPagaresnMonto: TFloatField;
    tbLiqInqPagaresnPunitorios: TFloatField;
    tbLiqInqPagaresnTotal: TFloatField;
    tbLiqInqPagaresrefContratoPagare: TStringField;
    tbLiqInqPagaresrefLiqCabecera: TStringField;
    tbCajaINS: TZQuery;
    tbPagaresSEL: TZQuery;
    tbCajaSEL: TZQuery;
    tbParareUPD: TZQuery;
    tbGastosINS: TZQuery;
    tbGastosSEL: TZQuery;
    tbGastosUPD: TZQuery;
    tbLiqInqDescuentosbVisible: TLongintField;
    tbLiqInqDescuentosDescuento: TStringField;
    tbLiqInqDescuentosidLiqInqDescuento: TStringField;
    tbLiqInqDescuentosnMonto: TFloatField;
    tbLiqInqDescuentosrefContrato: TStringField;
    tbLiqInqDescuentosrefLiqCabecera: TStringField;
    tbLiqInqGastosbVisible: TLongintField;
    tbLiqInqGastosGasto: TStringField;
    tbLiqInqGastosidLiqInqGasto: TStringField;
    tbLiqInqGastosnMonto: TFloatField;
    tbLiqInqGastosrefContrato: TStringField;
    tbLiqInqGastosrefLiqCabecera: TStringField;
    tbLiqInqGastosrefReparacion: TStringField;
    tbLiqInqMesesbVisible: TLongintField;
    tbLiqInqMesesfVencimiento: TDateTimeField;
    tbLiqInqMesesidLiqInqMes: TStringField;
    tbLiqInqMesesnAno: TLongintField;
    tbLiqInqMesesnMes: TLongintField;
    tbLiqInqMesesnMonto: TFloatField;
    tbLiqInqMesesnPunitorios: TFloatField;
    tbLiqInqMesesnTotal: TFloatField;
    tbLiqInqMesesrefContratoCobro: TStringField;
    tbLiqInqMesesrefLiqCabecera: TStringField;
    tbLiqInqCaja: TRxMemoryData;
    tbMesesINS: TZQuery;
    tbDescINS: TZQuery;
    tbMesesSEL: TZQuery;
    tbDescSEL: TZQuery;
    tbMesesUPD: TZQuery;
    tbLiqInqDescuentos: TRxMemoryData;
    tbLiqInqGastos: TRxMemoryData;
    tbLiqInqMeses: TRxMemoryData;
    tbLiqInqPagares: TRxMemoryData;
    tbMesesDEL: TZQuery;
    tbDescUPD: TZQuery;
    tbCajaUPD: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure tbLiqInqCajaAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqDescuentosAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqGastosAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqItemsAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqMesesAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqPagaresAfterInsert(DataSet: TDataSet);
    procedure tbLiquidacionAfterInsert(DataSet: TDataSet);
  private
    procedure LevantarGastosPorContrato (refContrato: GUID_ID);
    procedure LevantarCajaPorContrato (refContrato: GUID_ID);
    procedure LevantarDescuentoPorContrato (refContrato: GUID_ID);
    procedure LevantarPagaresPorContrato (refContrato: GUID_ID);
  public
    procedure CargarCuotasPorContrato (refContrato: GUID_ID); // Dado un contrato, se generan las cuotas a liquidar
    procedure LevantarCuotasPorContrato (refContrato: GUID_ID); //Levanta de la base las cuotas del contrato
    procedure LevantarCuotasPorPropiedad (refPropiedad: GUID_ID);

    procedure LevantarCuentaCorrienteContrato (refContrato: GUID_ID); //Agrupa toda la levantada de informacion;


    function MensualidadLiquidada (refMensualidad: GUID_ID): boolean;
    procedure BorrarLiqMensual;

    procedure Grabar;

    procedure GenerarCuotasPeriodo (CuotaInicial, CuotaFinal: integer; MontoCuota: double
                                   ; refContrato: GUID_ID; InicioContrato: TDate; diaVencimiento: Integer);


    procedure AsentarGasto (refContrato: GUID_ID; descripcion: string; monto: double; operacion: TOperacion);
    procedure BorrarGastoActual;

    procedure AsentarCaja (refContrato: GUID_ID; descripcion: string
                          ; monto: double; vencimiento: TDate
                          ; montoPagado: double; fPago: TDate
                          ; refTipo: integer; operacion: TOperacion);
    procedure BorrarCajaActual;

    procedure AsentarDescuento (refContrato: GUID_ID; descripcion: string; monto: double; operacion: TOperacion);
    procedure BorrarDescuentoActual;

    procedure AsentarPagare (refContrato: GUID_ID; fVencimiento: TDate
                            ; monto, punitorios, total: double
                            ; operacion: TOperacion);
    procedure BorrarPagareActual;

    procedure CargarLiquidacionMes (elMes, elAno: word; idContrato: GUID_ID);
    procedure ObtenerVencimientosMes (elMes, elAno: word; idContrato: GUID_ID);

  end; 

var
  DM_LIQINQ: TDM_LIQINQ;

implementation
{$R *.lfm}
uses
  dateutils
  ;

{ TDM_LIQINQ }

(*******************************************************************************
****
********************************************************************************)

procedure TDM_LIQINQ.tbLiqInqDescuentosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLiqInqDescuento').asString:= DM_General.CrearGUID;
    FieldByName('refLiqCabecera').asString:= GUIDNULO;
    FieldByName('Descuento').AsString:= EmptyStr;
    FieldByName('nMonto').AsFloat:= 0;
    FieldByName('refContrato').asString:= GUIDNULO;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_LIQINQ.tbLiqInqCajaAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLiqInqCaja').asString:= DM_General.CrearGUID;
    FieldByName('refLiqInqCabecera').asString:= GUIDNULO;
    FieldByName('Descripcion').asString:= EmptyStr;
    FieldByName('Monto').asFloat:= 0;
    FieldByName('fVencimiento').AsDateTime:= Now;
    FieldByName('fPago').AsDateTime:= Now;
    FieldByName('Pagado').asFloat:= 0;
    FieldByName('refTipo').AsInteger:= 0;
    FieldByName('referencia').asString:= GUIDNULO;
    FieldByName('bVisible').asInteger:= 1;
    FieldByName('refContrato').asString:= GUIDNULO;
  end;
end;

procedure TDM_LIQINQ.DataModuleCreate(Sender: TObject);
begin
  DM_General.CambiarEstadoTablas(TDataModule(DM_LIQINQ), true);
end;

procedure TDM_LIQINQ.tbLiqInqGastosAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLiqInqGasto').asString:= DM_General.CrearGUID;
    FieldByName('refLiqCabecera').asString:= GUIDNULO;
    FieldByName('refReparacion').asString:= GUIDNULO;
    FieldByName('Gasto').asString:= EmptyStr;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('refContrato').asString:= GUIDNULO;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_LIQINQ.tbLiquidacionAfterInsert(DataSet: TDataSet);
begin
   with DataSet do
   begin
     FieldByName('idLiqInqCabecera').asString:= DM_General.CrearGUID;
     FieldByName('Fecha').AsDateTime:= Now;
     FieldByName('Nro').asInteger:= -1;
     FieldByName('Monto').asFloat:= 0;
     FieldByName('bAnulada').asInteger:= 0;
     FieldByName('fAnulada').AsDateTime:= Null;
     FieldByName('refInquilino').asString:= GUIDNULO;
     FieldByName('refContrato').asString:= GUIDNULO;
   end;
end;

procedure TDM_LIQINQ.tbLiqInqItemsAfterInsert(DataSet: TDataSet);
begin
  With DataSet do
  begin
    FieldByName('idLiqInqItems').asString:= DM_General.CrearGUID;
    FieldByName('refLiqInqCabecera').asString:= tbLiquidacionidLiqInqCabecera.asString;
    FieldByName('refLiqInqItem').asString:= GUIDNULO;
    FieldByName('tipoItem').asInteger:= 0;
    FieldByName('montoPagado').AsFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_LIQINQ.tbLiqInqMesesAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLiqInqMes').asString:= DM_General.CrearGUID;
    FieldByName('refContratoCobro').asString:= GUIDNULO;
    FieldByName('refLiqCabecera').asString:= GUIDNULO;
    FieldByName('fVencimiento').AsDateTime:= Now;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('nPunitorios').asFloat:= 0;
    FieldByName('nTotal').asFloat:= 0;
    FieldByName('nMes').asInteger:= 0;
    FieldByName('nAno').asInteger:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;

procedure TDM_LIQINQ.tbLiqInqPagaresAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    FieldByName('idLiqInqPagare').asString:= DM_General.CrearGUID;
    FieldByName('refLiqCabecera').asString:= GUIDNULO;
    FieldByName('refContratoPagare').asString:= GUIDNULO;
    FieldByName('fVencimiento').AsDateTime:= Now;
    FieldByName('nMonto').asFloat:= 0;
    FieldByName('nPunitorios').asFloat:= 0;
    FieldByName('nTotal').asFloat:= 0;
    FieldByName('bVisible').asInteger:= 1;
  end;
end;



procedure TDM_LIQINQ.Grabar;
begin
  DM_General.GrabarDatos(tbMesesSEL, tbMesesINS, tbMesesUPD, tbLiqInqMeses, 'idLiqInqMes');
  DM_General.GrabarDatos(tbGastosSEL, tbGastosINS, tbGastosUPD, tbLiqInqGastos, 'idLiqInqGasto');
  DM_General.GrabarDatos(tbCajaSEL, tbCajaINS, tbCajaUPD, tbLiqInqCaja, 'idLiqInqCaja');
  DM_General.GrabarDatos(tbCajaSEL, tbCajaINS, tbCajaUPD, tbLiqInqCaja, 'idLiqInqCaja');
  DM_General.GrabarDatos(tbDescSEL, tbDescINS, tbDescUPD, tbLiqInqDescuentos, 'idLiqInqDescuento');
  DM_General.GrabarDatos(tbPagaresSEL, tbPagareINS, tbParareUPD, tbLiqInqPagares, 'idLiqInqPagare');
end;


(*******************************************************************************
*** ADMINISTRACIÖN DE LAS CUOTAS
********************************************************************************)

procedure TDM_LIQINQ.GenerarCuotasPeriodo(CuotaInicial, CuotaFinal: integer;
  MontoCuota: double; refContrato: GUID_ID; InicioContrato: TDate;
  diaVencimiento: Integer);
var
  idx,mes,ano,dia: word;
begin
  mes:= MonthOf(InicioContrato);
  ano:= YearOf(InicioContrato);
  dia:= StrToIntDef(IntToStr(diaVencimiento), DIA_VENCIMIENTO) ;
  if CuotaInicial > 1 then //Ajusto el salto entre la cuota inicial y el inicio del contrato
  begin
    IncAMonth(ano, mes, dia, CuotaInicial);
  end;
  For idx:= CuotaInicial to CuotaFinal do
  begin
    with tbLiqInqMeses do
    begin
      Insert;
      FieldByName('fVencimiento').AsDateTime:= EncodeDate(ano, mes, dia);
      FieldByName('refContratoCobro').AsString:= refContrato;
      FieldByName('nMonto').asFloat:= MontoCuota;
      FieldByName('nMes').asInteger:= mes;
      FieldByName('nAno').asInteger:= ano;
      Post;
      IncAMonth(ano, mes, dia);
    end;
  end;
  tbLiqInqMeses.SortOnFields('nAno;nMes');
  tbLiqInqMeses.First;
end;

procedure TDM_LIQINQ.CargarCuotasPorContrato(refContrato: GUID_ID);
begin
  with tbLiqInqMeses do
  begin
    First;
    While Not EOF do
    begin
      tbMesesDEL.ParamByName('idLiqInqMes').asString:= FieldByName('idLiqInqMes').asString;
      tbMesesDEL.ExecSQL;
      Next;
    end;
  end;
  DM_General.ReiniciarTabla(tbLiqInqMeses);


  with qLevantarCuotasContrato do
  begin
    if Active then close;
    ParamByName('refContrato').asString:= refContrato;
    Open;
    While Not EOF do
    begin
      GenerarCuotasPeriodo (FieldByName('CuotaInicio').asInteger
                           ,FieldByName('CuotaFin').asInteger
                           ,FieldByName('nMonto').asFloat
                           ,FieldByName('idContrato').asString
                           ,FieldByName('InicioContrato').AsDateTime
                           ,FieldByName('nDiaVencimiento').asInteger
                           );
      Next;
    end;
  end;
end;

procedure TDM_LIQINQ.LevantarCuotasPorContrato(refContrato: GUID_ID);
begin
  with qLevantarCuotasLiquidadas do
  begin
    if active then close;
    ParamByName('refContrato').AsString:= refContrato;
    Open;
    DM_General.ReiniciarTabla(tbLiqInqMeses);
    tbLiqInqMeses.LoadFromDataSet(qLevantarCuotasLiquidadas, 0, lmAppend);
    Close;
    tbLiqInqMeses.SortOnFields('nAno;NMes;fVencimiento');
  end;
end;

procedure TDM_LIQINQ.LevantarCuotasPorPropiedad(refPropiedad: GUID_ID);
begin
end;

procedure TDM_LIQINQ.LevantarCuentaCorrienteContrato(refContrato: GUID_ID);
begin
  LevantarCuotasPorContrato(refContrato);
  LevantarGastosPorContrato(refContrato);
  LevantarCajaPorContrato(refContrato);
  LevantarDescuentoPorContrato(refContrato);
  LevantarPagaresPorContrato (refContrato);
end;

function TDM_LIQINQ.MensualidadLiquidada(refMensualidad: GUID_ID): boolean;
begin
  Result:= (tbLiqInqMeses.FieldByName('idLiqInqMes').AsString <> GUIDNULO);
end;

procedure TDM_LIQINQ.BorrarLiqMensual;
begin
  if (tbLiqInqMeses.RecordCount > 0) then
  begin
    tbMesesDEL.ParamByName('idLiqInqMes').asString:= tbLiqInqMeses.FieldByName('idLiqInqMes').asString;
    tbMesesDEL.ExecSQL;
    tbLiqInqMeses.Delete;
  end;
end;

procedure TDM_LIQINQ.LevantarGastosPorContrato(refContrato: GUID_ID);
begin
  if tbLiqInqGastos.Active then tbLiqInqGastos.Close;
  qGastosPorContrato.ParamByName('refContrato').asString:= refContrato;
  qGastosPorContrato.Open;
  tbLiqInqGastos.LoadFromDataSet(qGastosPorContrato, 0, lmAppend);
  qGastosPorContrato.Close;
end;

procedure TDM_LIQINQ.LevantarCajaPorContrato(refContrato: GUID_ID);
begin
  if tbLiqInqCaja.Active then tbLiqInqCaja.Close;
  qCajaPorContrato.ParamByName('refContrato').asString:= refContrato;
  qCajaPorContrato.Open;
  tbLiqInqCaja.LoadFromDataSet(qCajaPorContrato, 0, lmAppend);
  qCajaPorContrato.Close;
end;

procedure TDM_LIQINQ.LevantarDescuentoPorContrato(refContrato: GUID_ID);
begin
  if tbLiqInqDescuentos.Active then tbLiqInqDescuentos.Close;
  qDescuentosPorContrato.ParamByName('refContrato').asString:= refContrato;
  qDescuentosPorContrato.Open;
  tbLiqInqDescuentos.LoadFromDataSet(qDescuentosPorContrato,0,lmAppend);
  qDescuentosPorContrato.Close;
end;

procedure TDM_LIQINQ.LevantarPagaresPorContrato(refContrato: GUID_ID);
begin
  if tbLiqInqPagares.Active then tbLiqInqPagares.Close;
  qPagaresPorContrato.ParamByName('refContrato').asString:= refContrato;
  qPagaresPorContrato.Open;
  tbLiqInqPagares.LoadFromDataSet(qPagaresPorContrato,0,lmAppend);
  qPagaresPorContrato.Close;
end;

procedure TDM_LIQINQ.AsentarGasto(refContrato: GUID_ID; descripcion: string;
  monto: double; operacion: TOperacion);
begin
  with tbLiqInqGastos do
  begin
    case operacion of
      nuevo: Insert;
      modificar: Edit;
    end;
    tbLiqInqGastosrefContrato.AsString:= refContrato;
    tbLiqInqGastosGasto.asString:= descripcion;
    tbLiqInqGastosnMonto.AsFloat:= monto;
    Post;
  end;
end;

procedure TDM_LIQINQ.BorrarGastoActual;
var
  refContrato: GUID_ID;
begin
  with tbLiqInqGastos do
  begin
    if (RecordCount > 0) then
    begin
      tbLiqInqGastos.Edit;
      tbLiqInqGastosbVisible.AsInteger:= 0;
      tbLiqInqGastos.Post;
      refContrato:= tbLiqInqGastosrefContrato.AsString;
      DM_General.GrabarDatos(tbGastosSEL, tbGastosINS, tbGastosUPD, tbLiqInqGastos, 'idLiqInqGasto');
      LevantarGastosPorContrato(refContrato);
    end;
  end;
end;

procedure TDM_LIQINQ.AsentarCaja(refContrato: GUID_ID; descripcion: string;
  monto: double; vencimiento: TDate; montoPagado: double; fPago: TDate;
  refTipo: integer;operacion: TOperacion);
begin
  with tbLiqInqCaja do
  begin
    case operacion of
      nuevo: Insert;
      modificar: Edit;
    end;
    tbLiqInqCajarefContrato.AsString:= refContrato;
    tbLiqInqCajaDescripcion.asString:= descripcion;
    tbLiqInqCajaMonto.AsFloat:= monto;
    tbLiqInqCajafVencimiento.AsDateTime:= vencimiento;
    tbLiqInqCajaPagado.asFloat:= montoPagado;
    tbLiqInqCajafPago.AsDateTime:=fPago;
    tbLiqInqCajarefTipo.AsInteger:= refTipo;
    Post;
  end;
end;

procedure TDM_LIQINQ.BorrarCajaActual;
var
  refContrato: GUID_ID;
begin
  with tbLiqInqCaja do
  begin
    if (RecordCount > 0) then
    begin
      tbLiqInqCaja.Edit;
      tbLiqInqCajabVisible.AsInteger:= 0;
      tbLiqInqCaja.Post;
      refContrato:= tbLiqInqCajarefContrato.AsString;
      DM_General.GrabarDatos(tbCajaSEL, tbCajaINS, tbCajaUPD, tbLiqInqCaja, 'idLiqInqCaja');
      LevantarCajaPorContrato(refContrato);
    end;
  end;
end;

procedure TDM_LIQINQ.AsentarDescuento(refContrato: GUID_ID;
  descripcion: string; monto: double; operacion: TOperacion);
begin
  with tbLiqInqDescuentos do
  begin
    case operacion of
      nuevo: Insert;
      modificar: Edit;
    end;
    tbLiqInqDescuentosrefContrato.AsString:= refContrato;
    tbLiqInqDescuentosDescuento.asString:= descripcion;
    tbLiqInqDescuentosnMonto.AsFloat:= monto;
    Post;
  end;
end;

procedure TDM_LIQINQ.BorrarDescuentoActual;
var
  refContrato: GUID_ID;
begin
  with tbLiqInqDescuentos do
  begin
    if (RecordCount > 0) then
    begin
      tbLiqInqDescuentos.Edit;
      tbLiqInqDescuentosbVisible.AsInteger:= 0;
      tbLiqInqDescuentos.Post;
      refContrato:= tbLiqInqDescuentosrefContrato.AsString;
      DM_General.GrabarDatos(tbDescSEL, tbDescINS, tbDescUPD, tbLiqInqDescuentos, 'idLiqInqDescuento');
      LevantarDescuentoPorContrato(refContrato);
    end;
  end;
end;

procedure TDM_LIQINQ.AsentarPagare(refContrato: GUID_ID; fVencimiento: TDate;
  monto, punitorios, total: double; operacion: TOperacion);
begin
  with tbLiqInqPagares do
  begin
    case operacion of
      nuevo: Insert;
      modificar: Edit;
    end;
    tbLiqInqPagaresrefContratoPagare.AsString:= refContrato;
    tbLiqInqPagaresfVencimiento.AsDateTime:= fVencimiento;
    tbLiqInqPagaresnMonto.AsFloat:= monto;
    tbLiqInqPagaresnPunitorios.AsFloat:= punitorios;
    tbLiqInqPagaresnTotal.asFloat:= total;
    Post;
  end;
end;

procedure TDM_LIQINQ.BorrarPagareActual;
var
  refContrato: GUID_ID;
begin
  with tbLiqInqPagares do
  begin
    if (RecordCount > 0) then
    begin
      tbLiqInqPagares.Edit;
      tbLiqInqPagaresbVisible.AsInteger:= 0;
      tbLiqInqPagares.Post;
      refContrato:= tbLiqInqPagaresrefContratoPagare.AsString;

      DM_General.GrabarDatos(tbPagaresSEL, tbPagareINS, tbParareUPD, tbLiqInqPagares, 'idLiqInqPagare');
      LevantarPagaresPorContrato(refContrato);
    end;
  end;
end;

procedure TDM_LIQINQ.CargarLiquidacionMes(elMes,elAno: word;idContrato: GUID_ID);
begin
  //Refresco los datos por si se cargaron desde otra terminal
  Grabar;
  LevantarCajaPorContrato(idContrato);
  LevantarCuentaCorrienteContrato(idContrato);
  LevantarCuotasPorContrato(idContrato);
  LevantarDescuentoPorContrato(idContrato);
  LevantarGastosPorContrato(idContrato);
  LevantarPagaresPorContrato(idContrato);

  //Levantar los datos en la tabla items de liquidacion

  ObtenerVencimientosMes(elMes,elAno,idContrato);


  //Ajustar items por gastos parciales
end;

procedure TDM_LIQINQ.ObtenerVencimientosMes(elMes, elAno: word;
  idContrato: GUID_ID);
var
  fechaCorte: TDateTime;
begin
  fechaCorte:= EncodeDateTime(elAno, elMes, DaysInAMonth(elAno, elMes), 0,0,0,0);
  with qVencimientosMes do
  begin
    if active then close;
    ParamByName('refContrato').asString:= idContrato;
    ParamByName('fechaCorte').AsDateTime:= fechaCorte;
    Open;
    While Not EOF do
    begin
      tbLiqInqItems.Insert;
      tbLiqInqItems.FieldByName('refLiqInqItem').asString:= FieldByName('idLiqInqMes').asString;
      tbLiqInqItems.FieldByName('montoPagado').asFloat:= FieldByName('nTotal').asFloat;
      tbLiqInqItems.FieldByName('tipoItem').asInteger:= INQ_ITEM_MENSUALIDAD;
      tbLiqInqItems.FieldByName('Detalle').asString:= 'PAGO MENSUAL MES: ' + IntToStr(FieldByName('nMes').asInteger)+ 'ANO: ' + IntToStr(FieldByName('Ano').asInteger);
      tbLiqInqITems.Post;
      Next;
    end;
  end;
end;


end.

