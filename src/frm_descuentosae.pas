unit frm_descuentosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Spin, Buttons, StdCtrls;

type

  { TfrmDescuentosAE }

  TfrmDescuentosAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    edDetalle: TLabeledEdit;
    edMonto: TFloatSpinEdit;
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
  frmDescuentosAE: TfrmDescuentosAE;

implementation

{$R *.lfm}

{ TfrmDescuentosAE }

procedure TfrmDescuentosAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmDescuentosAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

function TfrmDescuentosAE.getDescripcion: string;
begin
  Result:= TRIM(edDetalle.Text);
end;

function TfrmDescuentosAE.getMonto: double;
begin
  Result:= edMonto.Value;
end;

procedure TfrmDescuentosAE.setDescripcion(AValue: string);
begin
   edDetalle.Text:= aValue;
end;

procedure TfrmDescuentosAE.setMonto(AValue: double);
begin
  edMonto.Value:= AValue;
end;

end.

