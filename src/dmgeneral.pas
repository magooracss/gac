unit dmgeneral;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Dialogs
  , StdCtrls
  , ZConnection, ZDataset, rxmemds, StrHolder, LR_Class, LR_DBSet, db
  //, LR_Class
    ,rxdbcomb
  ,Graphics, ExtCtrls
  ;

const
  _PRN_ORDENTRABAJO_ = 'ordentrabajo.lrf';
   DIA_VENCIMIENTO = 5;

type

  GUID_ID = string[38];

  TOperacion = (nuevo, modificar, eliminar);

  { TDM_General }

  TDM_General = class(TDataModule)
    elReporte: TfrReport;
    frDataset: TfrDBDataSet;
    ImgAcciones: TImageList;
    RxMemoryData1: TRxMemoryData;
  private
    { private declarations }
  public
    procedure CargarComboBox (var elComboBox: TComboBox; campoVisible, campoIndice: string; var tablaRelleno: TZQuery);
    procedure CargarComboBoxTb (var elComboBox: TComboBox; campoVisible, campoIndice: string; var tablaRelleno: TRxMemoryData);
    procedure CargarComboBoxRxTb (var elComboBox: TRxDBComboBox; campoVisible, campoIndice: string; var tablaRelleno: TRxMemoryData);

    function obtenerIdxCombo (var elComboBox: TComboBox; indice: integer): integer;
    function obtenerIdxComboTb (var elComboBox: TComboBox; indice: GUID_ID): integer;

    function obtenerIDIntComboBox (var elComboBox: TComboBox): integer;
    function obtenerIDGuidComboBox (var elComboBox: TComboBox): GUID_ID;


    procedure ConectarConexiones (var elDM: TDataModule);
    procedure CambiarEstadoTablas (var elDM: TDataModule; elEstado: boolean);
    procedure ReiniciarTabla (var laTabla: TRxMemoryData);
    procedure LevantarTugsATablas (var elDM: TDataModule);

    procedure CargarParametros (var laConsulta: TzQuery; var laTabla: TRxMemoryData);
    procedure GrabarDatos(var BuscarID, Insertar, Modificar: TZQuery; var Datos: TRxMemoryData; campoId: string );
    procedure BorrarDatos (var Consulta: TZQuery; var lista: TStrHolder);

    function CampoTUG (var Consulta: TZQuery; CampoId, CampoVisible: string; Indice: integer): string;
    procedure EditarCampoIntTabla (var Dataset: TDataSet; campo: string; valor: integer);


    function CrearGUID: GUID_ID;

    procedure cambiarNulos (var laTabla: TRxMemoryData);

    function FormatearFecha (laFecha: TDateTime): string;
    procedure IntervaloFechasConsulta (var fIni, fFin: TDateTime);

    procedure LevantarReporte (Reporte: string; elDataset: TDataSet);
    procedure EditarReporte;
    procedure EjecutarReporte;
    procedure EjecutarReporteSilencioso;
    procedure AgregarVariableReporte (variable, valor: string);

    Function CuitValido (S: String): Boolean;

    procedure cargarImagen(var elBlob: TBlobField; elTipoImagen: integer; var elComponente: TImage);
    function tipoFormatoArchivo(nombreArchivo: string): integer;


  end;

Const
  GUIDNULO = '{00000000-0000-0000-0000-000000000000}';


var
  DM_General: TDM_General;

implementation
uses
  dmConexion
  ,dateutils
  ,SD_Configuracion
  ,strutils
  ;


{ TDM_General }

(*
Función general que recibe un comboBox y una tabla y devuelve el combo con los valores cargados y
la clave primaria de la tabla asociada como objeto a cada uno de los valores
*)
procedure TDM_General.CargarComboBox(var elComboBox: TComboBox; campoVisible,
  campoIndice: string; var tablaRelleno: TZQuery);
begin
  elComboBox.Items.Clear;
  with tablaRelleno do
  begin
    if Active then close;
    Open;
    While Not EOF do
    begin
      elComboBox.Items.AddObject(FieldByName(campoVisible).asString, TObject(FieldByName (campoIndice).asInteger));
      Next;
    end;
  end;
  if elComboBox.Items.Count > 0 then
   elComboBox.ItemIndex:= 0;
end;

procedure TDM_General.CargarComboBoxTb(var elComboBox: TComboBox; campoVisible,
  campoIndice: string; var tablaRelleno: TRxMemoryData);
var
  cad: string;
begin
  elComboBox.Items.Clear;
  with tablaRelleno do
  begin
    First;
    While Not EOF do
    begin
      cad:=FieldByName (campoIndice).AsString;
      elComboBox.Items.AddObject(FieldByName(campoVisible).asString, TObject(cad));
      Next;
    end;
  end;
  if elComboBox.Items.Count > 0 then
    elComboBox.ItemIndex:= 0;
end;

procedure TDM_General.CargarComboBoxRxTb(var elComboBox: TRxDBComboBox;
  campoVisible, campoIndice: string; var tablaRelleno: TRxMemoryData);
begin
  elComboBox.Items.Clear;
  elComboBox.Values.Clear;
  with tablaRelleno do
  begin
    First;
    While NOT Eof do
    begin
      elComboBox.Items.Add(FieldByName(campoVisible).asString);
      elComboBox.Values.Add(FieldByName(campoIndice).asString);
      Next;
    end;
  end;
end;

(*
Recibe un combobox y el id de la clave primaria de una tabla y devuelve el itemindex
del combo donde está esa clave. Si no la encuentra, devuelve -1
*)
function TDM_General.obtenerIdxCombo(var elComboBox: TComboBox; indice: integer
  ): integer;
var
 i, resultado: integer;
begin
 i:= elComboBox.Items.Count - 1;
 resultado:= -1;
 while (i >= 0) and (resultado = -1) do
 begin
   if (integer(elComboBox.Items.Objects[i]) = indice) then
      resultado:= i;
   DEC (i);
 end;
 Result:= resultado;
end;

function TDM_General.obtenerIdxComboTb(var elComboBox: TComboBox;
  indice: GUID_ID): integer;
var
 i, resultado: integer;
begin
 i:= elComboBox.Items.Count - 1;
 resultado:= -1;

 while (i >= 0) and (resultado = -1) do
 begin

   if (string(elComboBox.Items.Objects[i]) = indice) then
   begin
      resultado:= i;

   end;
   DEC (i);
 end;
 Result:= resultado;
end;

(***
*** Devuelve el indice integer de la tabla almacenado en el comboBox.
***)

function TDM_General.obtenerIDIntComboBox(var elComboBox: TComboBox): integer;
begin
   if (elComboBox.Items.Count > 0) and (elComboBox.ItemIndex >= 0) then
     Result:= integer(elComboBox.Items.Objects[elComboBox.ItemIndex])
   else
     Result:= 0;
end;

function TDM_General.obtenerIDGuidComboBox(var elComboBox: TComboBox): GUID_ID;
begin
  if (elComboBox.Items.Count > 0)  and (elComboBox.ItemIndex >= 0)then
  begin
    Result:= string(elComboBox.Items.Objects[elComboBox.ItemIndex])
  end
  else
    Result:= GUIDNULO;

end;

procedure TDM_General.ConectarConexiones(var elDM: TDataModule);
var
 i: integer;
begin
  for i:= 0 to elDM.ComponentCount - 1 do
  begin
    if (elDM.Components[i] is TZQuery) then
    begin
      (elDM.Components[i] as TZQuery).Connection:= DM_Conexion.cnxGeneral ;
    end;
  end;

end;

procedure TDM_General.CambiarEstadoTablas(var elDM: TDataModule;
  elEstado: boolean);
var
 i: integer;
begin
  for i:= 0 to elDM.ComponentCount - 1 do
  begin
    if (elDM.Components[i] is TRxMemoryData) then
    begin
      (elDM.Components[i] as TRxMemoryData).Active:= elEstado;
    end;
  end;
end;

procedure TDM_General.ReiniciarTabla(var laTabla: TRxMemoryData);
begin
  with laTabla do
  begin
    if Active then close;
    open;
  end;
end;

procedure TDM_General.LevantarTugsATablas(var elDM: TDataModule);
var
 i: integer;
 laConsulta: TZQuery;
begin
  for i:= 0 to elDM.ComponentCount - 1 do
  begin
    if (elDM.Components[i] is TRxMemoryData) and (upcase (copy((elDM.Components[i] as TRxMemoryData).Name,1,3)) = 'TUG') then
    begin
      laConsulta:= (elDM.FindComponent('q'+(elDM.Components[i] as TRxMemoryData).Name) as TZQuery);
      if laConsulta <> nil then
      begin
        (elDM.Components[i] as TRxMemoryData).Active:= False;
        if laConsulta.Active then laConsulta.close;
        laConsulta.Open;
        (elDM.Components[i] as TRxMemoryData).Active:= True;
        (elDM.Components[i] as TRxMemoryData).LoadFromDataSet(laconsulta, 0, lmAppend);
         laConsulta.Close;
      end;
    end;
  end;
end;


procedure TDM_General.CargarParametros (var laConsulta: TzQuery; var laTabla: TRxMemoryData);
var
 indice: integer;
begin
  for indice:= 0 to laConsulta.Params.Count -1 do
  begin
    laConsulta.Params[indice].DataType:= laTabla.fieldByName(laConsulta.Params[indice].Name).DataType;
    if NOT laTabla.fieldByName(laConsulta.Params[indice].Name).IsNull then
      laConsulta.Params[indice].Value:= laTabla.fieldByName(laConsulta.Params[indice].Name).value;
  end;
end;


procedure TDM_General.GrabarDatos(var BuscarID, Insertar,
  Modificar: TZQuery; var Datos: TRxMemoryData; campoId: string );
var
 qConsulta: TZQuery;
begin
 Datos.First;
 while (NOT Datos.Eof) do
 begin
   if BuscarId.Active then
    BuscarID.Close;
   BuscarID.ParamByName(campoId).AsString:= TRIM(Datos.fieldByName (campoId).asString);
   BuscarID.Open;

   if (BuscarID.RecordCount > 0) then
    qConsulta:= Modificar
   else
    qConsulta:= Insertar;

   CargarParametros(qConsulta, Datos);
   qConsulta.ExecSQL;
   Datos.Next;
 end;

end;

procedure TDM_General.BorrarDatos(var Consulta: TZQuery; var lista: TStrHolder);
var
 indice: integer;
begin
  indice:= 0;
  While (indice < lista.Strings.Count) do
  begin
    Consulta.ParamByName('parametro').AsString:= lista.Strings[indice];
    Consulta.ExecSQL;
    Inc (indice);
  end;
end;

function TDM_General.CampoTUG(var Consulta: TZQuery; CampoId,
  CampoVisible: string; Indice: integer): string;
begin
  with Consulta do
  begin
    if Active then close;
    ParamByName(CampoId).AsInteger:= Indice;
    Open;
    if Not EOF then
      Result:= FieldByName(CampoVisible).asString
    else
      Result:= EmptyStr;
  end;
end;

procedure TDM_General.EditarCampoIntTabla(var Dataset: TDataSet; campo: string;
  valor: integer);
begin
  with DataSet do
  begin
    Edit;
    FieldByName (campo).asInteger:= valor;
    Post;
  end;
end;

function TDM_General.CrearGUID: GUID_ID;
var
 unGuid: TGuid;
begin
  Result:= GUIDNULO;
  if CreateGUID(unGuid) = S_OK then
    Result:= GUIDToString(unGuid) ;
end;

procedure TDM_General.cambiarNulos(var laTabla: TRxMemoryData);
var
 i: integer;
begin
  with laTabla do
  begin
    First;
    while Not EOF do
    begin
      Edit;
      for i:= 0 to FieldCount -1 do
      begin
        if (Fields[i].IsNull) and (Fields[i].DataType = ftString) then
          FieldByName(Fields[i].FieldName).AsString:= ' ';
      end;
      Next;
    end;
  end;
end;

function TDM_General.FormatearFecha(laFecha: TDateTime): string;
var
 dia, mes, ano: word;
begin
  DecodeDate(laFecha, ano, mes, dia);
  Result:= IntToStr(ano)+ '-' + Copy ('00'+IntToStr(mes),Length('00'+IntToStr(mes)) -1, 2)+ '-'+Copy ('00'+IntToStr(dia),Length('00'+IntToStr(dia)) -1, 2);
end;

procedure TDM_General.IntervaloFechasConsulta(var fIni, fFin: TDateTime);
var
 y,m,d: word;
begin
  DecodeDate(fIni, y,m,d);
  fIni:= EncodeDateTime(y,m,d,0,0,0,1);

  DecodeDate(fFin, y,m,d);
  fFin:= EncodeDateTime(y,m,d,23,59,59,999);
end;


(********************************************************************************
*** MANEJO DE LOS REPORTES
*******************************************************************************)
procedure TDM_General.LevantarReporte(Reporte: string; elDataset: TDataSet);
var
  ruta: string;
begin
  with elReporte do
  begin
    ruta:= LeerDato (SECCION_APP ,RUTA_LISTADOS) ;
    LoadFromFile(ruta+ Reporte);
    frDataset.DataSet:= elDataset;
  end;
end;

procedure TDM_General.EditarReporte;
begin
  elReporte.DesignReport;
end;

procedure TDM_General.EjecutarReporte;
begin
  elReporte.ShowReport;
end;

procedure TDM_General.EjecutarReporteSilencioso;
begin
  elReporte.ModalPreview:= False;
  elReporte.PrepareReport;
  elReporte.PrintPreparedReport('1',1);
end;

procedure TDM_General.AgregarVariableReporte(variable, valor: string);
begin
  frVariables [variable]:= valor;
end;

function TDM_General.CuitValido(S: String): Boolean;
{
 determina si el dígito verificador es correcto
 Retorna true si es correcto y false si es incorrecto
}
var
   v2,v3 : Integer;
Begin
     S:= Trim(DelChars(S,'-'));
     v2 := (StrToIntDef(S[1], 0)  * 5 +
            StrToIntDef(S[2], 0)  * 4 +
            StrToIntDef(S[3], 0)  * 3 +
            StrToIntDef(S[4], 0)  * 2 +
            StrToIntDef(S[5], 0)  * 7 +
            StrToIntDef(S[6], 0)  * 6 +
            StrToIntDef(S[7], 0)  * 5 +
            StrToIntDef(S[8], 0)  * 4 +
            StrToIntDef(S[9], 0)  * 3 +
            StrToIntDef(S[10], 0) * 2) mod 11;
     v3 := 11 - v2;
     Case v3 of
          11 : v3 := 0;
          10 : v3 := 9;
     end;
     Result:=  strtoint(s[11]) = v3;
End;


(********************************************************************************
*** MANEJO DE LOSA RCHIVOS DE IMAGEN
*******************************************************************************)

(****
*****
   Valores devueltos:

   Desconocido: 0
   JPG, JPEG, JPE : 1
   BMP, DIB: 2
   ICO: 3
   EMF, WMF: 4
*****
****)
function TDM_General.tipoFormatoArchivo(nombreArchivo: string): integer;
var
  ExtArchivo: string;
begin
  Result:= 0;
  ExtArchivo := LowerCase(ExtractFileExt(nombreArchivo));
  if ((ExtArchivo = '.jpg') or (ExtArchivo = '.jpeg') or (ExtArchivo = '.jpe')) then Result:= 1
  else
    if ((ExtArchivo  = '.bmp') or (ExtArchivo ='.dib')) then Result:= 2
    else
      if ((ExtArchivo = '.emf') or (ExtArchivo ='.wmf')) then Result:= 4
      else
        if (ExtArchivo = '.ico') then Result:= 3;
end;

procedure TDM_General.cargarImagen(var elBlob: TBlobField;
  elTipoImagen: integer; var elComponente: TImage);
type
  TGraficoTipo = (gtBitmap, gtIcon, gtMetafile, gtJpeg);
var
  Stream: TMemoryStream;
//  Jpg: TJpegImage;
  tipo: TGraficoTipo;
begin
  //Jpg := nil;
  Stream := nil;
  try
    Stream := TMemoryStream.Create;
    elBlob.SaveToStream(Stream);
    case elTipoImagen of
     1: tipo:= gtJpeg;
     2: tipo:= gtBitmap;
     3: tipo:= gtMetafile;
     4: tipo:= gtIcon;
    end;
     if Stream.Size > 0 then
     begin
        Stream.Position := 0;
        Stream.Read(tipo, 1);
        case tipo of
          gtBitmap: elComponente.Picture.Bitmap.LoadFromStream(Stream);
          gtIcon: elComponente.Picture.Icon.LoadFromStream(Stream);
          gtJpeg: elComponente.Picture.Jpeg.LoadFromStream(Stream);
(*
          gtJpeg:
          begin
            Jpg := TJpegImage.Create;
            Jpg.LoadFromStream(Stream);
            elComponente.Picture.Assign(Jpg);
          end
*)
          else
            elComponente.Picture.Assign(nil);
        end;
     end
     else
       elComponente.Picture.Assign(nil)
  except
   elComponente.Picture.Assign(nil);
  end;
  //  jpg.Free;
    Stream.Free;
end;

initialization
  {$I dmgeneral.lrs}

end.

