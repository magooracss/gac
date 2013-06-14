unit dmcaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset
  ,StdCtrls
  ,dmgeneral;


const
  ALCANCE_TODOS = 0;
  ALCANCE_INQUILINOS = 1;
  ALCANCE_PROPIETARIOS = 2;


type

  TmovimientoCaja = (ingreso, egreso, otro);

  { TDM_Caja }

  TDM_Caja = class(TDataModule)
    qTugTiposMovCaja: TZQuery;
  private
    { private declarations }
  public
    procedure CargarCbTipos (var elCombo: TComboBox
                            ; elCampoVisible
                            , elCampoIndice: string
                            ; afecta: Integer);
  end; 

var
  DM_Caja: TDM_Caja;

implementation

{$R *.lfm}

{ TDM_Caja }

procedure TDM_Caja.CargarCbTipos(var elCombo: TComboBox; elCampoVisible
          , elCampoIndice: string; afecta: Integer);
begin
  elCombo.Clear;
  with qTugTiposMovCaja do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add ('SELECT * FROM tugCajaTipoMovimientos WHERE (bVisible = 1)');
    if afecta <> ALCANCE_TODOS then
      SQL.Add(' AND ((refAfecta = 0) OR (refAfecta = '+ IntToStr(afecta) +' ))' );
  end;
  DM_General.CargarComboBox(elCombo, elCampoVisible, elCampoIndice, qTugTiposMovCaja);
end;

end.

