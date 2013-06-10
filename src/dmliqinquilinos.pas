unit dmliqinquilinos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral
  ;

type

  { TDM_LIQINQ }

  TDM_LIQINQ = class(TDataModule)
    qLevantarCuotasContrato: TZQuery;
    qLevantarCuotasLiquidadas: TZQuery;
    tbLiqInqCajabVisible: TLongintField;
    tbLiqInqCajaDescripcion: TStringField;
    tbLiqInqCajafPago: TDateTimeField;
    tbLiqInqCajafVencimiento: TDateField;
    tbLiqInqCajaidLiqInqCaja: TStringField;
    tbLiqInqCajaMonto: TFloatField;
    tbLiqInqCajaPagado: TFloatField;
    tbLiqInqCajareferencia: TStringField;
    tbLiqInqCajarefLiqInqCabecera: TStringField;
    tbLiqInqCajarefTipo: TLongintField;
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
    procedure tbLiqInqCajaAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqDescuentosAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqGastosAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqMesesAfterInsert(DataSet: TDataSet);
    procedure tbLiqInqPagaresAfterInsert(DataSet: TDataSet);
  private

  public
    procedure CargarCuotasPorContrato (refContrato: GUID_ID); // Dado un contrato, se generan las cuotas a liquidar
    procedure LevantarCuotasPorContrato (refContrato: GUID_ID); //Levanta de la base las cuotas del contrato
    procedure LevantarCuotasPorPropiedad (refPropiedad: GUID_ID);

    function MensualidadLiquidada (refMensualidad: GUID_ID): boolean;
    procedure BorrarLiqMensual;

    procedure Grabar;

    procedure GenerarCuotasPeriodo (CuotaInicial, CuotaFinal: integer; MontoCuota: double
                                   ; refContrato: GUID_ID; InicioContrato: TDate; diaVencimiento: Integer);


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
  end;
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

end.

