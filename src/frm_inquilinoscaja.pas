unit frm_inquilinoscaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, dbdateedit, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, DbCtrls, EditBtn, Buttons
  ,dmgeneral, db
  ;

type

  { TfrmCajaInquilino }

  TfrmCajaInquilino = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnAgregar: TBitBtn;
    btnQuitar: TBitBtn;
    btnBuscar: TBitBtn;
    DBGrid1: TDBGrid;
    ds_inquilino: TDatasource;
    edFin: TDateEdit;
    edIni: TDateEdit;
    gbIntervalo: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    rbDeudas: TRadioButton;
    rbPagos: TRadioButton;
    rbInquilino: TRadioButton;
    rbPropiedad: TRadioButton;
    stInquilino: TStaticText;
    stPropiedad: TStaticText;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnQuitarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _refInquilino: GUID_ID;
    _refPropiedad: GUID_ID;
    procedure inicializar;
    procedure BuscarInquilino;
    function BuscarPropiedad (texto: string): GUID_ID;
  public
    { public declarations }
  end;

var
  frmCajaInquilino: TfrmCajaInquilino;

implementation
{$R *.lfm}
{ TfrmCajaInquilino }
uses
  dateutils
  , frm_inquilinoslistado
  , dminquilinos
  , frm_buscarpropiedades
  , dmpropiedades
  ;


procedure TfrmCajaInquilino.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCajaInquilino.BitBtn3Click(Sender: TObject);
begin
  if rbPagos.Checked then
  begin
    ShowMessage('No puedo liquidar algo ya pagado');
  end;

end;

procedure TfrmCajaInquilino.btnAgregarClick(Sender: TObject);
begin
  if rbPagos.Checked then
  begin
    ShowMessage('No puedo modificar pagos ya asentados');
  end;
end;

procedure TfrmCajaInquilino.btnQuitarClick(Sender: TObject);
begin
  if rbPagos.Checked then
  begin
    ShowMessage('No puedo modificar pagos ya asentados');
  end;
end;

procedure TfrmCajaInquilino.FormShow(Sender: TObject);
begin
  inicializar;
end;

procedure TfrmCajaInquilino.inicializar;
var
  y,m,d: word;
begin
  DecodeDate(now,y,m,d);
  edIni.Date:= EncodeDate(y,m,1);
  edFin.Date:= EncodeDate(y,m,DaysInAMonth(y,m));
  rbInquilino.Checked:= true;
  rbDeudas.Checked:= true;
  _refPropiedad:= GUIDNULO;
  _refInquilino:= GUIDNULO;
end;


(*******************************************************************************
*** Busqueda de Inquilino/propiedades
********************************************************************************)
procedure TfrmCajaInquilino.BuscarInquilino;
var
  pant: TfrmInquilinosListado;
begin
  pant:= TfrmInquilinosListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      _refInquilino:= pant.idInquilinoSeleccionado;
      DM_Inquilinos.LevantarInquilino(_refInquilino);
      stInquilino.Caption:= TRIM(DM_Inquilinos.tbInquilinoscApellidos.asString)
                            + ', '
                            + TRIM(DM_Inquilinos.tbInquilinoscNombres.asString)
                            ;
    end
    else
    begin
      _refInquilino:= GUIDNULO;
      stInquilino.Caption:= '-----------------';
    end;
  finally
    pant.Free;
  end;
end;

function TfrmCajaInquilino.BuscarPropiedad(texto: string): GUID_ID;
var
  pant: TfrmBuscarPropiedades;
begin
  pant:= TfrmBuscarPropiedades.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      _refPropiedad:= pant.idPropiedadSeleccionada;
      DM_Propiedades.LevantarPropiedad(_refPropiedad);
      stPropiedad.Caption:= DM_Propiedades.Propiedad;
    end
    else
    begin
      _refPropiedad:= GUIDNULO;
      stPropiedad.Caption:= '-----------------';
    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmCajaInquilino.btnBuscarClick(Sender: TObject);
begin
  if rbInquilino.Checked then
    BuscarInquilino
  else
    _refPropiedaD:= BuscarPropiedad (EmptyStr);

end;




end.

