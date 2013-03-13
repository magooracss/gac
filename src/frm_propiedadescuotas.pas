unit frm_propiedadescuotas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons
  ,dmgeneral;

type

  { TfrmPropiedadesCuotas }

  TfrmPropiedadesCuotas = class(TForm)
    btnAgregar: TBitBtn;
    btnEliminar: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_cuotas: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    operacion: TOperacion;
    idPropiedad: GUID_ID;
  end; 

var
  frmPropiedadesCuotas: TfrmPropiedadesCuotas;

implementation
{$R *.lfm}
uses
 dmpropiedades
 ;

{ TfrmPropiedadesCuotas }

procedure TfrmPropiedadesCuotas.FormShow(Sender: TObject);
begin
  if operacion = modificar then
    DM_Propiedades.levantarCuotas (idPropiedad);
  ;
end;

procedure TfrmPropiedadesCuotas.btnAgregarClick(Sender: TObject);
begin
  DM_Propiedades.NuevaCuota;
end;

procedure TfrmPropiedadesCuotas.btnCancelarClick(Sender: TObject);
begin
  DM_Propiedades.levantarCuotas (idPropiedad);
  ModalResult:= mrCancel;
end;

procedure TfrmPropiedadesCuotas.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro las cuotas seleccionadas', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Propiedades.EliminarCuotaActual;
end;

procedure TfrmPropiedadesCuotas.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

