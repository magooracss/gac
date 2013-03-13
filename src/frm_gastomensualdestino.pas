unit frm_gastomensualdestino;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, Buttons;

type

  { TfrmDestinoGasto }

  TfrmDestinoGasto = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ckPropietario: TCheckBox;
    ckInquilino: TCheckBox;
    edMonto: TFloatSpinEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    function getbInquilino: integer;
    function getbPropietario: integer;
    function getMonto: double;
    procedure setbInquilino(const AValue: integer);
    procedure setbPropietario(const AValue: integer);
    procedure setMonto(const AValue: double);

    function SeleccionValida: boolean;
  public
    property bPropietario: integer read getbPropietario write setbPropietario;
    property bInquilino: integer read getbInquilino write setbInquilino;
    property Monto: double read getMonto write setMonto;
  end; 

var
  frmDestinoGasto: TfrmDestinoGasto;

implementation

{$R *.lfm}

{ TfrmDestinoGasto }

procedure TfrmDestinoGasto.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmDestinoGasto.btnAceptarClick(Sender: TObject);
begin
  if SeleccionValida then
    ModalResult:= mrOK
  else
    ShowMessage('Debe asignar el gasto al propietario, al inquilino o a ambos');
end;

function TfrmDestinoGasto.getbInquilino: integer;
begin
  if ckInquilino.Checked then
    Result:= 1
  else
    Result:= 0;
end;

function TfrmDestinoGasto.getbPropietario: integer;
begin
  if ckPropietario.Checked then
    Result:= 1
  else
    Result:= 0;
end;

function TfrmDestinoGasto.getMonto: double;
begin
  Result:= edMonto.Value;
end;

procedure TfrmDestinoGasto.setbInquilino(const AValue: integer);
begin
  ckInquilino.Checked:= (aValue = 1);
end;

procedure TfrmDestinoGasto.setbPropietario(const AValue: integer);
begin
  ckPropietario.Checked:= (AValue = 1);
end;

procedure TfrmDestinoGasto.setMonto(const AValue: double);
begin
  edMonto.Value:= AValue;
end;

function TfrmDestinoGasto.SeleccionValida: boolean;
begin
  Result:= ckInquilino.Checked OR ckPropietario.Checked;
end;

end.

