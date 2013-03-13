unit frm_garantesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DbCtrls, StdCtrls, Buttons
  , dmgeneral
  ;

type

  { TfrmGarantesAE }

  TfrmGarantesAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugDocumento: TSpeedButton;
    cbTipoDoc: TComboBox;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    ds_Garantes: TDatasource;
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
    _idGarante: GUID_ID;
    function getApellido: string;
    procedure Inicializar;
  public
    property idGarante: GUID_ID write _idGarante;
    property Apellido : string read getApellido;
  end; 

var
  frmGarantesAE: TfrmGarantesAE;

implementation
{$R *.lfm}
  uses
   dmediciontugs
   ,frm_ediciontugs
   ,dmpersonas
   ,dmGarantes
   ;


{ TfrmGarantesAE }

procedure TfrmGarantesAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmGarantesAE.btnAceptarClick(Sender: TObject);
begin
  DM_Garantes.refTipoDocumento:= DM_General.obtenerIDIntComboBox(cbTipoDoc);
  DM_Garantes.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmGarantesAE.btnTugDocumentoClick(Sender: TObject);
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

procedure TfrmGarantesAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if _idGarante = GUIDNULO then
  begin
     DM_Garantes.Nuevo;
  end
  else
  begin
    DM_Garantes.LevantarGarante (_idGarante);
    cbTipoDoc.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoDoc, DM_Garantes.tbGarantes.FieldByName('refTipoDocumento').asInteger);
  end;

end;

procedure TfrmGarantesAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoDoc, 'abTipoDocumento','idTipoDocumento', DM_Personas.tugTiposDoc);
  cbTipoDoc.ItemIndex:= 0;
end;

function TfrmGarantesAE.getApellido: string;
begin
  Result:= DM_Garantes.Apellido;
end;

end.

