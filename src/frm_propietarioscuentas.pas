unit frm_propietarioscuentas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons
  ,dmgeneral
  ,dmpropietarios;

type

  { TfrmPropietariosCuentas }

  TfrmPropietariosCuentas = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    cbBancos: TComboBox;
    edCuenta: TEdit;
    edCBU: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    txNotas: TMemo;
    SpeedButton1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    _cbu: string;
    _cuenta: string;
    _idBanco: integer;
    _idOperacion: TOperacion;
    _notas: string;
  public
    property operacion: TOperacion write _idOperacion;
    property idBanco: integer read _idBanco write _idBanco;
    property cuenta: string read _cuenta write _cuenta;
    property cbu: string read _cbu write _cbu;
    property Notas: string read _notas write _notas;
  end; 

var
  frmPropietariosCuentas: TfrmPropietariosCuentas;

implementation
{$R *.lfm}
uses
  frm_ediciontugs
  , dmediciontugs;


{ TfrmPropietariosCuentas }

procedure TfrmPropietariosCuentas.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPropietariosCuentas.FormCreate(Sender: TObject);
begin
  _cbu:= EmptyStr;
  _cuenta:= EmptyStr;
  _idBanco:= 0;
  _notas:= EmptyStr;
end;

procedure TfrmPropietariosCuentas.FormShow(Sender: TObject);
begin
  edCuenta.Text:= _cuenta;
  edCBU.Text:= _cbu;
  txNotas.Lines.Clear;
  txNotas.Lines.Text:= _Notas;
  DM_General.CargarComboBox(cbBancos, 'Banco', 'idBanco', DM_Propietarios.qtugBancos);
  if _idOperacion = modificar then
  begin
    cbBancos.ItemIndex:= DM_General.obtenerIdxCombo(cbBancos, _idBanco);
  end;
end;

procedure TfrmPropietariosCuentas.SpeedButton1Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGBancos';
      titulo:= 'Bancos';
      AgregarCampo('Banco','Nombre del Banco');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbBancos, 'Banco', 'idBanco',DM_Propietarios.qtugBancos );
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPropietariosCuentas.BitBtn1Click(Sender: TObject);
begin
  _idBanco:= DM_General.obtenerIDIntComboBox(cbBancos);
  _cbu:= TRIM(edCBU.Text);
  _cuenta:= TRIM(edCuenta.Text);
  _notas:= txNotas.Lines.Text;
  ModalResult:= mrOK;
end;

end.

