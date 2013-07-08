unit frm_selMes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls;

type

  { TfrmSeleccionMes }

  TfrmSeleccionMes = class(TForm)
    BitBtn1: TBitBtn;
    btnCancelar: TBitBtn;
    cbMes: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function getMesSeleccionado: integer;
    { private declarations }
  public
    property MesSeleccionado: integer read getMesSeleccionado;

  end;

var
  frmSeleccionMes: TfrmSeleccionMes;

implementation
{$R *.lfm}
uses
  dateutils
  ;

{ TfrmSeleccionMes }

procedure TfrmSeleccionMes.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmSeleccionMes.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmSeleccionMes.FormShow(Sender: TObject);
begin
  cbMes.ItemIndex:= MonthOf(Now) -1;
end;

function TfrmSeleccionMes.getMesSeleccionado: integer;
begin
  Result:= cbMes.ItemIndex + 1;
end;

end.

