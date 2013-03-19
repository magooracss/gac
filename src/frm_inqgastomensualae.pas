unit frm_inqgastomensualae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  Buttons, StdCtrls, dbdateedit, dmgeneral;

type

  { TfrmInqGastoMensualae }

  TfrmInqGastoMensualae = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    ds_LiqInq: TDatasource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idContrato: GUID_ID;
    _idLiq: GUID_ID;
    { private declarations }
  public
    property idLiquidacionMensual: GUID_ID read _idLiq write _idLiq;
    property idContrato: GUID_ID read _idContrato write _idContrato;
  end; 

var
  frmInqGastoMensualae: TfrmInqGastoMensualae;

implementation
{$R *.lfm}
uses
  dmliqinquilinos
  ;


{ TfrmInqGastoMensualae }

procedure TfrmInqGastoMensualae.FormCreate(Sender: TObject);
begin
  _idLiq:= GUIDNULO;
end;

procedure TfrmInqGastoMensualae.btnCancelarClick(Sender: TObject);
begin
  DM_LIQINQ.tbLiqInqMeses.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmInqGastoMensualae.btnAceptarClick(Sender: TObject);
begin
  DM_LIQINQ.tbLiqInqMeses.FieldByName('refContratoCobro').asString:= _idContrato;
  DM_LIQINQ.tbLiqInqMeses.Post;
  ModalResult:= mrOK;
end;

procedure TfrmInqGastoMensualae.FormShow(Sender: TObject);
begin
  if _idLiq = GUIDNULO then
  begin //Insert
    DM_LIQINQ.tbLiqInqMeses.Insert;
  end
  else //Edit
  begin
    DM_LIQINQ.tbLiqInqMeses.Edit;
  end;
end;

end.

