unit frm_pagaresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, Spin, Buttons;

type

  { TfrmPagaresAE }

  TfrmPagaresAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    edMonto: TFloatSpinEdit;
    edPunitorios: TFloatSpinEdit;
    edTotal: TFloatSpinEdit;
    edVencimiento: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    function getFVencimiento: TDate;
    function getMonto: double;
    function getMontoPunitorios: double;
    function getMontoTotal: double;
    procedure setFVencimiento(AValue: TDate);
    procedure setMonto(AValue: double);
    procedure setMontoPunitorios(AValue: double);
    procedure setMontoTotal(AValue: double);
    { private declarations }
  public
    property fVencimiento: TDate read getFVencimiento write setFVencimiento;
    property monto: double read getMonto write setMonto;
    property montoPunitorios: double read getMontoPunitorios write setMontoPunitorios;
    property montoTotal: double read getMontoTotal write setMontoTotal;
  end;

var
  frmPagaresAE: TfrmPagaresAE;

implementation

{$R *.lfm}

{ TfrmPagaresAE }

procedure TfrmPagaresAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPagaresAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

function TfrmPagaresAE.getFVencimiento: TDate;
begin
  Result:= edVencimiento.Date;
end;

function TfrmPagaresAE.getMonto: double;
begin
  Result:= edMonto.Value;
end;

function TfrmPagaresAE.getMontoPunitorios: double;
begin
  Result:= edPunitorios.Value;
end;

function TfrmPagaresAE.getMontoTotal: double;
begin
  Result:= edTotal.Value;
end;

procedure TfrmPagaresAE.setFVencimiento(AValue: TDate);
begin
  edVencimiento.Date:= AValue;
end;

procedure TfrmPagaresAE.setMonto(AValue: double);
begin
  edMonto.Value:= AValue;
end;

procedure TfrmPagaresAE.setMontoPunitorios(AValue: double);
begin
  edPunitorios.Value:= AValue;
end;

procedure TfrmPagaresAE.setMontoTotal(AValue: double);
begin
  edTotal.Value:= AValue;
end;

end.

