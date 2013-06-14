program gac;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazreport, rxnew, rx, zcomponent, frm_principal, dmconexion, dmgeneral,
  SD_Configuracion, frm_movimientoscaja, frm_movimientocajaae, dmcaja,
  frm_personaae, dmpersonas, frm_propietariosae, dmpropietarios,
  frm_ediciontugs, dmediciontugs, frm_contactosae, frm_domicilioae,
  frm_propietarioscuentas, versioninfo, frm_buscarpropietarios,
  frm_propiedadesae, dmpropiedades, frm_buscarpropiedades, dminquilinos,
  frm_inquilinosae, frm_inquilinoslistado, frm_contratoae, dmcontratos,
  frm_gastosmensualeslistado, frm_gastomensualdestino, frm_buscarcontratos,
  dmliquidaciones, dmliqinquilinos, frm_cuentacontratoae, frm_propiedadescuotas,
  frm_inqgastomensualae, frm_garanteslistado, frm_garantesae, dmgarantes,
frm_inquilinoscaja, dmseguridad, frm_gastosAE, frm_cajaae;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM_Conexion, DM_Conexion);
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Caja, DM_Caja);
  Application.CreateForm(TDM_Personas, DM_Personas);
  Application.CreateForm(TDM_Propietarios, DM_Propietarios);
  Application.CreateForm(TDM_EdicionTUGs, DM_EdicionTUGs);
  Application.CreateForm(TDM_Inquilinos, DM_Inquilinos);
  Application.CreateForm(TDM_Propiedades, DM_Propiedades);
  Application.CreateForm(TDM_Contratos, DM_Contratos);
  Application.CreateForm(TDM_LIQINQ, DM_LIQINQ);
  Application.CreateForm(TDM_Liquidacion, DM_Liquidacion);
  Application.CreateForm(TDM_Garantes, DM_Garantes);

  Application.CreateForm(TfrmAlquileres, frmAlquileres);

  Application.Run;
end.

