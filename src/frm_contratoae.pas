unit frm_contratoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DbCtrls, StdCtrls, DBGrids, Buttons, dbdateedit
  ,dmgeneral, Grids;

type

  { TfrmContratoAE }

  TfrmContratoAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    btnGenerarLiquidacion: TBitBtn;
    btnAgregarGarantes: TBitBtn;
    btnInqMensDel1: TBitBtn;
    btnInqGastoDel: TBitBtn;
    btnInqCajaDel: TBitBtn;
    btnInqDescDel: TBitBtn;
    btnInqPagareDel: TBitBtn;
    btnInqMensEdit1: TBitBtn;
    btnInqGastoEdit: TBitBtn;
    btnInqCajaUpd: TBitBtn;
    btnInqDescUpd: TBitBtn;
    btnInqPagareEdit: TBitBtn;
    btnInqMensNew1: TBitBtn;
    btnInqGastoNew: TBitBtn;
    btnInqCajaNew: TBitBtn;
    btnInqDescNew: TBitBtn;
    btnInqPagareNew: TBitBtn;
    btnQuitarGarantes: TBitBtn;
    BitBtn5: TBitBtn;
    btnAgregarCuenta: TBitBtn;
    btnAgregarInquilino: TBitBtn;
    btnQuitarInquilino: TBitBtn;
    btnGrabarSalir: TBitBtn;
    btnAgregarGasto: TBitBtn;
    btnQuitarGasto: TBitBtn;
    btnBuscar: TBitBtn;
    btnRecargarCuotas1: TBitBtn;
    btnTugTipoContrato: TSpeedButton;
    cbTipoContrato: TComboBox;
    cbCuentaCorriente: TComboBox;
    ckAlquilerGarantizado: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit9: TDBEdit;
    DBGrid10: TDBGrid;
    DBGrid11: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid5: TDBGrid;
    DBGrid8: TDBGrid;
    DBGrid9: TDBGrid;
    ds_inqMeses: TDatasource;
    DBEdit8: TDBEdit;
    DBGrid4: TDBGrid;
    DBGrid6: TDBGrid;
    DBGrid7: TDBGrid;
    DS_Contrato: TDatasource;
    ckBanco: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    ds_inqGastos: TDatasource;
    ds_inqCaja: TDatasource;
    ds_inqDescuentos: TDatasource;
    ds_inqPagares: TDatasource;
    ds_LiqItems: TDatasource;
    ds_Inquilinos: TDatasource;
    ds_garantes: TDatasource;
    ds_ResumenLiquidacion: TDatasource;
    ds_Propietarios: TDatasource;
    ds_GastosMensuales: TDatasource;
    edHonorariosTotal: TEdit;
    edPropiedad: TEdit;
    gbMensualidades1: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
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
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PCContratos: TPageControl;
    Panel1: TPanel;
    PcCuentaCorriente: TPageControl;
    tabDatos: TTabSheet;
    tabPartes: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Gastos: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    tabTodo: TTabSheet;
    procedure btnAgregarCuentaClick(Sender: TObject);
    procedure btnAgregarGarantesClick(Sender: TObject);
    procedure btnGenerarLiquidacionClick(Sender: TObject);
    procedure btnInqCajaDelClick(Sender: TObject);
    procedure btnInqCajaNewClick(Sender: TObject);
    procedure btnInqDescDelClick(Sender: TObject);
    procedure btnInqDescNewClick(Sender: TObject);
    procedure btnInqDescUpdClick(Sender: TObject);
    procedure btnInqGastoDelClick(Sender: TObject);
    procedure btnInqGastoEditClick(Sender: TObject);
    procedure btnInqGastoNewClick(Sender: TObject);
    procedure btnInqMensDelClick(Sender: TObject);
    procedure btnInqCajaUpdClick(Sender: TObject);
    procedure btnInqMensEditClick(Sender: TObject);
    procedure btnInqMensNewClick(Sender: TObject);
    procedure btnInqPagareDelClick(Sender: TObject);
    procedure btnInqPagareEditClick(Sender: TObject);
    procedure btnInqPagareNewClick(Sender: TObject);
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
    procedure DBGrid9PrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure FormShow(Sender: TObject);
  private
    _idContrato: GUID_ID;
    procedure Inicializar;
    procedure LevantarCuentasCorrientes;

    procedure PantInqMensualidad (idMensualidad: GUID_ID);
    procedure PantGastos (operacion: TOperacion);
    procedure PantCaja (operacion: TOperacion);
    procedure PantDescuentos (operacion: TOperacion);
    procedure PantPagares (operacion: TOperacion);


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
  ,frm_gastosAE
  ,frm_cajaae
  ,frm_descuentosae
  ,frm_pagaresae
  ,frm_selMes
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

procedure TfrmContratoAE.DBGrid9PrepareCanvas(sender: TObject;
  DataCol: Integer; Column: TColumn; AState: TGridDrawState);
begin
  if ( (Column.Field.FieldName = 'fPago')
     or (Column.Field.FieldName = 'fVencimiento')
      ) then
  begin
      if (   (Column.Field.IsNull)
          or (Column.Field.Value = StrToDate('30/12/1899'))
          or (Column.Field.Text = '30/12/1899')
         )then
       begin
         with (Sender As TDBGrid) do
         begin
           //Custom drawing
//           Canvas.Brush.Color:=clYellow;
           Canvas.Font.Color:=Canvas.Brush.Color;
//           Canvas.Font.Style:=[fsBold];
         end;
       end;
  end;
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
  DM_LIQINQ.LevantarCuentaCorrienteContrato (_idContrato);
//  DM_LIQINQ.LevantarCuotasPorContrato(_idContrato);

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


(*******************************************************************************
*** GASTOS INQUILINOS
*******************************************************************************)

procedure TfrmContratoAE.PantGastos(operacion: TOperacion);
var
  pant: TfrmGastoAE;
begin
  pant:= TfrmGastoAE.Create(self);
  try
   if (Operacion = modificar) then
   begin
     pant.descripcion:= ds_inqGastos.DataSet.FieldByName('Gasto').asString;
     pant.monto:= ds_inqGastos.DataSet.FieldByName('nMonto').AsFloat;
   end;
   if pant.ShowModal = mrOK then
   begin
     DM_LIQINQ.AsentarGasto (_idContrato, pant.descripcion, pant.monto, operacion);
   end;
  finally
    pant.Free;
  end;
end;

procedure TfrmContratoAE.btnInqGastoNewClick(Sender: TObject);
begin
  PantGastos(nuevo);
end;

procedure TfrmContratoAE.btnInqGastoEditClick(Sender: TObject);
begin
  if (ds_inqGastos.DataSet.RecordCount > 0) then
    PantGastos(modificar);
end;

procedure TfrmContratoAE.btnInqGastoDelClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el gasto seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_LIQINQ.BorrarGastoActual;
   end;
end;

(*******************************************************************************
*** CAJA INQUILINOS
*******************************************************************************)

procedure TfrmContratoAE.PantCaja(operacion: TOperacion);
var
  pant: TfrmCajaAE;
begin
  pant:= TfrmCajaAE.Create(self);
  try
   if (Operacion = modificar) then
   begin
     pant.descripcion:= ds_inqCaja.DataSet.FieldByName('Descripcion').asString;
     pant.monto:= ds_inqCaja.DataSet.FieldByName('Monto').AsFloat;
     pant.fVencimiento:= ds_inqCaja.DataSet.FieldByName('fVencimiento').AsDateTime;
     pant.montoPago:= ds_inqCaja.DataSet.FieldByName('Pagado').AsFloat;
     pant.fPago:= ds_inqCaja.DataSet.FieldByName('fPago').AsDateTime;
     pant.refTipo:= ds_inqCaja.DataSet.FieldByName('refTipo').AsInteger;
   end;
   if pant.ShowModal = mrOK then
   begin
     DM_LIQINQ.AsentarCaja (_idContrato, pant.descripcion, pant.monto
                          , pant.fVencimiento, pant.montoPago, pant.fPago
                          , pant.refTipo, operacion);
   end;
  finally
    pant.Free;
  end;
end;

procedure TfrmContratoAE.btnInqCajaNewClick(Sender: TObject);
begin
  PantCaja(nuevo);
end;

procedure TfrmContratoAE.btnInqCajaUpdClick(Sender: TObject);
begin
   PantCaja(modificar);
end;

procedure TfrmContratoAE.btnInqCajaDelClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el movimiento de caja seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_LIQINQ.BorrarCajaActual;
   end;
end;

(*******************************************************************************
*** DESCUENTOS INQUILINOS
*******************************************************************************)

procedure TfrmContratoAE.PantDescuentos(operacion: TOperacion);
var
  pant: TfrmDescuentosAE;
begin
  pant:= TfrmDescuentosAE.Create(self);
  try
   if (Operacion = modificar) then
   begin
     pant.descripcion:= ds_inqDescuentos.DataSet.FieldByName('Descuento').asString;
     pant.monto:= ds_inqDescuentos.DataSet.FieldByName('nMonto').AsFloat;
   end;

   if pant.ShowModal = mrOK then
   begin
     DM_LIQINQ.AsentarDescuento (_idContrato, pant.descripcion, pant.monto, operacion );
   end;
  finally
    pant.Free;
  end;
end;

procedure TfrmContratoAE.btnInqDescNewClick(Sender: TObject);
begin
  PantDescuentos(nuevo);
end;

procedure TfrmContratoAE.btnInqDescUpdClick(Sender: TObject);
begin
  PantDescuentos(modificar);
end;

procedure TfrmContratoAE.btnInqDescDelClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el descuento seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_LIQINQ.BorrarDescuentoActual;
   end;
end;


(*******************************************************************************
*** PAGARES INQUILINOS
*******************************************************************************)

procedure TfrmContratoAE.PantPagares(operacion: TOperacion);
var
  pant: TfrmPagaresAE;
begin
  pant:= TfrmPagaresAE.Create(self);
  try
   if (Operacion = modificar) then
   begin
     pant.fVencimiento:= ds_inqPagares.DataSet.FieldByName('fVencimiento').AsDateTime;
     pant.monto:= ds_inqPagares.DataSet.FieldByName('nMonto').AsFloat;
     pant.montoPunitorios:= ds_inqPagares.DataSet.FieldByName('nPunitorios').AsFloat;
     pant.montoTotal:= ds_inqPagares.DataSet.FieldByName('nTotal').AsFloat;
   end;
   if pant.ShowModal = mrOK then
   begin
     DM_LIQINQ.AsentarPagare (_idContrato, pant.fVencimiento, pant.monto
                          , pant.montoPunitorios, pant.montoTotal, operacion);
   end;
  finally
    pant.Free;
  end;
end;


procedure TfrmContratoAE.btnInqPagareNewClick(Sender: TObject);
begin
  PantPagares(nuevo);
end;

procedure TfrmContratoAE.btnInqPagareEditClick(Sender: TObject);
begin
  PantPagares(modificar);
end;

procedure TfrmContratoAE.btnInqPagareDelClick(Sender: TObject);
begin
   if (MessageDlg ('ATENCION', 'Borro el Pagaré seleccionado?', mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     DM_LIQINQ.BorrarPagareActual;
   end;
end;


(*******************************************************************************
*** GENERAR LIQUIDACION
*******************************************************************************)

procedure TfrmContratoAE.btnGenerarLiquidacionClick(Sender: TObject);
var
  selMes: TfrmSeleccionMes;
begin
  selMes:= TfrmSeleccionMes.Create(self);
  try
   if selMes.ShowModal = mrOK then
   begin
     DM_LIQINQ.CargarLiquidacionMes(selMes.MesSeleccionado, selMes.AnoSelecccionado, _idContrato);
   end;
  finally
    selMes.Free;
  end;
end;


end.

