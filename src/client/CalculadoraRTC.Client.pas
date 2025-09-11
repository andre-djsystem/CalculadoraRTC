unit CalculadoraRTC.Client;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson, jsonparser,
  RESTRequest4D,
  FPHTTPClient, // EncodeURLElement
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Utils.Payload,
  CalculadoraRTC.Utils.Logging,
  CalculadoraRTC.Utils.Net,
  CalculadoraRTC.Schemas.ROC.Core,
  CalculadoraRTC.Schemas.ROC.Inputs,
  CalculadoraRTC.Schemas.BaseCalculo,
  CalculadoraRTC.Schemas.Pedagio,
  CalculadoraRTC.Schemas.DadosAbertos;

type
  ECalculadoraRTC = class(Exception);

  { TCalculadoraRTCClient }

  TCalculadoraRTCClient = class
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

    function DoPostJSON(const APath: string; const ABody: TJSONObject; out AStatus: Integer): TJSONData;
    function DoGetJSON(const ARelPathAndQuery: string): TJSONData;

  public
    class function New: TCalculadoraRTCClient; static;
    destructor Destroy; override;

    function BaseUrl(const AValue: string): TCalculadoraRTCClient;
    function Timeout(const AMS: Integer): TCalculadoraRTCClient;
    function UserAgent(const AValue: string): TCalculadoraRTCClient;
    function Logger(const ALogger: ICalcLogger): TCalculadoraRTCClient;

    function CalcularRegimeGeralJSON(const AOperacao: TOperacaoInput): TJSONData;
    function CalcularRegimeGeral(const AOperacao: TOperacaoInput): TROC;

    function CalcularISMercadorias(const AInputJson: TJSONObject): TJSONData;
    function CalcularCibs(const AInputJson: TJSONObject): TJSONData;

    function CalcularPedagio(const AInputJson: TJSONObject): TJSONData;

    function ValidarXml(const ATipo: string; const ASubtipo: string; const AXml: string): Boolean;
    function GerarXml(const ARocJson: TJSONObject): string;

    function ConsultarVersao: TJSONData;
    function ConsultarUfs: TJSONData;
    function ConsultarMunicipiosPorSiglaUf(const ASiglaUf: string): TJSONData;
    function ConsultarSituacoesTributariasIS(const ADataISO: string): TJSONData;
    function ConsultarSituacoesTributariasCbsIbs(const ADataISO: string): TJSONData;
    function ConsultarNcm(const ANcm: string; const ADataISO: string): TJSONData;
    function ConsultarNbs(const ANbs: string; const ADataISO: string): TJSONData;
    function ConsultarFundamentacoesLegais(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasPorId(const AId: Int64; const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasIS(const ADataISO: string): TJSONData;
    function ConsultarClassificacoesTributariasCbsIbs(const ADataISO: string): TJSONData;
    function ConsultarAliquotaUniao(const ADataISO: string): TJSONData;
    function ConsultarAliquotaUf(const ACodigoUf: Int64; const ADataISO: string): TJSONData;
    function ConsultarAliquotaMunicipio(const ACodigoMunicipio: Int64; const ADataISO: string): TJSONData;

    property LastAppVersion: string read fpLastAppVersion;
    property LastDbVersion: string read fpLastDbVersion;
    property LastStatus: Integer read fpLastStatus;

    property LastResponseText: string read fpLastResponseText;
    property LastResponseJSON: TJSONData read fpLastResponseJSON;
    property LastResponseXML: string read fpLastResponseXML;
  end;

implementation

{ TCalculadoraRTCClient }

class function TCalculadoraRTCClient.New: TCalculadoraRTCClient;
begin
  Result := TCalculadoraRTCClient.Create;
  Result.fpBaseUrl := 'https://piloto-cbs.tributos.gov.br/servico/calculadora-consumo/api';
  Result.fpTimeout := 30000;
  Result.fpUserAgent := 'CalculadoraRTC/Lazarus-Client 1.0';
end;

destructor TCalculadoraRTCClient.Destroy;
begin
  if Assigned(fpLastResponseJSON) then
  begin
    fpLastResponseJSON.Free;
  end;
  inherited Destroy;
end;

function TCalculadoraRTCClient.BaseUrl(const AValue: string): TCalculadoraRTCClient;
begin
  fpBaseUrl := AValue;
  if (fpBaseUrl <> '') and (fpBaseUrl[Length(fpBaseUrl)] = '/') then
  begin
    Delete(fpBaseUrl, Length(fpBaseUrl), 1);
  end;
  Result := Self;
end;

function TCalculadoraRTCClient.Timeout(const AMS: Integer): TCalculadoraRTCClient;
begin
  fpTimeout := AMS;
  Result := Self;
end;

function TCalculadoraRTCClient.UserAgent(const AValue: string): TCalculadoraRTCClient;
begin
  fpUserAgent := AValue;
  Result := Self;
end;

function TCalculadoraRTCClient.Logger(const ALogger: ICalcLogger): TCalculadoraRTCClient;
begin
  fpLogger := ALogger;
  Result := Self;
end;

function TCalculadoraRTCClient.BuildUrl(const APath: string): string;
begin
  if (Length(APath) > 0) and (APath[1] = '/') then
  begin
    Result := fpBaseUrl + APath;
  end
  else
  begin
    Result := fpBaseUrl + '/' + APath;
  end;
end;

procedure TCalculadoraRTCClient.ClearLastResponse;
begin
  fpLastResponseText := '';
  fpLastResponseXML := '';
  fpLastStatus := 0;

  if Assigned(fpLastResponseJSON) then
  begin
    FreeAndNil(fpLastResponseJSON);
  end;
end;

function TCalculadoraRTCClient.ParseJsonText(const AText: string): TJSONData;
begin
  // Usa GetJSONExt para substituir TJSONFloatNumber -> TJSONExtFloatNumber
  // e garantir saída sem notação científica no FormatJSON.
  Result := GetJSONExt(AText, True);
end;

function TCalculadoraRTCClient.DoPostJSON(const APath: string; const ABody: TJSONObject; out AStatus: Integer): TJSONData;
var
  LResponse: IResponse;
  LUrl: string;
  LBodyToSend: TJSONObject;
  LErr: TJSONData;
  LDetail: string;
begin
  Result := nil;
  AStatus := 0;

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

    AStatus := LResponse.StatusCode;
    fpLastStatus := AStatus;
    fpLastResponseText := LResponse.Content;

    fpLastAppVersion := LResponse.Headers.Values['X-CALC-APP-VERSION'];
    fpLastDbVersion := LResponse.Headers.Values['X-CALC-DB-VERSION'];

    if Assigned(fpLogger) then
    begin
      fpLogger.LogText(Format('HTTP %d', [AStatus]));
      fpLogger.LogText(fpLastResponseText);
    end;

    if (AStatus div 100) <> 2 then
    begin
      LDetail := '';
      try
        LErr := ParseJsonText(fpLastResponseText);
        if (LErr <> nil) and (LErr.JSONType = jtObject) then
        begin
          LDetail := TJSONObject(LErr).Get('detail', '');
        end;
      except
        // mantém LDetail vazio
      end;

      if LDetail <> '' then
      begin
        raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [AStatus, LDetail]);
      end
      else
      begin
        raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [AStatus, fpLastResponseText]);
      end;
    end;

    if Trim(fpLastResponseText) <> '' then
    begin
      fpLastResponseJSON := ParseJsonText(fpLastResponseText);
      if Assigned(fpLogger) then
      begin
        fpLogger.LogJSON('response', fpLastResponseJSON);
      end;
      Result := fpLastResponseJSON.Clone;
    end;
  finally
    LBodyToSend.Free;
  end;
end;

function TCalculadoraRTCClient.DoGetJSON(const ARelPathAndQuery: string): TJSONData;
var
  LResponse: IResponse;
  LUrl: string;
  LStatus: Integer;
begin
  Result := nil;

  ClearLastResponse;

  LUrl := BuildUrl('calculadora/dados-abertos/' + ARelPathAndQuery);

  if Assigned(fpLogger) then
  begin
    fpLogger.LogText('GET ' + LUrl);
  end;

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
  begin
    raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);
  end;

  if Trim(fpLastResponseText) = '' then
  begin
    Exit(nil);
  end;

  fpLastResponseJSON := ParseJsonText(fpLastResponseText);

  if Assigned(fpLogger) then
  begin
    fpLogger.LogJSON('response', fpLastResponseJSON);
  end;

  Result := fpLastResponseJSON.Clone;
end;

{=== Endpoints ===}

function TCalculadoraRTCClient.CalcularRegimeGeralJSON(const AOperacao: TOperacaoInput): TJSONData;
var
  LStatus: Integer;
begin
  Result := DoPostJSON('calculadora/regime-geral', AOperacao.ToJSON, LStatus);
end;

function TCalculadoraRTCClient.CalcularRegimeGeral(const AOperacao: TOperacaoInput): TROC;
var
  LJson: TJSONData;
  LStatus: Integer;
begin
  LJson := DoPostJSON('calculadora/regime-geral', AOperacao.ToJSON, LStatus);
  try
    Result := TROC.FromJSON(fpLastResponseJSON);
  finally
    LJson.Free;
  end;
end;

function TCalculadoraRTCClient.CalcularISMercadorias(const AInputJson: TJSONObject): TJSONData;
var
  LStatus: Integer;
  LBody: TJSONObject;
begin
  LBody := TJSONObject(AInputJson.Clone);
  try
    NormalizeISBasePayload(LBody);
    Result := DoPostJSON('calculadora/base-calculo/is-mercadorias', LBody, LStatus);
  finally
    LBody.Free;
  end;
end;

function TCalculadoraRTCClient.CalcularCibs(const AInputJson: TJSONObject): TJSONData;
var
  LStatus: Integer;
  LBody: TJSONObject;
begin
  LBody := TJSONObject(AInputJson.Clone);
  try
    NormalizeCibsBasePayload(LBody);
    Result := DoPostJSON('calculadora/base-calculo/cbs-ibs-mercadorias', LBody, LStatus);
  finally
    LBody.Free;
  end;
end;

function TCalculadoraRTCClient.CalcularPedagio(const AInputJson: TJSONObject): TJSONData;
var
  LStatus: Integer;
begin
  Result := DoPostJSON('calculadora/pedagio', AInputJson, LStatus);
end;

function TCalculadoraRTCClient.ValidarXml(const ATipo: string; const ASubtipo: string; const AXml: string): Boolean;
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
  begin
    fpLogger.LogText('POST ' + LUrl);
  end;

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
  begin
    raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);
  end;

  LStr := Trim(fpLastResponseText);
  Result := SameText(LStr, 'true');
end;

function TCalculadoraRTCClient.GerarXml(const ARocJson: TJSONObject): string;
var
  LResponse: IResponse;
  LUrl: string;
  LStatus: Integer;
  LBodyToSend: TJSONObject;
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
    begin
      raise ECalculadoraRTC.CreateFmt('HTTP %d: %s', [LStatus, fpLastResponseText]);
    end;

    Result := fpLastResponseXML;
  finally
    LBodyToSend.Free;
  end;
end;

{=== Dados Abertos ===}

function TCalculadoraRTCClient.ConsultarVersao: TJSONData;
begin
  Result := DoGetJSON('versao');
end;

function TCalculadoraRTCClient.ConsultarUfs: TJSONData;
begin
  Result := DoGetJSON('ufs');
end;

function TCalculadoraRTCClient.ConsultarMunicipiosPorSiglaUf(const ASiglaUf: string): TJSONData;
begin
  Result := DoGetJSON('ufs/municipios?siglaUf=' + EncodeURLElement(ASiglaUf));
end;

function TCalculadoraRTCClient.ConsultarSituacoesTributariasIS(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('situacoes-tributarias/imposto-seletivo?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarSituacoesTributariasCbsIbs(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('situacoes-tributarias/cbs-ibs?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarNcm(const ANcm: string; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('ncm?ncm=%s&data=%s', [EncodeURLElement(ANcm), EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCClient.ConsultarNbs(const ANbs: string; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('nbs?nbs=%s&data=%s', [EncodeURLElement(ANbs), EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCClient.ConsultarFundamentacoesLegais(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('fundamentacoes-legais?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarClassificacoesTributariasPorId(const AId: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('classificacoes-tributarias/%d?data=%s', [AId, EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCClient.ConsultarClassificacoesTributariasIS(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('classificacoes-tributarias/imposto-seletivo?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarClassificacoesTributariasCbsIbs(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('classificacoes-tributarias/cbs-ibs?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarAliquotaUniao(const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON('aliquota-uniao?data=' + EncodeURLElement(ADataISO));
end;

function TCalculadoraRTCClient.ConsultarAliquotaUf(const ACodigoUf: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('aliquota-uf?codigoUf=%d&data=%s', [ACodigoUf, EncodeURLElement(ADataISO)]));
end;

function TCalculadoraRTCClient.ConsultarAliquotaMunicipio(const ACodigoMunicipio: Int64; const ADataISO: string): TJSONData;
begin
  Result := DoGetJSON(Format('aliquota-municipio?codigoMunicipio=%d&data=%s',
    [ACodigoMunicipio, EncodeURLElement(ADataISO)]));
end;

end.
