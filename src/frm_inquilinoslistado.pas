unit frm_inquilinoslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, StdCtrls
  ,dmgeneral;

type

  { TfrmInquilinosListado }

  TfrmInquilinosListado = class(TForm)
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
    function getIdInquilinoSeleccionado: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
    procedure pantallaInquilinos (refInquilino: GUID_ID);
  public
    property idInquilinoSeleccionado: GUID_ID read getIdInquilinoSeleccionado;
  end; 

var
  frmInquilinosListado: TfrmInquilinosListado;

implementation
{$R *.lfm}
 uses
   dminquilinos
   ,frm_inquilinosae
   ;

 const
  IDX_BUS_APELLIDO = 0;
  IDX_BUS_DOCUMENTO = 1;
  IDX_BUS_CUIT = 2;
  TX_BUS_APELLIDO = 'Apellido del Inquilino';
  TX_BUS_DOCUMENTO = 'Documento del Inquilino';
  TX_BUS_CUIT = 'CUIT del Inquilino';

 { TfrmInquilinosListado }

 procedure TfrmInquilinosListado.btnBuscarClick(Sender: TObject);
 begin
   Buscar;
 end;

 procedure TfrmInquilinosListado.btnEliminarClick(Sender: TObject);
 begin
   if (MessageDlg ('ATENCION', 'Borro el inquilino seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_Inquilinos.BorrarInquilino (DM_Inquilinos.idInquilinoSeleccionado);
     Buscar;
   end;
 end;

 procedure TfrmInquilinosListado.Inicializar;
 begin
   edBuscar.Clear;
   cbCriterio.Items.Insert(IDX_BUS_APELLIDO,TX_BUS_APELLIDO);
   cbCriterio.Items.Insert(IDX_BUS_DOCUMENTO,TX_BUS_DOCUMENTO);
   cbCriterio.Items.Insert(IDX_BUS_CUIT,TX_BUS_CUIT);
   cbCriterio.ItemIndex:= IDX_BUS_APELLIDO;
 end;

procedure TfrmInquilinosListado.Buscar;
var
  resultado: boolean;
begin
  resultado:= False;
  case cbCriterio.ItemIndex of
   IDX_BUS_APELLIDO: resultado:= DM_Inquilinos.BuscarInquilinoApellido(TRIM(edBuscar.Text));
   IDX_BUS_DOCUMENTO: resultado:= DM_Inquilinos.BuscarInquilinoDocumento(TRIM(edBuscar.Text));
   IDX_BUS_CUIT: resultado:= DM_Inquilinos.BuscarInquilinoCUIT(TRIM(edBuscar.Text));
  end;
  if resultado = False then
  begin
//    btnSalir.Enabled:= False;
    ShowMessage('No se encontraron resultados');
  end;
//  else
//    btnSalir.Enabled:= True;
 end;

procedure TfrmInquilinosListado.pantallaInquilinos(refInquilino: GUID_ID);
var
  pant: TfrmInquilinosAE;
begin
  pant:= TfrmInquilinosAE.Create(self);
  try
    pant.idInquilino:= refInquilino;
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

procedure TfrmInquilinosListado.btnInqAgregarClick(Sender: TObject);
begin
  pantallaInquilinos(GUIDNULO);
end;

procedure TfrmInquilinosListado.btnModificarClick(Sender: TObject);
begin
  pantallaInquilinos(DM_Inquilinos.idInquilinoSeleccionado);
end;

procedure TfrmInquilinosListado.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmInquilinosListado.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmInquilinosListado.getIdInquilinoSeleccionado: GUID_ID;
begin
  Result:= DM_Inquilinos.idInquilinoSeleccionado;
end;

end.

