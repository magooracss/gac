unit frm_propiedadesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Buttons, DbCtrls, StdCtrls, PairSplitter, DBGrids, dbdateedit
  ,dmgeneral,dmpropiedades, types;

type

  { TfrmPropiedadAE }

  TfrmPropiedadAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnCuotas: TBitBtn;
    btnAgregarPropietario: TBitBtn;
    btnQuitarPropietario: TBitBtn;
    btnGrabar: TBitBtn;
    btnCancelar: TBitBtn;
    cbLocalidad: TComboBox;
    cbTipo: TComboBox;
    ckAjustarImagen: TCheckBox;
    DBEdit3: TDBEdit;
    DBEdit6: TDBEdit;
    ds_cuotas: TDatasource;
    DBGrid4: TDBGrid;
    DS_Propietarios: TDatasource;
    DS_PropietarioContacto: TDatasource;
    DBEdit5: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBMemo2: TDBMemo;
    DS_Propiedad: TDatasource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Imagen: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    PCPropiedad: TPageControl;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    StaticText1: TStaticText;
    tug: TSpeedButton;
    tabGeneral: TTabSheet;
    tabFotos: TTabSheet;
    Propietarios: TTabSheet;
    tug1: TSpeedButton;
    procedure btnAgregarPropietarioClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCuotasClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnQuitarPropietarioClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabGeneralShow(Sender: TObject);
    procedure tug1Click(Sender: TObject);
    procedure tugClick(Sender: TObject);
  private
    _idPropiedad: GUID_ID;
    procedure Inicializar;
    procedure GrabarDatos;

    procedure LevantarPropiedad;
  public
    property idPropiedad: GUID_ID write _idPropiedad;
  end; 

var
  frmPropiedadAE: TfrmPropiedadAE;

implementation
{$R *.lfm}
uses
    frm_ediciontugs
  , dmediciontugs
  , frm_buscarpropietarios
  , frm_propietariosae
  , frm_propiedadescuotas
    ;

{ TfrmPropiedadAE }

procedure TfrmPropiedadAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPropiedadAE.btnCuotasClick(Sender: TObject);
var
  pant: TfrmPropiedadesCuotas;
begin
  pant:= TfrmPropiedadesCuotas.Create(self);
  pant.operacion:= modificar;
  pant.idPropiedad:= _idPropiedad;
  try
    if pant.ShowModal = mrOK then
       DM_Propiedades.GrabarCuotas;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropiedadAE.btnGrabarClick(Sender: TObject);
begin
  GrabarDatos;
  ModalResult:= mrOK;
end;

procedure TfrmPropiedadAE.btnQuitarPropietarioClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', '¿Quito al propietario seleccionado de esta propiedad?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Propiedades.QuitarPropietario(DM_Propiedades.idPropietarioActual);
    DM_Propiedades.tbPropietarios.Delete;
  end;
end;

procedure TfrmPropiedadAE.DBGrid2DblClick(Sender: TObject);
var
  pant: TfrmPropietarios;
begin
  pant:= TfrmPropietarios.Create(self);
  pant.idPropietario:= DM_Propiedades.idPropietarioActual;
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropiedadAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idPropiedad = GUIDNULO then
    DM_Propiedades.Nueva
  else
    LevantarPropiedad;

end;



procedure TfrmPropiedadAE.tabGeneralShow(Sender: TObject);
begin
  DBEdit1.SetFocus;
end;

procedure TfrmPropiedadAE.tug1Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGPROPIEDADESTIPOS';
      titulo:= 'Tipos de Propiedad';
      AgregarCampo('PropiedadTipo','Tipo');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipo, 'PropiedadTipo', 'idPropiedadTipo', DM_Propiedades.tugPropiedadesTipos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPropiedadAE.tugClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGLOCALIDADES';
      titulo:= 'Localidades';
      AgregarCampo('Localidad','Localidad');
      AgregarCampo('CodigoPostal','Codigo Postal');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbLocalidad, 'Localidad', 'idLocalidad', DM_Propiedades.tugLocalidades);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPropiedadAE.Inicializar;
begin
  PCPropiedad.ActivePage:= tabGeneral;
  DM_General.CargarComboBox(cbLocalidad, 'Localidad', 'idLocalidad', DM_Propiedades.tugLocalidades);
  DM_General.CargarComboBox(cbTipo, 'PropiedadTipo', 'idPropiedadTipo', DM_Propiedades.tugPropiedadesTipos);

end;

procedure TfrmPropiedadAE.GrabarDatos;
begin
  DM_Propiedades.AjustarCombos(DM_General.obtenerIDIntComboBox(cbLocalidad),DM_General.obtenerIDIntComboBox(cbTipo) );
  DM_Propiedades.Grabar;
end;

procedure TfrmPropiedadAE.LevantarPropiedad;
begin
  DM_Propiedades.LevantarPropiedad(_idPropiedad);
  cbLocalidad.ItemIndex:= DM_General.obtenerIdxCombo(cbLocalidad, DM_Propiedades.idLocalidad);
  cbTipo.ItemIndex:= DM_General.obtenerIdxCombo(cbTipo, DM_Propiedades.idTipo);
end;


procedure TfrmPropiedadAE.btnAgregarPropietarioClick(Sender: TObject);
var
  pant: TfrmBuscarPropietarios;
begin
  pant:= TfrmBuscarPropietarios.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Propiedades.agregarPropietario (pant.idPropietario);
      DM_Propiedades.LevantarPropietarios(DM_Propiedades.idPropiedad);
    end;
  finally
    pant.Free;
  end;
end;


end.

