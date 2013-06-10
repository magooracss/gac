unit frm_propietariosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons, DBGrids, dbdateedit
  ,dmgeneral, dmpersonas;

type

  { TfrmPropietarios }

  TfrmPropietarios = class(TForm)
    btnCancelar: TBitBtn;
    btnContactoNuevo: TBitBtn;
    btnSalir: TBitBtn;
    btnContactoEditar: TBitBtn;
    btnContactoEliminar: TBitBtn;
    btnDomNuevo: TBitBtn;
    btnDomEditar: TBitBtn;
    btnDomBorrar: TBitBtn;
    btnBancoNuevo: TBitBtn;
    btnBancoModificar: TBitBtn;
    btnBancoBorrar: TBitBtn;
    cbTipoDoc: TComboBox;
    DBDateEdit1: TDBDateEdit;
    ds_propietarios: TDatasource;
    ds_contactos: TDatasource;
    ds_domicilios: TDatasource;
    ds_bancos: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    btnTugDocumento: TSpeedButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBancoBorrarClick(Sender: TObject);
    procedure btnBancoModificarClick(Sender: TObject);
    procedure btnBancoNuevoClick(Sender: TObject);
    procedure btnContactoEditarClick(Sender: TObject);
    procedure btnContactoEliminarClick(Sender: TObject);
    procedure btnContactoNuevoClick(Sender: TObject);
    procedure btnDomBorrarClick(Sender: TObject);
    procedure btnDomEditarClick(Sender: TObject);
    procedure btnDomNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnTugDocumentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idPropietario: GUID_ID;
    function getApellido: string;
    procedure Inicializar;
  public
    property idPropietario: GUID_ID read _idPropietario write _idPropietario;
    property Apellido: string read getApellido;
  end; 

var
  frmPropietarios: TfrmPropietarios;

implementation
{$R *.lfm}
uses
  dmpropietarios
  ,dmediciontugs
  ,frm_ediciontugs
  ,frm_contactosAE
  ,frm_domicilioae
  ,frm_propietarioscuentas
  ;

{ TfrmPropietarios }

procedure TfrmPropietarios.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idPropietario = GUIDNULO then
     DM_Propietarios.Nuevo
  else
     DM_Propietarios.LevantarPropietario (_idPropietario);
end;

procedure TfrmPropietarios.btnSalirClick(Sender: TObject);
begin
  DM_Propietarios.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmPropietarios.btnContactoNuevoClick(Sender: TObject);
var
  pant: TfrmContactosAE;
begin
  pant:= TfrmContactosAE.Create (self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.AltaContacto (pant.idFormaContacto, pant.Dato);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnDomBorrarClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el domicilio seleccionado?'+#13+ 'Esta operación no se puede deshacer', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   DM_Propietarios.EliminarDomicilio;
end;

procedure TfrmPropietarios.btnDomEditarClick(Sender: TObject);
var
  pant: Tfrm_DomiciliosAE;
begin
  pant:= Tfrm_DomiciliosAE.Create(self);
  try
    pant.operacion:= modificar;
    pant.idLocalidad:= ds_domicilios.DataSet.FieldByName('refLocalidad').AsInteger;
    pant.Direccion:= ds_domicilios.DataSet.FieldByName('Direccion').asString;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.EditarDomicilio (pant.Direccion, pant.idLocalidad);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnDomNuevoClick(Sender: TObject);
var
  pant: Tfrm_DomiciliosAE;
begin
  pant:= Tfrm_DomiciliosAE.Create(self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.altaDomicilio (pant.Direccion, pant.idLocalidad);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnContactoEditarClick(Sender: TObject);
var
  pant: TfrmContactosAE;
begin
  pant:= TfrmContactosAE.Create (self);
  try
    pant.operacion:= modificar;
    pant.idFormaContacto:= DM_Propietarios.tbContactos.FieldByName('refTipoContacto').asInteger;
    pant.Dato:= DM_Propietarios.tbContactos.FieldByName('Contacto').asString;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.EditarContacto (pant.idFormaContacto, pant.Dato);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnBancoNuevoClick(Sender: TObject);
var
  pant: TfrmPropietariosCuentas;
begin
  pant:= TfrmPropietariosCuentas.Create (self);
  try
    pant.operacion:= nuevo;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.AgregarBanco(pant.idBanco, pant.cuenta, pant.cbu, pant.Notas);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnBancoModificarClick(Sender: TObject);
var
  pant: TfrmPropietariosCuentas;
begin
  pant:= TfrmPropietariosCuentas.Create (self);
  try
    pant.operacion:= modificar;
    pant.idBanco:= DM_Propietarios.tbBancos.FieldByName('refBanco').asInteger;
    pant.cuenta:= DM_Propietarios.tbBancos.FieldByName('Cuenta').AsString;
    pant.cbu:= DM_Propietarios.tbBancos.FieldByName('cbu').AsString;
    pant.Notas:= DM_Propietarios.tbBancos.FieldByName('txNotas').AsString;
    if pant.ShowModal = mrOK then
    begin
      DM_Propietarios.EditarBanco(pant.idBanco, pant.cuenta, pant.cbu, pant.Notas);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPropietarios.btnBancoBorrarClick(Sender: TObject);
begin
 if (MessageDlg ('ATENCION', 'Borro la cuenta seleccionada?'+#13+ 'Esta operación no se puede deshacer', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   DM_Propietarios.EliminarCuenta;
end;

procedure TfrmPropietarios.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TfrmPropietarios.btnContactoEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el contacto seleccionado?' +#13+ 'Esta operación no se puede deshacer', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   DM_Propietarios.EliminarContacto;
end;

procedure TfrmPropietarios.btnTugDocumentoClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGTIPOSDOCUMENTO';
      titulo:= 'Tipos de Documento';
      AgregarCampo('abTipoDocumento','Tipo documento');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoDoc, 'abTipoDocumento','idTipoDocumento', DM_Personas.tugTiposDoc);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPropietarios.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoDoc, 'abTipoDocumento','idTipoDocumento', DM_Personas.tugTiposDoc);
end;

function TfrmPropietarios.getApellido: string;
begin
  Result:= DM_Propietarios.Apellido;
end;

end.

