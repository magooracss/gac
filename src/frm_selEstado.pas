unit frm_selEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, DB;

type
  TfrmSelEstadoAfiliado = class(TForm)
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ds_estadoAfiliado: TDataSource;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    function getEstadoSeleccionado: integer;
    function getEstadoSeleccionadoTexto: string;
    { Private declarations }
  public
    property refEstadoSeleccionado: integer read getEstadoSeleccionado;
    property EstadoSeleccionado: string read getEstadoSeleccionadoTexto;
  end;

var
  frmSelEstadoAfiliado: TfrmSelEstadoAfiliado;

implementation
{$R *.dfm}
uses
  Cred_DM_AfiliadoAM
  ;

procedure TfrmSelEstadoAfiliado.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmSelEstadoAfiliado.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

function TfrmSelEstadoAfiliado.getEstadoSeleccionado: integer;
begin
  Result:= DM_AfiliadoAM.qtugEstadosIDESTADOAFILIADO.AsInteger; 
end;

function TfrmSelEstadoAfiliado.getEstadoSeleccionadoTexto: string;
begin
  Result:= DM_AfiliadoAM.qtugEstadosESTADO.AsString;
end;

end.
