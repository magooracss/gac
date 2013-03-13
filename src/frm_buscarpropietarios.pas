unit frm_buscarpropietarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons
  ,dmgeneral
  ,dmpropietarios;

type

  { TfrmBuscarPropietarios }

  TfrmBuscarPropietarios = class(TForm)
    btnNuevo: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnBuscar: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbCriterio: TComboBox;
    ds_Busqueda: TDatasource;
    DBGrid1: TDBGrid;
    edBuscar: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure edBuscarKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    function getIdPropietarioActual: string;
    procedure Inicializar;

    procedure Buscar;
    procedure pantallaPropietarios(refPropietario: GUID_ID);

  public
    property idPropietario: string read getIdPropietarioActual;
  end; 

var
  frmBuscarPropietarios: TfrmBuscarPropietarios;

implementation
{$R *.lfm}
uses
  frm_propietariosae
  ;


const
  IDX_BUS_APELLIDO = 0;
  IDX_BUS_DOCUMENTO = 1;
  IDX_BUS_CUIT = 2;
  TX_BUS_APELLIDO = 'Apellido del Propietario';
  TX_BUS_DOCUMENTO = 'Documento del Propietario';
  TX_BUS_CUIT = 'CUIT del Propietario';

{ TfrmBuscarPropietarios }

procedure TfrmBuscarPropietarios.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TfrmBuscarPropietarios.edBuscarKeyPress(Sender: TObject; var Key: char
  );
begin
  if key = #13 then
    Buscar;
end;

procedure TfrmBuscarPropietarios.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmBuscarPropietarios.btnAceptarClick(Sender: TObject);
begin
  if getIdPropietarioActual <> GUIDNULO then
     ModalResult:= mrOK
  else
     ShowMessage('No hay datos para devolver');
end;


procedure TfrmBuscarPropietarios.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

function TfrmBuscarPropietarios.getIdPropietarioActual: string;
begin
  result:= DM_Propietarios.idBusquedaActual;
end;

procedure TfrmBuscarPropietarios.Inicializar;
begin
  DM_Propietarios.InicializarBusquedas;
  edBuscar.Clear;
  cbCriterio.Items.Insert(IDX_BUS_APELLIDO,TX_BUS_APELLIDO);
  cbCriterio.Items.Insert(IDX_BUS_DOCUMENTO,TX_BUS_DOCUMENTO);
  cbCriterio.Items.Insert(IDX_BUS_CUIT,TX_BUS_CUIT);
  cbCriterio.ItemIndex:= IDX_BUS_APELLIDO;
end;

procedure TfrmBuscarPropietarios.Buscar;
var
  resultado: boolean;
begin
  resultado:= False;
  case cbCriterio.ItemIndex of
   IDX_BUS_APELLIDO: resultado:= DM_Propietarios.BuscarPropietarioApellido(TRIM(edBuscar.Text));
   IDX_BUS_DOCUMENTO: resultado:= DM_Propietarios.BuscarPropietarioDocumento(TRIM(edBuscar.Text));
   IDX_BUS_CUIT: resultado:= DM_Propietarios.BuscarPropietarioCUIT(TRIM(edBuscar.Text));
  end;
  if resultado = False then
  begin
    btnAceptar.Enabled:= False;
    ShowMessage('No se encontraron resultados');
  end
  else
    btnAceptar.Enabled:= True;
end;

(*******************************************************************************
*** PANTALLA DE PROPIETARIOS
********************************************************************************)
procedure TfrmBuscarPropietarios.pantallaPropietarios(refPropietario: GUID_ID);
var
  pant: TfrmPropietarios;
begin
  pant:= TfrmPropietarios.Create(self);
  try
    pant.idPropietario:= refPropietario;
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

procedure TfrmBuscarPropietarios.btnNuevoClick(Sender: TObject);
begin
  pantallaPropietarios(GUIDNULO);
end;

procedure TfrmBuscarPropietarios.BitBtn2Click(Sender: TObject);
begin
  pantallaPropietarios(idPropietario);
end;

procedure TfrmBuscarPropietarios.BitBtn3Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el propietario seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Propietarios.BorrarPropietario(idPropietario);
end;


end.

