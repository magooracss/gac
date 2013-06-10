unit frm_cuentacontratoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, StdCtrls, EditBtn, Spin, Buttons, types;

type

  { TfrmCuentaContratoAE }

  TfrmCuentaContratoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbDestino: TComboBox;
    cbTipo:    TComboBox;
    edDescInqDetalle: TEdit;
    edGastoInqDetalle: TEdit;
    edGastoInqMonto: TFloatSpinEdit;
    edMensInqFecha: TDateEdit;
    edMensInqFecha1: TDateEdit;
    edMensInqMonto: TFloatSpinEdit;
    edMensInqMonto1: TFloatSpinEdit;
    edMensInqPunitorios: TFloatSpinEdit;
    edDescInqMonto: TFloatSpinEdit;
    edMensInqPunitorios1: TFloatSpinEdit;
    edMensInqTotal: TFloatSpinEdit;
    edMensInqTotal1: TFloatSpinEdit;
    Label1:    TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2:    TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PCInquilinos: TPageControl;
    PCPropietarios: TPageControl;
    PCDestino: TPageControl;
    Panel1:    TPanel;
    Panel2:    TPanel;
    edMensInqMes: TSpinEdit;
    edMensInqAno: TSpinEdit;
    tabInquilinos: TTabSheet;
    tabPropietarios: TTabSheet;
    tabPagos: TTabSheet;
    tabDescuentos: TTabSheet;
    tabMensualidad: TTabSheet;
    tabDescuento: TTabSheet;
    tabGasto: TTabSheet;
    tabPagare: TTabSheet;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cbDestinoChange(Sender: TObject);
    procedure cbTipoChange(Sender: TObject);
    procedure edMensInqMontoChange(Sender: TObject);
    procedure edMensInqPunitoriosChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabMensualidadShow(Sender: TObject);
    procedure tabPagareContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private
    procedure CargarDestinos;
    procedure CargarTipos;
    procedure Inicializar;

    procedure InicializarMensualidad;
  public
    { public declarations }
  end;

var
  frmCuentaContratoAE: TfrmCuentaContratoAE;

implementation

{$R *.lfm}
uses
   dateutils
   ;

const
  IDX_INQUILINOS = 0;
  IDX_PROPIETARIOS = 1;
  IDX_MES    = 0;
  IDX_DESCUENTO = 1;
  IDX_GASTO  = 2;
  IDX_PAGARE = 3;
  IDX_PAGO   = 0;


{ TfrmCuentaContratoAE }


procedure TfrmCuentaContratoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmCuentaContratoAE.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;


procedure TfrmCuentaContratoAE.cbDestinoChange(Sender: TObject);
begin
  CargarTipos;
end;


procedure TfrmCuentaContratoAE.cbTipoChange(Sender: TObject);
begin
   case cbDestino.ItemIndex of
     IDX_INQUILINOS: PCInquilinos.ActivePageIndex:= cbTipo.ItemIndex;
     IDX_PROPIETARIOS: PCPropietarios.ActivePageIndex:= cbTipo.ItemIndex;
   end;
end;


procedure TfrmCuentaContratoAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmCuentaContratoAE.CargarDestinos;
begin
  cbDestino.Clear;
  with cbDestino do
  begin
    Items.Insert(IDX_INQUILINOS, 'Inquilinos');
    Items.Insert(IDX_PROPIETARIOS, 'Propietarios');
    ItemIndex:=IDX_INQUILINOS;
  end;
  PCDestino.ActivePageIndex:= IDX_INQUILINOS;
end;

procedure TfrmCuentaContratoAE.CargarTipos;
begin
  cbTipo.Clear;
  with cbTipo do
  begin
    case cbDestino.ItemIndex of
      IDX_INQUILINOS:
      begin
        Items.Insert(IDX_MES, 'Mensualidad');
        Items.Insert(IDX_DESCUENTO, 'Descuento');
        Items.Insert(IDX_GASTO, 'Gasto');
        Items.Insert(IDX_PAGARE, 'Pagaré');
        ItemIndex:= IDX_MES;
        PCInquilinos.ActivePageIndex:= IDX_MES;
        PCDestino.ActivePageIndex:= IDX_INQUILINOS;
      end;
      IDX_PROPIETARIOS:
      begin
        Items.Insert(IDX_PAGO, 'Pago');
        Items.Insert(IDX_DESCUENTO, 'Descuento');
        ItemIndex:= IDX_PAGO;
        PCPropietarios.ActivePageIndex:= IDX_PAGO;
        PCDestino.ActivePageIndex:= IDX_PROPIETARIOS;
      end;
    end;
  end;
end;

procedure TfrmCuentaContratoAE.Inicializar;
begin
  CargarDestinos;
  CargarTipos;

end;


(*******************************************************************************
*** MENSUALIDADES
*******************************************************************************)

procedure TfrmCuentaContratoAE.InicializarMensualidad;
begin
  edMensInqAno.Value:= YearOf(Now);
  edMensInqFecha.Date:= Now;
  edMensInqMes.Value:= MonthOf(Now);
  edMensInqMonto.Value:=0;
  edMensInqPunitorios.Value:= 0;
  edMensInqTotal.Value:= 0;
end;

procedure TfrmCuentaContratoAE.edMensInqMontoChange(Sender: TObject);
begin
  edMensInqTotal.Value:= edMensInqMonto.Value + edMensInqPunitorios.Value;
end;

procedure TfrmCuentaContratoAE.edMensInqPunitoriosChange(Sender: TObject);
begin
  edMensInqTotal.Value:= edMensInqMonto.Value + edMensInqPunitorios.Value;
end;

procedure TfrmCuentaContratoAE.tabMensualidadShow(Sender: TObject);
begin
  InicializarMensualidad;
end;

procedure TfrmCuentaContratoAE.tabPagareContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;


end.

