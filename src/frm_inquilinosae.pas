unit frm_inquilinosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons
  , dmgeneral
  ;

type

  { TfrmInquilinosAE }

  TfrmInquilinosAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugDocumento: TSpeedButton;
    cbTipoDoc: TComboBox;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DS_Inquilinos: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnTugDocumentoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idInquilino: GUID_ID;
    function getApellido: string;
    procedure Inicializar;
  public
    property idInquilino: GUID_ID write _idInquilino;
    property Apellido : string read getApellido;
  end; 

var
  frmInquilinosAE: TfrmInquilinosAE;

implementation
{$R *.lfm}
  uses
   dmediciontugs
   ,frm_ediciontugs
   ,dmpersonas
   ,dminquilinos
   ;


{ TfrmInquilinosAE }

procedure TfrmInquilinosAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmInquilinosAE.btnAceptarClick(Sender: TObject);
begin
  DM_Inquilinos.refTipoDocumento:= DM_General.obtenerIDIntComboBox(cbTipoDoc);
  DM_Inquilinos.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmInquilinosAE.btnTugDocumentoClick(Sender: TObject);
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

procedure TfrmInquilinosAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idInquilino = GUIDNULO then
  begin
     DM_Inquilinos.Nuevo;
  end
  else
  begin
    DM_Inquilinos.LevantarInquilino (_idInquilino);
    cbTipoDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoDoc, DM_Inquilinos.tbInquilinos.FieldByName('refTipoDocumento').asInteger);
  end;

end;

procedure TfrmInquilinosAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoDoc, 'abTipoDocumento','idTipoDocumento', DM_Personas.tugTiposDoc);
  cbTipoDoc.ItemIndex:= 0;
end;

function TfrmInquilinosAE.getApellido: string;
begin
  Result:= DM_Inquilinos.Apellido;
end;

end.

