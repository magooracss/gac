unit dmliquidaciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;


type
  TDestinoLiq = (inquilino, propietario);
  TTipoLiq = (gasto, descuento, mes, pagare, pago);

  { TDM_Liquidacion }

  TDM_Liquidacion = class(TDataModule)
    qLiqInqDescuentos: TZQuery;
    tbContratosSEL1: TZQuery;
    tbContratosSEL2: TZQuery;
    tbContratosSEL3: TZQuery;
    tbContratosSEL4: TZQuery;
    tbContratosSEL5: TZQuery;
    tbLiqContrato: TRxMemoryData;
  private
//    procedure CargarRegistroLiqContrato (elDestino: TDestinoLiq; elTipoLiq: TTipoLiq; consulta: TZQuery);
  public
    procedure InqContratoDescuento (refContrato: GUID_ID);
    procedure InqContratoGasto (refContrato: GUID_ID);
    procedure InqContratoMeses (refContrato: GUID_ID);
    procedure InqContratoPagares (refContrato: GUID_ID);

    procedure PropContratoDescuento (refContrato: GUID_ID);
    procedure PropContratoPagos (refContrato: GUID_ID);

    procedure LevantarLiqContrato (refContrato: GUID_ID);
  end; 

var
  DM_Liquidacion: TDM_Liquidacion;

implementation

{$R *.lfm}

{ TDM_Liquidacion }

(*******************************************************************************
*** LIQUIDACIONES INQUILINO
*******************************************************************************)
procedure TDM_Liquidacion.InqContratoDescuento(refContrato: GUID_ID);
begin

end;

procedure TDM_Liquidacion.InqContratoGasto(refContrato: GUID_ID);
begin

end;

procedure TDM_Liquidacion.InqContratoMeses(refContrato: GUID_ID);
begin

end;

procedure TDM_Liquidacion.InqContratoPagares(refContrato: GUID_ID);
begin

end;

(*******************************************************************************
*** LIQUIDACIONES PROPIETARIO
*******************************************************************************)

procedure TDM_Liquidacion.PropContratoDescuento(refContrato: GUID_ID);
begin

end;

procedure TDM_Liquidacion.PropContratoPagos(refContrato: GUID_ID);
begin

end;

(*******************************************************************************
*** GENERALES
*******************************************************************************)

procedure TDM_Liquidacion.LevantarLiqContrato(refContrato: GUID_ID);
begin
  DM_General.ReiniciarTabla(tbLiqContrato);
  InqContratoDescuento(refContrato);
//  CargarRegistroLiqContrato (RX_Inquilino, RX_Destino, qLiqInqDescuentos);

end;

end.

