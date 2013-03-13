unit frm_buscarcontratos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, Buttons;

type

  { TfrmBuscarContratos }

  TfrmBuscarContratos = class(TForm)
    btnBuscar: TBitBtn;
    btnSalir: TBitBtn;
    cbCriterio: TComboBox;
    DS_Resultados: TDatasource;
    DBGrid1: TDBGrid;
    edBusqueda: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure edBusquedaKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    procedure CargarCriterio;
    procedure Buscar;
    function getIdContratoSeleccionado: string;
  public
    property idContratoSeleccionado: string read getIdContratoSeleccionado;
  end; 

var
  frmBuscarContratos: TfrmBuscarContratos;

implementation
{$R *.lfm}
uses
  dmcontratos
  ;

const
  TX_BUS_PROPIEDAD = 'Buscar por Propiedad';
  TX_BUS_CARPETA = 'Buscar por carpeta del contrato';
  TX_BUS_CODIGO = 'Buscar por código del contrato';
  TX_BUS_FVIGENCIA = 'Buscar por fecha de vigencia del contrato';
  TX_BUS_FFIN = 'Buscar por fecha de finalización del contrato';
  TX_BUS_INQ = 'Buscar por Inquilino';
  TX_BUS_PROP = 'Buscar por Propietario';


{ TfrmBuscarContratos }

procedure TfrmBuscarContratos.FormShow(Sender: TObject);
begin
  CargarCriterio;
  edBusqueda.SetFocus;
  edBusqueda.Clear;
end;

procedure TfrmBuscarContratos.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBuscarContratos.edBusquedaKeyPress(Sender: TObject; var Key: char
  );
begin
  if (Key = #13) then
   Buscar;
end;

procedure TfrmBuscarContratos.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBuscarContratos.CargarCriterio;
begin
  cbCriterio.items.Clear;
  cbCriterio.Items.Insert(IDX_BUS_PROPIEDAD, TX_BUS_PROPIEDAD);
  cbCriterio.Items.Insert(IDX_BUS_CARPETA, TX_BUS_CARPETA);
  cbCriterio.Items.Insert(IDX_BUS_CODIGO, TX_BUS_CODIGO);
  cbCriterio.Items.Insert(IDX_BUS_FFIN, TX_BUS_FFIN);
  cbCriterio.Items.Insert(IDX_BUS_INQ, TX_BUS_INQ);
  cbCriterio.Items.Insert(IDX_BUS_PROP, TX_BUS_PROP);

  //  cbCriterio.Items.Insert(IDX_BUS_FVIGENCIA, TX_BUS_FVIGENCIA);

  cbCriterio.ItemIndex:= IDX_BUS_PROPIEDAD;

end;

procedure TfrmBuscarContratos.Buscar;
begin
  CASE cbCriterio.ItemIndex of
       IDX_BUS_PROPIEDAD: DM_Contratos.BuscarPorPropiedad (TRIM(edBusqueda.Text));
       IDX_BUS_CARPETA: DM_Contratos.BuscarPorCarpeta(StrToIntDef(edBusqueda.Text, 0));
       IDX_BUS_CODIGO: DM_Contratos.BuscarPorCodigo (TRIM(edBusqueda.Text));
       IDX_BUS_FVIGENCIA: DM_Contratos.BuscarPorFVigencia (StrToDateDef(edBusqueda.Text, Now));
       IDX_BUS_FFIN: DM_Contratos.BuscarPorFFin(StrToDateDef(edBusqueda.Text, Now));
       IDX_BUS_INQ: DM_Contratos.BuscarPorInquilino(TRIM(edBusqueda.Text));
       IDX_BUS_PROP: DM_Contratos.BuscarPorPropietario(TRIM(edBusqueda.Text));

  end;
end;

function TfrmBuscarContratos.getIdContratoSeleccionado: string;
begin
  result:= DM_Contratos.idContratoBusqueda;
end;

end.

