unit CalculadoraRTC.Calculadora;

{$mode objfpc}{$H+}
{$interfaces COM}  // habilita interfaces COM (com referência/contagem e liberação automática)

interface

uses
  Classes, SysUtils,
  fpjson, jsonparser,
  RESTRequest4D,
  FPHTTPClient, // EncodeURLElement
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Utils.Payload,
  CalculadoraRTC.Utils.Logging,
  CalculadoraRTC.Schemas.ROC.Core,
  CalculadoraRTC.Schemas.ROC.Inputs,
  CalculadoraRTC.Schemas.Pedagio,
  CalculadoraRTC.Schemas.DadosAbertos;

type
  ECalculadoraRTC = class(Exception);

  { Interface com reference counting para facilitar o gerenciamento de memória }

  { ICalculadoraRTC }

  ICalculadoraRTC = interface(IInterface)
    ['{5B3C2C3E-486B-4F7D-9E5E-0A2C9C6E0F12}']

    // Builders (fluentes)
    function BaseUrl(const AValue: string): ICalculadoraRTC;
    function Timeout(const AMS: Integer): ICalculadoraRTC;
    function UserAgent(const AValue: string): ICalculadoraRTC;
    function Logger(const ALogger: ICalcLogger): ICalculadoraRTC;

    // Endpoints principais
    function CalcularRegimeGeralJSON(const AOperacao: IOperacaoInput): TJSONData;
    function CalcularRegimeGeral(const AOperacao: IOperacaoInput): IROC;

    function CalcularISMercadorias(const AInputJson: TJSONObject): TJSONData;
    function CalcularCibs(const AInputJson: TJSONObject): TJSONData;

    function CalcularPedagioJSON(const AInputJson: TJSONObject): TJSONData;
    function CalcularPedagio(const AInputJson: TJSONObject): ITributoPedagioOutput;

    function ValidarXml(const ATipo: string; const ASubtipo: string; const AXml: string): Boolean;
    function GerarXml(const ARocJson: TJSONObject): string;

    // Dados abertos
    function ConsultarVersaoJSON: TJSONData;
    function ConsultarVersao: IVersaoOutput;
    function ConsultarUfsJSON: TJSONData;
    function ConsultarUfs: TListaUF;
    function ConsultarMunicipiosPorSiglaUfJSON(const ASiglaUf: string): TJSONData;
    function ConsultarMunicipiosPorSiglaUf(const ASiglaUf: string): TListaMunicipio;
    function ConsultarSituacoesTributariasISJSON(const ADataISO: string): TJSONData;
    function ConsultarSituacoesTributariasIS(const ADataISO: string): TListaSituacaoTributaria;
    function ConsultarSituacoesTributariasCbsIbsJSON(const ADataISO: string): TJSONData;
    function ConsultarSituacoesTributariasCbsIbs(const ADataISO: string): TListaSituacaoTributaria;
    function ConsultarNcmJSON(const ANcm: string; const ADataISO: string): TJSONData;
    function ConsultarNcm(const ANcm: string; const ADataISO: string): INcmOutput;
    function ConsultarNbsJSON(const ANbs: string; const ADataISO: string): TJSONData;
    function ConsultarNbs(const ANbs: string; const ADataISO: string): INbsOutput;
    function ConsultarFundamentacoesLegaisJSON(const ADataISO: string): TJSONData;
    function ConsultarFundamentacoesLegais(const ADataISO: string): TListaFundClass;
    function ConsultarClassificacoesTributariasPorIdJSON(const AId: Int64; const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasPorId(const AId: Int64; const ADataISO: string): TListaClassTrib;
    function ConsultarClassificacoesTributariasISJSON(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasIS(const ADataISO: string): TListaClassTrib;
    function ConsultarClassificacoesTributariasCbsIbsJSON(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasCbsIbs(const ADataISO: string): TListaClassTrib;
    function ConsultarAliquotaUniaoJSON(const ADataISO: string): TJSONData;
    function ConsultarAliquotaUniao(const ADataISO: string): IAliquotaOutput;
    function ConsultarAliquotaUfJSON(const ACodigoUf: Int64; const ADataISO: string): TJSONData;
    function ConsultarAliquotaUf(const ACodigoUf: Int64; const ADataISO: string): IAliquotaOutput;
    function ConsultarAliquotaMunicipioJSON(const ACodigoMunicipio: Int64; const ADataISO: string): TJSONData;
    function ConsultarAliquotaMunicipio(const ACodigoMunicipio: Int64; const ADataISO: string): IAliquotaOutput;

    // Propriedades de somente-leitura (expostas por getters)
    function GetLastAppVersion: string;
    function GetLastDbVersion: string;
    function GetLastStatus: Integer;
    function GetLastResponseText: string;
    function GetLastResponseJSON: TJSONData;
    function GetLastResponseXML: string;

    property LastAppVersion: string read GetLastAppVersion;
    property LastDbVersion: string read GetLastDbVersion;
    property LastStatus: Integer read GetLastStatus;

    property LastResponseText: string read GetLastResponseText;
    property LastResponseJSON: TJSONData read GetLastResponseJSON;
    property LastResponseXML: string read GetLastResponseXML;
  end;

  { TCalculadoraRTCCalculadora }

  TCalculadoraRTCCalculadora = class(TInterfacedObject, ICalculadoraRTC)
  private
    fpBaseUrl: string;
    fpTimeout: Integer;
    fpUserAgent: string;

    fpLastAppVersion: string;
    fpLastDbVersion: string;

    fpLastResponseText: string;
    fpLastResponseJSON: TJSONData;
    fpLastResponseXML: string;
    fpLastStatus: Integer;

    fpLogger: ICalcLogger;

    function BuildUrl(const APath: string): string;
    procedure ClearLastResponse;
    function ParseJsonText(const AText: string): TJSONData;

    function DoPostJSON(const APath: string; const ABody: TJSONObject): TJSONData;
    function DoGetJSON(const ARelPathAndQuery: string): TJSONData;

    // Getters para propriedades da interface
    function GetLastAppVersion: string;
    function GetLastDbVersion: string;
    function GetLastStatus: Integer;
    function GetLastResponseText: string;
    function GetLastResponseJSON: TJSONData;
    function GetLastResponseXML: string;

  public
    class function New: ICalculadoraRTC; static;
    destructor Destroy; override;

    // ICalculadoraRTC (builders)
    function BaseUrl(const AValue: string): ICalculadoraRTC;
    function Timeout(const AMS: Integer): ICalculadoraRTC;
    function UserAgent(const AValue: string): ICalculadoraRTC;
    function Logger(const ALogger: ICalcLogger): ICalculadoraRTC;

    // ICalculadoraRTC (endpoints)
    function CalcularRegimeGeralJSON(const AOperacao: IOperacaoInput): TJSONData;
    function CalcularRegimeGeral(const AOperacao: IOperacaoInput): IROC;

    function CalcularISMercadorias(const AInputJson: TJSONObject): TJSONData;
    function CalcularCibs(const AInputJson: TJSONObject): TJSONData;

    function CalcularPedagioJSON(const AInputJson: TJSONObject): TJSONData;
    function CalcularPedagio(const AInputJson: TJSONObject): ITributoPedagioOutput;

    function ValidarXml(const ATipo: string; const ASubtipo: string; const AXml: string): Boolean;
    function GerarXml(const ARocJson: TJSONObject): string;

    // ICalculadoraRTC (dados abertos)
    function ConsultarVersaoJSON: TJSONData;
    function ConsultarVersao: IVersaoOutput;
    function ConsultarUfsJSON: TJSONData;
    function ConsultarUfs: TListaUF;
    function ConsultarMunicipiosPorSiglaUfJSON(const ASiglaUf: string): TJSONData;
    function ConsultarMunicipiosPorSiglaUf(const ASiglaUf: string): TListaMunicipio;
    function ConsultarSituacoesTributariasISJSON(const ADataISO: string): TJSONData;
    function ConsultarSituacoesTributariasIS(const ADataISO: string): TListaSituacaoTributaria;
    function ConsultarSituacoesTributariasCbsIbsJSON(const ADataISO: string): TJSONData;
    function ConsultarSituacoesTributariasCbsIbs(const ADataISO: string): TListaSituacaoTributaria;
    function ConsultarNcmJSON(const ANcm: string; const ADataISO: string): TJSONData;
    function ConsultarNcm(const ANcm: string; const ADataISO: string): INcmOutput;
    function ConsultarNbsJSON(const ANbs: string; const ADataISO: string): TJSONData;
    function ConsultarNbs(const ANbs: string; const ADataISO: string): INbsOutput;
    function ConsultarFundamentacoesLegaisJSON(const ADataISO: string): TJSONData;
    function ConsultarFundamentacoesLegais(const ADataISO: string): TListaFundClass;
    function ConsultarClassificacoesTributariasPorIdJSON(const AId: Int64; const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasPorId(const AId: Int64; const ADataISO: string): TListaClassTrib;
    function ConsultarClassificacoesTributariasISJSON(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasIS(const ADataISO: string): TListaClassTrib;
    function ConsultarClassificacoesTributariasCbsIbsJSON(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasCbsIbs(const ADataISO: string): TListaClassTrib;
    function ConsultarAliquotaUniaoJSON(const ADataISO: string): TJSONData;
    function ConsultarAliquotaUniao(const ADataISO: string): IAliquotaOutput;
    function ConsultarAliquotaUfJSON(const ACodigoUf: Int64; const ADataISO: string): TJSONData;
    function ConsultarAliquotaUf(const ACodigoUf: Int64; const ADataISO: string): IAliquotaOutput;
    function ConsultarAliquotaMunicipioJSON(const ACodigoMunicipio: Int64; const ADataISO: string): TJSONData;
    function ConsultarAliquotaMunicipio(const ACodigoMunicipio: Int64; const ADataISO: string): IAliquotaOutput;
  end;

implementation

{ TCalculadoraRTCCalculadora }

class function TCalculadoraRTCCalculadora.New: ICalculadoraRTC;
var
  Obj: TCalculadoraRTCCalculadora;
begin
  Obj := TCalculadoraRTCCalculadora.Create;
  Obj.fpBaseUrl := 'https://piloto-cbs.tributos.gov.br/servico/calculadora-consumo/api';
  Obj.fpTimeout := 30000;
  Obj.fpUserAgent := 'CalculadoraRTC/DJSystem';
  Obj.fpLastResponseJSON := nil;
  Result := Obj; // retorna como interface (com ref counting)
end;

destructor TCalculadoraRTCCalculadora.Destroy;
begin
  if Assigned(fpLastResponseJSON) then
    fpLastResponseJSON.Free;
  inherited Destroy;
end;

{ Getters (propriedades da interface) }

function TCalculadoraRTCCalculadora.GetLastAppVersion: string;
begin
  Result := fpLastAppVersion;
end;

function TCalculadoraRTCCalculadora.GetLastDbVersion: string;
begin
  Result := fpLastDbVersion;
end;

function TCalculadoraRTCCalculadora.GetLastStatus: Integer;
begin
  Result := fpLastStatus;
end;

function TCalculadoraRTCCalculadora.GetLastResponseText: string;
begin
  Result := fpLastResponseText;
end;

function TCalculadoraRTCCalculadora.GetLastResponseJSON: TJSONData;
begin
  Result := fpLastResponseJSON;
end;

function TCalculadoraRTCCalculadora.GetLastResponseXML: string;
begin
  Result := fpLastResponseXML;
end;

{ Builders }

function TCalculadoraRTCCalculadora.BaseUrl(const AValue: string): ICalculadoraRTC;
begin
  fpBaseUrl := AValue;
  if (fpBaseUrl <> '') and (fpBaseUrl[Length(fpBaseUrl)] = '/') then
    Delete(fpBaseUrl, Length(fpBaseUrl), 1);
  Result := Self;
end;

function TCalculadoraRTCCalculadora.Timeout(const AMS: Integer): ICalculadoraRTC;
begin
  fpTimeout := AMS;
  Result := Self;
end;

function TCalculadoraRTCCalculadora.UserAgent(const AValue: string): ICalculadoraRTC;
begin
  fpUserAgent := AValue;
  Result := Self;
end;

function TCalculadoraRTCCalculadora.Logger(const ALogger: ICalcLogger): ICalculadoraRTC;
begin
  fpLogger := ALogger;
  Result := Self;
end;

{ Infra }

function TCalculadoraRTCCalculadora.BuildUrl(const APath: string): string;
begin
  if (Length(APath) > 0) and (APath[1] = '/') then
    Result := fpBaseUrl + APath
  else
    Result := fpBaseUrl + '/' + APath;
end;

procedure TCalculadoraRTCCalculadora.ClearLastResponse;
begin
  fpLastResponseText := '';
  fpLastResponseXML := '';
  fpLastStatus := 0;
  if Assigned(fpLastResponseJSON) then
  begin
    fpLastResponseJSON.Free;
    fpLastResponseJSON := nil;
  end;
end;

function TCalculadoraRTCCalculadora.ParseJsonText(const AText: string): TJSONData;
begin
  // Usa GetJSONExt para substituir TJSONFloatNumber -> TJSONExtFloatNumber
  // e garantir saída sem notação científica no FormatJSON.
  Result := GetJSONExt(AText, True);
end;

function TCalculadoraRTCCalculadora.DoPostJSON(const APath: string;
  const ABody: TJSONObject): TJSONData;
var
  LResponse: IResponse;
  LUrl: string;
  LBodyToSend: TJSONObject = nil;
  LErr: TJSONData;
  LDetail: string;
begin
  Result := nil;
  fpLastStatus := 0;

  ClearLastResponse;

  LUrl := BuildUrl(APath);
  LBodyToSend := TJSONObject(ABody.Clone);
  try
    if Assigned(fpLogger) then
    begin
      fpLogger.LogText('POST ' + LUrl);
      fpLogger.LogJSON('request', LBodyToSend);
    end;

    LResponse := TRequest.New
      .BaseURL(LUrl)
      .Timeout(fpTimeout)
      .ContentType('application/json')
      .Accept('*/*')
      .UserAgent(fpUserAgent)
      .AddBody(LBodyToSend, False)
      .Post;

    fpLastStatus := LResponse.StatusCode;
    fpLastResponseText := LResponse.Content;

    fpLastAppVersion := LResponse.Headers.Values['X-CALC-APP-VERSION'];
    fpLastDbVersion := LResponse.Headers.Values['X-CALC-DB-VERSION'];

    if Assigned(fpLogger) then
    begin
      fpLogger.LogText(Format('HTTP %d', [fpLastStatus]));
      fpLogger.LogText(fpLastResponseText);
    end;

    if (fpLastStatus div 100) <> 2 then
    begin
      LDetail := '';
      try
        LErr := ParseJsonText(fpLastResponseText);
        if (LErr <> nil) and (LErr.JSONType = jtObject) then
          LDetail := TJSONObject(LErr).Get('detail', '');
      except
        // mantém LDetail vazio
      end;

      if LDetail <> '' then
        raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [fpLastStatus, LDetail])
      else
        raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [fpLastStatus, fpLastResponseText]);
    end;

    if Trim(fpLastResponseText) <> '' then
    begin
      fpLastResponseJSON := ParseJsonText(fpLastResponseText);
      if Assigned(fpLogger) then
        fpLogger.LogJSON('response', fpLastResponseJSON);
      Result := fpLastResponseJSON.Clone;
    end;
  finally
    LBodyToSend.Free;
  end;
end;

function TCalculadoraRTCCalculadora.DoGetJSON(const ARelPathAndQuery: string): TJSONData;
var
  LResponse: IResponse;
  LUrl: string;
  LStatus: Integer;
begin
  Result := nil;

  ClearLastResponse;

  LUrl := BuildUrl('calculadora/dados-abertos/' + ARelPathAndQuery);

  if Assigned(fpLogger) then
    fpLogger.LogText('GET ' + LUrl);

  LResponse := TRequest.New
    .BaseURL(LUrl)
    .Timeout(fpTimeout)
    .Accept('application/json')
    .UserAgent(fpUserAgent)
    .Get;

  LStatus := LResponse.StatusCode;
  fpLastStatus := LStatus;
  fpLastResponseText := LResponse.Content;

  fpLastAppVersion := LResponse.Headers.Values['X-CALC-APP-VERSION'];
  fpLastDbVersion := LResponse.Headers.Values['X-CALC-DB-VERSION'];

  if Assigned(fpLogger) then
  begin
    fpLogger.LogText(Format('HTTP %d', [LStatus]));
    fpLogger.LogText(fpLastResponseText);
  end;

  if (LStatus div 100) <> 2 then
    raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);

  if Trim(fpLastResponseText) = '' then
    Exit(nil);

  fpLastResponseJSON := ParseJsonText(fpLastResponseText);

  if Assigned(fpLogger) then
    fpLogger.LogJSON('response', fpLastResponseJSON);

  Result := fpLastResponseJSON;
end;

{=== Endpoints ===}

function TCalculadoraRTCCalculadora.CalcularRegimeGeralJSON(const AOperacao: IOperacaoInput): TJSONData;
begin
  Result := DoPostJSON('calculadora/regime-geral', AOperacao.ToJSON);
end;

function TCalculadoraRTCCalculadora.CalcularRegimeGeral(const AOperacao: IOperacaoInput): IROC;
begin
  Result := TROC.FromJSON(CalcularRegimeGeralJSON(AOperacao));
end;

function TCalculadoraRTCCalculadora.CalcularISMercadorias(const AInputJson: TJSONObject): TJSONData;
var
  LBody: TJSONObject = nil;
begin
  LBody := TJSONObject(AInputJson.Clone);
  try
    NormalizeISBasePayload(LBody);
    Result := DoPostJSON('calculadora/base-calculo/is-mercadorias', LBody);
  finally
    LBody.Free;
  end;
end;

function TCalculadoraRTCCalculadora.CalcularCibs(const AInputJson: TJSONObject): TJSONData;
var
  LBody: TJSONObject = nil;
begin
  LBody := TJSONObject(AInputJson.Clone);
  try
    NormalizeCibsBasePayload(LBody);
    Result := DoPostJSON('calculadora/base-calculo/cbs-ibs-mercadorias', LBody);
  finally
    LBody.Free;
  end;
end;

function TCalculadoraRTCCalculadora.CalcularPedagioJSON(const AInputJson: TJSONObject): TJSONData;
begin
  Result := DoPostJSON('calculadora/pedagio', AInputJson);
end;

function TCalculadoraRTCCalculadora.CalcularPedagio(const AInputJson: TJSONObject): ITributoPedagioOutput;
begin
  Result := TTributoPedagioOutput.FromJSON(TJSONObject(CalcularPedagioJSON(AInputJson)));
end;

function TCalculadoraRTCCalculadora.ValidarXml(const ATipo: string; const ASubtipo: string; const AXml: string): Boolean;
var
  LResponse: IResponse;
  LUrl: string;
  LStatus: Integer;
  LStr: string;
begin
  ClearLastResponse;

  LUrl := BuildUrl(Format('calculadora/validar-xml?tipo=%s&subtipo=%s',
    [EncodeURLElement(ATipo), EncodeURLElement(ASubtipo)]));

  if Assigned(fpLogger) then
    fpLogger.LogText('POST ' + LUrl);

  LResponse := TRequest.New
    .BaseURL(LUrl)
    .Timeout(fpTimeout)
    .ContentType('application/xml; charset=utf-8')
    .Accept('application/json')
    .UserAgent(fpUserAgent)
    .AddBody(AXml)
    .Post;

  LStatus := LResponse.StatusCode;
  fpLastStatus := LStatus;
  fpLastResponseText := LResponse.Content;

  if Assigned(fpLogger) then
  begin
    fpLogger.LogText(Format('HTTP %d', [LStatus]));
    fpLogger.LogText(fpLastResponseText);
  end;

  if (LStatus div 100) <> 2 then
    raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);

  LStr := Trim(fpLastResponseText);
  Result := SameText(LStr, 'true');
end;

function TCalculadoraRTCCalculadora.GerarXml(const ARocJson: TJSONObject): string;
var
  LResponse: IResponse;
  LUrl: string;
  LStatus: Integer;
  LBodyToSend: TJSONObject = nil;
begin
  ClearLastResponse;

  LUrl := BuildUrl('calculadora/gerar-xml');
  LBodyToSend := TJSONObject(ARocJson.Clone);
  try
    if Assigned(fpLogger) then
    begin
      fpLogger.LogText('POST ' + LUrl);
      fpLogger.LogJSON('request', LBodyToSend);
    end;

    LResponse := TRequest.New
      .BaseURL(LUrl)
      .Timeout(fpTimeout)
      .ContentType('application/json; charset=utf-8')
      .Accept('application/xml')
      .UserAgent(fpUserAgent)
      .AddBody(LBodyToSend, False)
      .Post;

    LStatus := LResponse.StatusCode;
    fpLastStatus := LStatus;

    fpLastResponseText := LResponse.Content;
    fpLastResponseXML := LResponse.Content;

    if Assigned(fpLogger) then
    begin
      fpLogger.LogText(Format('HTTP %d', [LStatus]));
      fpLogger.LogText(fpLastResponseText);
    end;

    if (LStatus div 100) <> 2 then
      raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);

    Result := fpLastResponseXML;
  finally
    LBodyToSend.Free;
  end;
end;

function TCalculadoraRTCCalculadora.ConsultarVersaoJSON: TJSONData;
begin
  Result := DoGetJSON('versao');
end;

function TCalculadoraRTCCalculadora.ConsultarVersao: IVersaoOutput;
begin
  Result := TVersaoOutput.FromJSON(ConsultarVersaoJSON);
end;

function TCalculadoraRTCCalculadora.ConsultarUfsJSON: TJSONData;
begin
  Result := DoGetJSON('ufs');
end;

function TCalculadoraRTCCalculadora.ConsultarUfs: TListaUF;
begin
  Result := ParseListaUF(ConsultarUfsJSON);
end;

function TCalculadoraRTCCalculadora.ConsultarMunicipiosPorSiglaUfJSON(
  const ASiglaUf: string): TJSONData;
begin
  Result := DoGetJSON('ufs/municipios?siglaUf=' + EncodeURLElement(ASiglaUf));
end;

function TCalculadoraRTCCalculadora.ConsultarMunicipiosPorSiglaUf(
  const ASiglaUf: string): TListaMunicipio;
begin
  Result := ParseListaMunicipio(ConsultarMunicipiosPorSiglaUfJSON(ASiglaUf));
end;

function TCalculadoraRTCCalculadora.ConsultarSituacoesTributariasISJSON(
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('situacoes-tributarias/imposto-seletivo?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarSituacoesTributariasIS(
  const ADataISO: string): TListaSituacaoTributaria;
begin
  Result := ParseListaSituacaoTributaria(ConsultarSituacoesTributariasISJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarSituacoesTributariasCbsIbsJSON(
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('situacoes-tributarias/cbs-ibs?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarSituacoesTributariasCbsIbs(
  const ADataISO: string): TListaSituacaoTributaria;
begin
  Result := ParseListaSituacaoTributaria(ConsultarSituacoesTributariasCbsIbsJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarNcmJSON(const ANcm: string;
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('ncm?ncm=%s&data=%s', [EncodeURLElement(ANcm), EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCCalculadora.ConsultarNcm(const ANcm: string;
  const ADataISO: string): INcmOutput;
begin
  Result := TNcmOutput.FromJSON(ConsultarNcmJSON(ANcm, ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarNbsJSON(const ANbs: string;
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('nbs?nbs=%s&data=%s', [EncodeURLElement(ANbs), EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCCalculadora.ConsultarNbs(const ANbs: string;
  const ADataISO: string): INbsOutput;
begin
  Result := TNbsOutput.FromJSON(ConsultarNbsJSON(ANbs, ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarFundamentacoesLegaisJSON(
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('fundamentacoes-legais?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarFundamentacoesLegais(
  const ADataISO: string): TListaFundClass;
begin
  Result := ParseListaFundClass(ConsultarFundamentacoesLegaisJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasPorIdJSON(
  const AId: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('classificacoes-tributarias/%d?data=%s', [AId, EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasPorId(
  const AId: Int64; const ADataISO: string): TListaClassTrib;
begin
   Result := ParseListaClassificacaoTributaria(ConsultarClassificacoesTributariasPorIdJSON(AId, ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasISJSON(
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('classificacoes-tributarias/imposto-seletivo?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasIS(
  const ADataISO: string): TListaClassTrib;
begin
  Result := ParseListaClassificacaoTributaria(ConsultarClassificacoesTributariasISJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasCbsIbsJSON
  (const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('classificacoes-tributarias/cbs-ibs?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarClassificacoesTributariasCbsIbs(
  const ADataISO: string): TListaClassTrib;
begin
  Result := ParseListaClassificacaoTributaria(ConsultarClassificacoesTributariasCbsIbsJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaUniaoJSON(
  const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('aliquota-uniao?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaUniao(
  const ADataISO: string): IAliquotaOutput;
begin
  Result := TAliquotaOutput.FromJSON(ConsultarAliquotaUniaoJSON(ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaUfJSON(
  const ACodigoUf: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('aliquota-uf?codigoUf=%d&data=%s', [ACodigoUf, EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaUf(const ACodigoUf: Int64;
  const ADataISO: string): IAliquotaOutput;
begin
  Result := TAliquotaOutput.FromJSON(ConsultarAliquotaUfJSON(ACodigoUf, ADataISO));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaMunicipioJSON(
  const ACodigoMunicipio: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('aliquota-municipio?codigoMunicipio=%d&data=%s',
    [ACodigoMunicipio, EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCCalculadora.ConsultarAliquotaMunicipio(
  const ACodigoMunicipio: Int64; const ADataISO: string): IAliquotaOutput;
begin
  Result := TAliquotaOutput.FromJSON(ConsultarAliquotaMunicipioJSON(ACodigoMunicipio, ADataISO));
end;

end.

