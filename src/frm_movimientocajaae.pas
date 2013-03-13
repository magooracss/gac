unit frm_movimientocajaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, EditBtn,
  StdCtrls, Spin, Buttons
  ,dmcaja  ;

type

  { TfrmMovimientoCajaAE }

  TfrmMovimientoCajaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbTipoMovimiento: TComboBox;
    edFecha: TDateEdit;
    edDetalles: TEdit;
    edMonto: TFloatSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _tipoMovimiento: TmovimientoCaja;
    procedure Inicializar;
  public
    property TipoMovimiento: TmovimientoCaja write _tipoMovimiento;
  end; 

var
  frmMovimientoCajaAE: TfrmMovimientoCajaAE;

implementation
{$R *.lfm}



{ TfrmMovimientoCajaAE }

procedure TfrmMovimientoCajaAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmMovimientoCajaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmMovimientoCajaAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmMovimientoCajaAE.Inicializar;
begin
  edFecha.Date:= now;

  cbTipoMovimiento.Clear;
  cbTipoMovimiento.Items.Add ('INGRESO');
  cbTipoMovimiento.Items.Add ('EGRESO');

  cbTipoMovimiento.Enabled:= false;
  Case _tipoMovimiento of
   ingreso: cbTipoMovimiento.ItemIndex:= 0;
   egreso: cbTipoMovimiento.ItemIndex:= 1;
  else
   begin
    cbTipoMovimiento.Enabled:= true;
    cbTipoMovimiento.ItemIndex:= 0;
   end;
  end;
end;

end.

