unit frm_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ComCtrls, ActnList, DBGrids
  ,dmgeneral;

type

  { TfrmAlquileres }

  TfrmAlquileres = class(TForm)
    DBGrid1: TDBGrid;
    ds_ContratosActivos: TDatasource;
    dueEditar: TAction;
    dueEliminar: TAction;
    dueAgregar: TAction;
    cajaMovimientos: TAction;
    cajaEgreso: TAction;
    cajaIngreso: TAction;
    contDetalles: TAction;
    contBorrar: TAction;
    contModificar: TAction;
    contNuevo: TAction;
    inqDetalles: TAction;
    inqModificar: TAction;
    inqBorrar: TAction;
    inqNuevo: TAction;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem30: TMenuItem;
    propDetalles: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    propBorrar: TAction;
    propModicar: TAction;
    propAgregar: TAction;
    prgSalir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure cajaEgresoExecute(Sender: TObject);
    procedure cajaIngresoExecute(Sender: TObject);
    procedure cajaMovimientosExecute(Sender: TObject);
    procedure contBorrarExecute(Sender: TObject);
    procedure contDetallesExecute(Sender: TObject);
    procedure contModificarExecute(Sender: TObject);
    procedure contNuevoExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure dueAgregarExecute(Sender: TObject);
    procedure dueEditarExecute(Sender: TObject);
    procedure dueEliminarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure inqDetallesExecute(Sender: TObject);
    procedure inqModificarExecute(Sender: TObject);
    procedure inqNuevoExecute(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure propAgregarExecute(Sender: TObject);
    procedure propBorrarExecute(Sender: TObject);
    procedure propDetallesExecute(Sender: TObject);
    procedure propModicarExecute(Sender: TObject);
  private
    procedure pantallaPersonas (refPersona: GUID_ID);
    procedure pantallaPropietarios (refPropietario: GUID_ID);
    procedure pantallaPropiedades (refPropiedad: GUID_ID);
    procedure pantallaInquilinos (refInquilino: GUID_ID);
    procedure pantallaContratos (refContrato: GUID_ID);
    procedure Inicializar;

  public
    { public declarations }
  end; 

var
  frmAlquileres: TfrmAlquileres;

implementation
{$R *.lfm}
uses
  frm_movimientocajaae
 ,frm_movimientoscaja
 ,frm_personaae
 ,dmcaja
 ,frm_propietariosae
 ,versioninfo
 ,frm_buscarpropietarios
 ,dmpropietarios
 ,frm_propiedadesae
 ,frm_buscarpropiedades
 ,dmpropiedades
 ,frm_inquilinosae
 ,frm_inquilinoslistado
 ,frm_contratoae
 ,frm_buscarcontratos
 ,dmcontratos
 ;


{ TfrmAlquileres }

procedure TfrmAlquileres.prgSalirExecute(Sender: TObject);
begin
  Application.Terminate;
end;



procedure TfrmAlquileres.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmAlquileres.Inicializar;
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  st.Panels[0].Text:= 'v:' + NroVersion;
  st.Panels[1].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';
  DM_Contratos.LevantarContratosMayorFechaFin(now);
end;


(*******************************************************************************
*** PERSONAS
*******************************************************************************)
procedure TfrmAlquileres.pantallaPersonas(refPersona: GUID_ID);
var
  pantalla: TfrmPersonaAE;
begin
  pantalla:= TfrmPersonaAE.Create(self);
  try
    pantalla.refPersona:= refPersona;
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;




(*******************************************************************************
*** CAJA
*******************************************************************************)

procedure TfrmAlquileres.cajaMovimientosExecute(Sender: TObject);
var
  pantalla: TfrmCajaMovimientos;
begin
  pantalla:= TfrmCajaMovimientos.Create (self);
  try
    pantalla.ShowModal;
  finally
    pantalla.Free;
  end;
end;


procedure TfrmAlquileres.cajaIngresoExecute(Sender: TObject);
var
  pant: TfrmMovimientoCajaAE;
begin
  pant:= TfrmMovimientoCajaAE.Create(self);
  try
    pant.TipoMovimiento:= ingreso;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmAlquileres.cajaEgresoExecute(Sender: TObject);
var
  pant: TfrmMovimientoCajaAE;
begin
  pant:= TfrmMovimientoCajaAE.Create(self);
  try
    pant.TipoMovimiento:= egreso;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** Datos de Propietarios y Dueños
*******************************************************************************)
procedure TfrmAlquileres.pantallaPropietarios(refPropietario: GUID_ID);
var
  pant: TfrmPropietarios;
begin
  pant:= TfrmPropietarios.Create(self);
  try
    pant.idPropietario:= refPropietario;
    if pant.ShowModal = mrOK then;
    begin

    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmAlquileres.dueAgregarExecute(Sender: TObject);
begin
  pantallaPropietarios(GUIDNULO);
end;

procedure TfrmAlquileres.dueEditarExecute(Sender: TObject);
var
  pant: TfrmBuscarPropietarios;
begin
  pant:= TfrmBuscarPropietarios.Create (self);
  try
    if pant.ShowModal = mrOK then
      pantallaPropietarios(pant.idPropietario);
  finally
    pant.Free;
  end;
end;

procedure TfrmAlquileres.dueEliminarExecute(Sender: TObject);
var
  pant: TfrmBuscarPropietarios;
begin
  pant:= TfrmBuscarPropietarios.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      if (MessageDlg ('ATENCION', 'Borro el propietario seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
        DM_Propietarios.BorrarPropietario(pant.idPropietario);
    end;
  finally
    pant.Free;
  end;
end;

(*******************************************************************************
*** Propiedades
*******************************************************************************)

procedure TfrmAlquileres.pantallaPropiedades(refPropiedad: GUID_ID);
var
  pant: TfrmPropiedadAE;
begin
  pant:= TfrmPropiedadAE.Create(self);
  try
    pant.idPropiedad:= refPropiedad;
    if pant.ShowModal = mrOK then;
    begin

    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmAlquileres.propAgregarExecute(Sender: TObject);
begin
  pantallaPropiedades(GUIDNULO);
end;

procedure TfrmAlquileres.propBorrarExecute(Sender: TObject);
var
  pantBus: TfrmBuscarPropiedades;
begin
  pantBus:= TfrmBuscarPropiedades.Create (Self);
  try
    if (pantBus.ShowModal = mrOK ) and (pantBus.idPropiedadSeleccionada <> GUIDNULO)then
      if (MessageDlg ('ATENCION', 'Borro la propiedad seleccionada?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
        DM_Propiedades.BorrarPropiedad(pantBus.idPropiedadSeleccionada);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmAlquileres.propDetallesExecute(Sender: TObject);
var
  pantBus: TfrmBuscarPropiedades;
begin
  pantBus:= TfrmBuscarPropiedades.Create (Self);
  try
    if (pantBus.ShowModal = mrOK ) and (pantBus.idPropiedadSeleccionada <> GUIDNULO)then
      pantallaPropiedades(pantBus.idPropiedadSeleccionada);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmAlquileres.propModicarExecute(Sender: TObject);
var
  pantBus: TfrmBuscarPropiedades;
begin
  pantBus:= TfrmBuscarPropiedades.Create (Self);
  try
    if (pantBus.ShowModal = mrOK ) and (pantBus.idPropiedadSeleccionada <> GUIDNULO)then
      pantallaPropiedades(pantBus.idPropiedadSeleccionada);
  finally
    pantBus.Free;
  end;
end;

(*******************************************************************************
*** Inquilinos
*******************************************************************************)
procedure TfrmAlquileres.pantallaInquilinos(refInquilino: GUID_ID);
var
  pant: TfrmInquilinosAE;
begin
  pant:= TfrmInquilinosAE.Create (Self);
  try
    pant.idInquilino:= refInquilino;
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmAlquileres.inqNuevoExecute(Sender: TObject);
begin
  pantallaInquilinos(GUIDNULO);
end;

procedure TfrmAlquileres.inqModificarExecute(Sender: TObject);
var
  pantBus: TfrmInquilinosListado;
begin
  pantBus:= TfrmInquilinosListado.Create (Self);
  try
    if (pantBus.ShowModal = mrOK ) and (pantBus.idInquilinoSeleccionado <> GUIDNULO)then
      pantallaInquilinos(pantBus.idInquilinoSeleccionado);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmAlquileres.inqDetallesExecute(Sender: TObject);
var
  pantBus: TfrmInquilinosListado;
begin
  pantBus:= TfrmInquilinosListado.Create (Self);
  try
    if (pantBus.ShowModal = mrOK ) and (pantBus.idInquilinoSeleccionado <> GUIDNULO)then
      pantallaInquilinos(pantBus.idInquilinoSeleccionado);
  finally
    pantBus.Free;
  end;
end;

(*******************************************************************************
*** Contratos
*******************************************************************************)
procedure TfrmAlquileres.pantallaContratos(refContrato: GUID_ID);
var
  pant: TfrmContratoAE;
begin
  pant:= TfrmContratoAE.Create(self);
  try
    pant.idContrato:= refContrato;
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
  DM_Contratos.LevantarContratosMayorFechaFin(now);
end;

procedure TfrmAlquileres.contNuevoExecute(Sender: TObject);
begin
  pantallaContratos(GUIDNULO);
end;

procedure TfrmAlquileres.DBGrid1DblClick(Sender: TObject);
begin
  with ds_ContratosActivos. DataSet do
  begin
    if ((Active) and (NOT FieldByName('idContrato').IsNull)) then
      pantallaContratos (ds_ContratosActivos.DataSet.FieldByName('idContrato').asString)
    else
      ShowMessage ('No hay nada para mostrar');
  end;
end;

procedure TfrmAlquileres.contModificarExecute(Sender: TObject);
var
  pant: TfrmBuscarContratos;
begin
  pant:= TfrmBuscarContratos.Create (self);
  try
   if pant.ShowModal = mrOK then
     pantallaContratos(pant.idContratoSeleccionado);
  finally
    pant.Free;
  end;
end;

procedure TfrmAlquileres.contDetallesExecute(Sender: TObject);
var
  pant: TfrmBuscarContratos;
begin
  pant:= TfrmBuscarContratos.Create (self);
  try
   if pant.ShowModal = mrOK then
    pantallaContratos(pant.idContratoSeleccionado);
  finally
    pant.Free;
  end;
end;

procedure TfrmAlquileres.contBorrarExecute(Sender: TObject);
var
  pant: TfrmBuscarContratos;
begin
  pant:= TfrmBuscarContratos.Create (self);
  try
   if pant.ShowModal = mrOK then
    begin
      if (MessageDlg ('ATENCION', 'Borro el Contrato seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
        DM_Contratos.BorrarContrato(pant.idContratoSeleccionado);
    end;
  finally
    pant.Free;
  end;

end;



end.
