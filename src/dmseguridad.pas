unit dmseguridad;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds;

type

  { TDM_Seguridad }

  TDM_Seguridad = class(TDataModule)
    tbUsuarios: TRxMemoryData;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_Seguridad: TDM_Seguridad;

implementation

{$R *.lfm}

end.

