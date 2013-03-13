unit frm_gastosmensualeslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DBGrids;

type

  { TfrmGastosMensualesListado }

  TfrmGastosMensualesListado = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    ds_Listagastos: TDatasource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _bInquilino: integer;
    _bPropietario: integer;
    _monto: double;

    function CargarDestinoDelGasto: boolean;
    function getidGastoSeleccionado: integer;

  public
    property idGastoSeleccionado: integer read getidGastoSeleccionado;
    property bPropietario: integer read _bPropietario write _bPropietario;
    property bInquilino: integer read _bInquilino write _bInquilino;
    property Monto: double read _monto write _monto;
  end; 

var
  frmGastosMensualesListado: TfrmGastosMensualesListado;

implementation
{$R *.lfm}
uses
  dmcontratos
  ,frm_gastomensualdestino
  ,frm_ediciontugs
  ,dmediciontugs
  ;

{ TfrmGastosMensualesListado }

procedure TfrmGastosMensualesListado.FormCreate(Sender: TObject);
begin
  _bInquilino:= 0;
  _bPropietario:= 0;
  _monto:= 0;
  DM_Contratos.levantarTUGGastos;
end;

function TfrmGastosMensualesListado.CargarDestinoDelGasto: boolean;
var
  pant: TfrmDestinoGasto;
begin
  pant:= TfrmDestinoGasto.Create (self);
  Result:= False;
  try
    pant.bInquilino:= bInquilino;
    pant.bPropietario:= bPropietario;
    pant.Monto:= Monto;
    if pant.ShowModal = mrOK then
    begin
      Monto:= pant.Monto;
      bInquilino:= pant.bInquilino;
      bPropietario:= pant.bPropietario;
      Result:= true;
    end;
  finally
    pant.Free;
  end;
end;

function TfrmGastosMensualesListado.getidGastoSeleccionado: integer;
begin
  Result:= DM_Contratos.idGastoSeleccionado;
end;


procedure TfrmGastosMensualesListado.BitBtn1Click(Sender: TObject);
begin
  if _monto = 0 then
   _monto:= DM_Contratos.MontoGastoSeleccionado;
  if CargarDestinoDelGasto then
  begin
    ModalResult:= mrOK;
  end;
end;

procedure TfrmGastosMensualesListado.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmGastosMensualesListado.BitBtn4Click(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGGASTOSMENSUALES';
      titulo:= 'Gastos Mensuales';
      AgregarCampo('GastoMensual','Descripción del gasto');
      AgregarCampo('nMonto','Monto del gasto (0 = elegirlo al liquidar)');

    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_Contratos.LevantarTugGastos;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

end.

