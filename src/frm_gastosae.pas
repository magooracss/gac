unit frm_gastosAE;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Spin, Buttons;

type

  { TfrmGastoAE }

  TfrmGastoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    edMonto: TFloatSpinEdit;
    edDetalle: TLabeledEdit;
    Label1: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    function getDescripcion: string;
    function getMonto: double;
    procedure setDescripcion(AValue: string);
    procedure setMonto(AValue: double);
    { private declarations }
  public
    property descripcion: string read getDescripcion write setDescripcion;
    property monto: double read getMonto write setMonto;
  end;

var
  frmGastoAE: TfrmGastoAE;

implementation

{$R *.lfm}

{ TfrmGastoAE }

procedure TfrmGastoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmGastoAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

function TfrmGastoAE.getDescripcion: string;
begin
  Result:= TRIM(edDetalle.Text);
end;

function TfrmGastoAE.getMonto: double;
begin
  Result:= edMonto.Value;
end;

procedure TfrmGastoAE.setDescripcion(AValue: string);
begin
  edDetalle.Text:= aValue;
end;

procedure TfrmGastoAE.setMonto(AValue: double);
begin
  edMonto.Value:= AValue;
end;

end.

