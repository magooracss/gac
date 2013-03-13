unit frm_personaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, ExtCtrls, DBGrids, Buttons, dmgeneral;

type

  { TfrmPersonaAE }

  TfrmPersonaAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    btnGrabarSalir: TBitBtn;
    ComboBox1: TComboBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
  private
    _refPersona: GUID_ID;
    { private declarations }
  public
    property refPersona: GUID_ID write _refPersona;
  end; 

var
  frmPersonaAE: TfrmPersonaAE;

implementation

{$R *.lfm}

end.

