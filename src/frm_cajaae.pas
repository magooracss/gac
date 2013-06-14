unit frm_cajaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Spin, StdCtrls, EditBtn, Buttons
  ,dmgeneral;

type

  { TfrmCajaAE }

  TfrmCajaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnReferencia: TBitBtn;
    cbTipoCaja: TComboBox;
    edVencimiento: TDateEdit;
    edFechaPago: TDateEdit;
    edMonto: TFloatSpinEdit;
    edDescripcion: TLabeledEdit;
    edPagado: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edReferencia: TLabeledEdit;
    Panel1: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function getDescripcion: string;
    function getfPago: TDate;
    function getFVencimiento: TDate;
    function getMonto: double;
    function getMontoPago: double;
    function getrefTipo: integer;
    procedure setDescripcion(AValue: string);
    procedure setfPago(AValue: TDate);
    procedure setFVencimiento(AValue: TDate);
    procedure setMonto(AValue: double);
    procedure setMontoPago(AValue: double);
    procedure setrefTipo(AValue: integer);
    { private declarations }

    procedure Inicializar;
  public
    property descripcion: string read getDescripcion write setDescripcion;
    property monto: double read getMonto write setMonto;
    property fVencimiento: TDate read getFVencimiento write setFVencimiento;
    property montoPago: double read getMontoPago write setMontoPago;
    property fPago: TDate read getfPago write setfPago;
    property refTipo: integer read getrefTipo write setrefTipo;
  end;

var
  frmCajaAE: TfrmCajaAE;

implementation
{$R *.lfm}
uses
  dmcaja
  ;

{ TfrmCajaAE }

procedure TfrmCajaAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCajaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCajaAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmCajaAE.getDescripcion: string;
begin
  Result:= TRIM(edDescripcion.Text);
end;

function TfrmCajaAE.getfPago: TDate;
begin
  Result:= edFechaPago.Date;
end;

function TfrmCajaAE.getFVencimiento: TDate;
begin
  Result:= edVencimiento.Date;
end;

function TfrmCajaAE.getMonto: double;
begin
  Result:= edMonto.Value;
end;

function TfrmCajaAE.getMontoPago: double;
begin
  Result:= edPagado.Value;
end;

function TfrmCajaAE.getrefTipo: integer;
begin
  Result:= DM_General.obtenerIDIntComboBox(cbTipoCaja);
end;

procedure TfrmCajaAE.setDescripcion(AValue: string);
begin
  edDescripcion.Text:= TRIM(AValue);
end;

procedure TfrmCajaAE.setfPago(AValue: TDate);
begin
  edFechaPago.Date:= AValue;
end;

procedure TfrmCajaAE.setFVencimiento(AValue: TDate);
begin
  edVencimiento.Date:= AValue;
end;

procedure TfrmCajaAE.setMonto(AValue: double);
begin
  edMonto.Value:= AValue;
end;

procedure TfrmCajaAE.setMontoPago(AValue: double);
begin
  edPagado.Value:= AValue;
end;

procedure TfrmCajaAE.setrefTipo(AValue: integer);
begin
  cbTipoCaja.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoCaja, AValue);
end;

procedure TfrmCajaAE.Inicializar;
begin
  DM_Caja.CargarCbTipos(cbTipoCaja, 'TipoMovimiento','idCajaTipoMovimiento',ALCANCE_INQUILINOS);
end;

end.

