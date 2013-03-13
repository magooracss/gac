unit frm_buscarpropiedades;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, StdCtrls, ComCtrls, Buttons, EditBtn
  ,dmgeneral;

type

  { TfrmBuscarPropiedades }

  TfrmBuscarPropiedades = class(TForm)
    btnBuscar: TBitBtn;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbCriterios: TComboBox;
    cbTipo: TComboBox;
    cbLocalidad: TComboBox;
    ds_resultados: TDatasource;
    edFecha: TDateEdit;
    DBGrid1: TDBGrid;
    edCadena: TEdit;
    Label1: TLabel;
    PCDatos: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    tabCadena: TTabSheet;
    tabFecha: TTabSheet;
    tabLocalidad: TTabSheet;
    tabTipo: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cbCriteriosChange(Sender: TObject);
    procedure edCadenaKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
  private
    procedure CargarCriteriosBusqueda;
    procedure CargarCombosBD;
    function getIdPropiedadActual: GUID_ID;

    procedure Inicializar;

    procedure Buscar;
  public
    property idPropiedadSeleccionada: GUID_ID read getIdPropiedadActual;

  end;

var
  frmBuscarPropiedades: TfrmBuscarPropiedades;

implementation
{$R *.lfm}
uses
  dmpropiedades
  ;

const
  TX_BUS_CALLE = 'Buscar propiedad por calle';
  TX_BUS_FALTA = 'Buscar propiedad por Fecha de Alta';
  TX_BUS_ALQUILER = 'Buscar propiedad por monto Alquiler igual o mayor';
  TX_BUS_TIPO = 'Buscar propiedad por Tipo de inmueble';
  TX_BUS_LOCALIDAD = 'Buscar propiedad por Localidad';

{ TfrmBuscarPropiedades }

procedure TfrmBuscarPropiedades.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmBuscarPropiedades.cbCriteriosChange(Sender: TObject);
begin
  case cbCriterios.ItemIndex of
    IDX_BUS_CALLE: PCDatos.ActivePage:= tabCadena;
    IDX_BUS_FALTA: PCDatos.ActivePage:= tabFecha;
    IDX_BUS_ALQUILER: PCDatos.ActivePage:= tabCadena;
    IDX_BUS_TIPO: PCDatos.ActivePage:= tabTipo;
    IDX_BUS_LOCALIDAD: PCDatos.ActivePage:= tabLocalidad;
  end;
end;

procedure TfrmBuscarPropiedades.edCadenaKeyPress(Sender: TObject; var Key: char
  );
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmBuscarPropiedades.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBuscarPropiedades.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBuscarPropiedades.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBuscarPropiedades.CargarCriteriosBusqueda;
begin
  cbCriterios.Items.Clear;
  cbCriterios.Items.Insert(IDX_BUS_CALLE, TX_BUS_CALLE);
  cbCriterios.Items.Insert(IDX_BUS_FALTA, TX_BUS_FALTA);
  cbCriterios.Items.Insert(IDX_BUS_ALQUILER, TX_BUS_ALQUILER);
  cbCriterios.Items.Insert(IDX_BUS_TIPO, TX_BUS_TIPO);
  cbCriterios.Items.Insert(IDX_BUS_LOCALIDAD, TX_BUS_LOCALIDAD);
  cbCriterios.ItemIndex:= IDX_BUS_CALLE;
end;

procedure TfrmBuscarPropiedades.CargarCombosBD;
begin
  DM_General.CargarComboBox(cbTipo,'propiedadTipo', 'idPropiedadTipo', DM_Propiedades.tugPropiedadesTipos);
  DM_General.CargarComboBox(cbLocalidad,'Localidad', 'idLocalidad', DM_Propiedades.tugLocalidades);
end;

function TfrmBuscarPropiedades.getIdPropiedadActual: GUID_ID;
begin
  result:= DM_Propiedades.idPropiedadBusqueda;
end;

procedure TfrmBuscarPropiedades.Inicializar;
begin
  CargarCriteriosBusqueda;
  CargarCombosBD;
  PcDatos.ActivePage:= tabCadena;
  edCadena.Clear;
  edCadena.SetFocus;
  edFecha.Date:= now;
  DM_General.ReiniciarTabla(DM_Propiedades.tbResultados);
end;

procedure TfrmBuscarPropiedades.Buscar;
begin
  case cbCriterios.ItemIndex of
    IDX_BUS_CALLE: DM_Propiedades.BuscarPorCalle (edCadena.Text);
    IDX_BUS_FALTA: DM_Propiedades.BuscarPorFechaAlta (edFecha.Date);
    IDX_BUS_ALQUILER: DM_Propiedades.BuscarPorMontoAlquiler (StrToFloatDef(edCadena.Text, 0));
    IDX_BUS_TIPO: DM_Propiedades.BuscarPorTipo (DM_General.obtenerIDIntComboBox(cbTipo));
    IDX_BUS_LOCALIDAD: DM_Propiedades.BuscarPorLocalidad (DM_General.obtenerIDIntComboBox(cbLocalidad));
  end;

end;

end.

