unit frm_contratoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DbCtrls, StdCtrls, DBGrids, Buttons, dbdateedit
  ,dmgeneral;

type

  { TfrmContratoAE }

  TfrmContratoAE = class(TForm)
    btnAgregarGarantes: TBitBtn;
    btnInqMensNew: TBitBtn;
    btnInqMensEdit: TBitBtn;
    btnInqMensDel: TBitBtn;
    btnQuitarGarantes: TBitBtn;
    btnRecargarCuotas: TBitBtn;
    BitBtn5: TBitBtn;
    btnAgregarCuenta: TBitBtn;
    btnAgregarInquilino: TBitBtn;
    btnQuitarInquilino: TBitBtn;
    btnGrabarSalir: TBitBtn;
    btnAgregarGasto: TBitBtn;
    btnQuitarGasto: TBitBtn;
    btnBuscar: TBitBtn;
    btnTugTipoContrato: TSpeedButton;
    cbTipoContrato: TComboBox;
    cbCuentaCorriente: TComboBox;
    ckAlquilerGarantizado: TDBCheckBox;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid8: TDBGrid;
    ds_inqMeses: TDatasource;
    DBEdit8: TDBEdit;
    DBGrid2: TDBGrid;
    DBGrid4: TDBGrid;
    DBGrid6: TDBGrid;
    DBGrid7: TDBGrid;
    DS_Contrato: TDatasource;
    ckBanco: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    ds_Inquilinos: TDatasource;
    ds_garantes: TDatasource;
    ds_ResumenLiquidacion: TDatasource;
    ds_Propietarios: TDatasource;
    ds_GastosMensuales: TDatasource;
    edHonorariosTotal: TEdit;
    edPropiedad: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    gbMensualidades: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    PCContratos: TPageControl;
    Panel1: TPanel;
    PcCuentaCorriente: TPageControl;
    tabDatos: TTabSheet;
    tabPartes: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    tabTodo: TTabSheet;
    procedure btnAgregarCuentaClick(Sender: TObject);
    procedure btnAgregarGarantesClick(Sender: TObject);
    procedure btnInqMensDelClick(Sender: TObject);
    procedure btnInqMensEditClick(Sender: TObject);
    procedure btnInqMensNewClick(Sender: TObject);
    procedure btnQuitarGarantesClick(Sender: TObject);
    procedure btnQuitarInquilinoClick(Sender: TObject);
    procedure btnAgregarGastoClick(Sender: TObject);
    procedure btnAgregarInquilinoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnGrabarSalirClick(Sender: TObject);
    procedure btnQuitarGastoClick(Sender: TObject);
    procedure btnRecargarCuotasClick(Sender: TObject);
    procedure btnTugTipoContratoClick(Sender: TObject);
    procedure ckBancoChange(Sender: TObject);
    procedure DBEdit9Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idContrato: GUID_ID;
    procedure Inicializar;
    procedure LevantarCuentasCorrientes;

    procedure PantInqMensualidad (idMensualidad: GUID_ID);


  public
    property idContrato: GUID_ID write _idContrato;
  end; 

var
  frmContratoAE: TfrmContratoAE;

implementation
{$R *.lfm}
uses
   dmcontratos
  ,frm_buscarpropiedades
  ,dmediciontugs
  ,frm_ediciontugs
  ,frm_gastosmensualeslistado
  ,frm_inquilinoslistado
  ,frm_cuentacontratoae
  ,dmliqinquilinos
  ,frm_inqgastomensualae
  ,frm_garanteslistado
  ,dmgarantes
  ;

{ TfrmContratoAE }

procedure TfrmContratoAE.btnTugTipoContratoClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TUGCONTRATOSTIPOS';
      titulo:= 'Tipos de Contrato';
      AgregarCampo('ContratoTipo','Nombre del tipo de contrato');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoContrato,'ContratoTipo','idContratoTipo', DM_Contratos.tugTiposContrato);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContratoAE.ckBancoChange(Sender: TObject);
begin
  if ckBanco.Checked then
   LevantarCuentasCorrientes;
end;

procedure TfrmContratoAE.DBEdit9Change(Sender: TObject);
var
  total: double;
begin
  if (NOT (DM_Contratos.tbContratos.FieldByName('nHonorarios').IsNull))
     and
     (NOT (DM_Contratos.tbContratos.FieldByName('nHonorCuotas').IsNull)) then
  begin
    total:= DM_Contratos.tbContratos.FieldByName('nHonorarios').AsFloat
            *
            DM_Contratos.tbContratos.FieldByName('nHonorCuotas').AsInteger
            ;
    edHonorariosTotal.Text:= FormatFloat ('$#########0.00',total);
  end
  else
    edHonorariosTotal.Text:= '$ 00.00';
end;

procedure TfrmContratoAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmContratoAE.Inicializar;
begin

  PCContratos.ActivePage:= tabDatos;
  cbCuentaCorriente.Items.Clear;
  DM_General.CargarComboBox(cbTipoContrato,'ContratoTipo','idContratoTipo', DM_Contratos.tugTiposContrato);

  if _idContrato = GUIDNULO then
  begin
    _idContrato:= DM_Contratos.Nuevo;
  end
  else
  begin
   DM_Contratos.LevantarContrato(_idContrato);
   edPropiedad.Text:= DM_Contratos.Propiedad;
   LevantarCuentasCorrientes;
   cbCuentaCorriente.ItemIndex:= DM_General.obtenerIdxComboTb(cbCuentaCorriente, DM_Contratos.idCuentaPropietario);
   cbTipoContrato.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoContrato, DM_Contratos.idTipoContrato);
  end;

end;

procedure TfrmContratoAE.LevantarCuentasCorrientes;
begin
  DM_General.CargarComboBoxTb(cbCuentaCorriente, 'BancoCuentaCBU', 'idPropietarioBanco', DM_Contratos.tbCuentasPropietarios);
  DM_LIQINQ.LevantarCuotasPorContrato(_idContrato);
end;

procedure TfrmContratoAE.btnGrabarSalirClick(Sender: TObject);
begin
  DM_Contratos.idTipoContrato:= DM_General.obtenerIDIntComboBox(cbTipoContrato);
  DM_Contratos.idCuentaPropietario:= DM_General.obtenerIDGuidComboBox(cbCuentaCorriente);
  DM_Contratos.Grabar;
  DM_LIQINQ.Grabar;
  ModalResult:= mrOK;
end;



(*******************************************************************************
*** PROPIEDADES
*******************************************************************************)

procedure TfrmContratoAE.btnBuscarClick(Sender: TObject);
var
  pant: TfrmBuscarPropiedades;
begin
  pant:= TfrmBuscarPropiedades.Create (self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_General.ReiniciarTabla(DM_LIQINQ.tbLiqInqMeses);
      DM_Contratos.cargarPropiedad (pant.idPropiedadSeleccionada);
      edPropiedad.Text:= DM_Contratos.Propiedad;
      DM_Contratos.LevantarCuentasPropietarios(pant.idPropiedadSeleccionada);
      LevantarCuentasCorrientes;
      if DM_LIQINQ.tbLiqInqMeses.RecordCount = 0 then
      begin
        DM_Contratos.GenerarCuotasPorPropiedad(pant.idPropiedadSeleccionada);
        with DM_Contratos.qLevantarCuotasContratoPorPropiedad do
        begin
          While Not EOF do
          begin
            DM_LIQINQ.GenerarCuotasPeriodo (FieldByName('CuotaInicio').asInteger
                           ,FieldByName('CuotaFin').asInteger
                           ,FieldByName('nMonto').asFloat
                           ,DM_Contratos.tbContratos.FieldByName('idContrato').asString
                           ,DM_Contratos.tbContratos.FieldByName('fInicio').AsDateTime
                           ,DM_Contratos.tbContratos.FieldByName('nDiaVencimiento').asInteger
                           );
             Next;
           end;
        end;
      end;
    end;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** GASTOS
*******************************************************************************)

procedure TfrmContratoAE.btnAgregarGastoClick(Sender: TObject);
var
  pant: TfrmGastosMensualesListado;
begin
  pant:= TfrmGastosMensualesListado.Create (Self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Contratos.altaGasto (pant.idGastoSeleccionado, pant.Monto, pant.bInquilino, pant.bPropietario);
    end;
  finally
    pant.Free;
  end;

end;


procedure TfrmContratoAE.btnQuitarGastoClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el gasto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Contratos.BajaGasto;
end;


(*******************************************************************************
*** INQUILINOS
*******************************************************************************)

procedure TfrmContratoAE.btnAgregarInquilinoClick(Sender: TObject);
var
  pant: TfrmInquilinosListado;
begin
  pant:= TfrmInquilinosListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Contratos.AltaInquilino (pant.idInquilinoSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmContratoAE.btnQuitarInquilinoClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el inquilino seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Contratos.BajaInquilino;

end;

procedure TfrmContratoAE.btnRecargarCuotasClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', '¿Recargo las cuotas de acuerdo a lo pactado en el contrato?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_LIQINQ.CargarCuotasPorContrato(_idContrato);
end;

procedure TfrmContratoAE.PantInqMensualidad(idMensualidad: GUID_ID);
var
  pant: TfrmInqGastoMensualae;
begin
  pant:=  TfrmInqGastoMensualae.Create(self);
  try
    pant.idContrato:= _idContrato;
    pant.idLiquidacionMensual:= idMensualidad;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmContratoAE.btnInqMensNewClick(Sender: TObject);
begin
  PantInqMensualidad(GUIDNULO);
end;

procedure TfrmContratoAE.btnInqMensEditClick(Sender: TObject);
var
  idMens: GUID_ID;
begin
  idMens:= DM_LIQINQ.tbLiqInqMeses.FieldByName('idLiqInqMes').asString;
//  if DM_LIQINQ.MensualidadLiquidada (idMens) then
//     ShowMessage('No se puede modificar algo ya liquidado')
//  else
   PantInqMensualidad(idMens);
end;

procedure TfrmContratoAE.btnInqMensDelClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', '¿Borro el registro seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_LIQINQ.BorrarLiqMensual;
end;


(*******************************************************************************
*** ESTADO DE CUENTA
*******************************************************************************)
procedure TfrmContratoAE.btnAgregarCuentaClick(Sender: TObject);
var
  pant: TfrmCuentaContratoAE;
begin
  pant:= TfrmCuentaContratoAE.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** GARANTES
*******************************************************************************)


procedure TfrmContratoAE.btnAgregarGarantesClick(Sender: TObject);
var
  pant: TfrmGarantesListado;
begin
  pant:= TfrmGarantesListado.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_Contratos.AltaGarante (pant.idGaranteSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmContratoAE.btnQuitarGarantesClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el garante seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    DM_Contratos.BajaGarante;
end;

end.

