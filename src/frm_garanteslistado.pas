unit frm_garanteslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, StdCtrls
  ,dmgeneral;

type

  { TfrmGarantesListado }

  TfrmGarantesListado = class(TForm)
    btnSalir: TBitBtn;
    btnInqAgregar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    btnBuscar: TBitBtn;
    cbCriterio: TComboBox;
    DS_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edBuscar: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnInqAgregarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    function getIdGaranteSeleccionado: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
    procedure pantallaGarantes (refGarante: GUID_ID);
  public
    property idGaranteSeleccionado: GUID_ID read getIdGaranteSeleccionado;
  end; 

var
  frmGarantesListado: TfrmGarantesListado;

implementation
{$R *.lfm}
 uses
   dmGarantes
   ,frm_garantesae
   ;

 const
  IDX_BUS_APELLIDO = 0;
  IDX_BUS_DOCUMENTO = 1;
  IDX_BUS_CUIT = 2;
  TX_BUS_APELLIDO = 'Apellido del Garante';
  TX_BUS_DOCUMENTO = 'Documento del Garante';
  TX_BUS_CUIT = 'CUIT del Garante';

 { TfrmGarantesListado }

 procedure TfrmGarantesListado.btnBuscarClick(Sender: TObject);
 begin
   Buscar;
 end;

 procedure TfrmGarantesListado.btnEliminarClick(Sender: TObject);
 begin
   if (MessageDlg ('ATENCION', 'Borro el Garante seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_Garantes.BorrarGarante (DM_Garantes.idGaranteSeleccionado);
     Buscar;
   end;
 end;

 procedure TfrmGarantesListado.Inicializar;
 begin
   edBuscar.Clear;
   cbCriterio.Items.Insert(IDX_BUS_APELLIDO,TX_BUS_APELLIDO);
   cbCriterio.Items.Insert(IDX_BUS_DOCUMENTO,TX_BUS_DOCUMENTO);
   cbCriterio.Items.Insert(IDX_BUS_CUIT,TX_BUS_CUIT);
   cbCriterio.ItemIndex:= IDX_BUS_APELLIDO;
 end;

procedure TfrmGarantesListado.Buscar;
var
  resultado: boolean;
begin
  resultado:= False;
  case cbCriterio.ItemIndex of
   IDX_BUS_APELLIDO: resultado:= DM_Garantes.BuscarGaranteApellido(TRIM(edBuscar.Text));
   IDX_BUS_DOCUMENTO: resultado:= DM_Garantes.BuscarGaranteDocumento(TRIM(edBuscar.Text));
   IDX_BUS_CUIT: resultado:= DM_Garantes.BuscarGaranteCUIT(TRIM(edBuscar.Text));
  end;
  if resultado = False then
  begin
//    btnSalir.Enabled:= False;
   // ShowMessage('No se encontraron resultados');
  end;
//  else
//    btnSalir.Enabled:= True;
 end;

procedure TfrmGarantesListado.pantallaGarantes(refGarante: GUID_ID);
var
  pant: TfrmGarantesAE;
begin
  pant:= TfrmGarantesAE.Create(self);
  try
    pant.idGarante:= refGarante;
    if pant.ShowModal = mrOK then;
    begin
      edBuscar.Text:= pant.Apellido;
      cbCriterio.ItemIndex:= IDX_BUS_APELLIDO;
      Buscar;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmGarantesListado.btnInqAgregarClick(Sender: TObject);
begin
  pantallaGarantes(GUIDNULO);
end;

procedure TfrmGarantesListado.btnModificarClick(Sender: TObject);
begin
  pantallaGarantes(DM_Garantes.idGaranteSeleccionado);
end;

procedure TfrmGarantesListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmGarantesListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmGarantesListado.getIdGaranteSeleccionado: GUID_ID;
begin
  Result:= DM_Garantes.idGaranteSeleccionado;
end;

end.

