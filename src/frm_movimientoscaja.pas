unit frm_movimientoscaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, EditBtn;

type

  { TfrmCajaMovimientos }

  TfrmCajaMovimientos = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    DBGrid1: TDBGrid;
    edFechaFin: TDateEdit;
    edFechaIni: TDateEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Inicializar;
  public
    { public declarations }
  end; 

var
  frmCajaMovimientos: TfrmCajaMovimientos;

implementation
{$R *.lfm}
uses
   frm_movimientocajaae
  ,dmcaja
  ;

{ TfrmCajaMovimientos }

procedure TfrmCajaMovimientos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmCajaMovimientos.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCajaMovimientos.BitBtn4Click(Sender: TObject);
var
  pant: TfrmMovimientoCajaAE;
begin
  pant:= TfrmMovimientoCajaAE.Create(self);
  try
    pant.TipoMovimiento:= otro;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmCajaMovimientos.Inicializar;
begin
  edFechaIni.Date:= Now;
  edFechaFin.Date:= Now;
end;

end.

