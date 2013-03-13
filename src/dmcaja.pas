unit dmcaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil; 

type

  TmovimientoCaja = (ingreso, egreso, otro);

  TDM_Caja = class(TDataModule)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DM_Caja: TDM_Caja;

implementation

{$R *.lfm}

end.

