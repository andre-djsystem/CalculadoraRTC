unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  fpjson,
  CalculadoraRTC.Client,
  CalculadoraRTC.Config,
  CalculadoraRTC.Utils.Logging,
  CalculadoraRTC.Utils.Payload,
  CalculadoraRTC.Utils.DateTime,
  CalculadoraRTC.Schemas.ROC.Inputs,
  CalculadoraRTC.Schemas.ROC.Core,
  CalculadoraRTC.Schemas.BaseCalculo,
  CalculadoraRTC.Schemas.Pedagio,
  CalculadoraRTC.Schemas.DadosAbertos;

type
  { TFormCalcDemo }

  TFormCalcDemo = class(TForm)
    btnCalcularRegimeGeralJSON: TButton;
    btnCalcularRegimeGeralTipado: TButton;

    btnBaseIS: TButton;
    btnBaseCIBS: TButton;
    btnPedagio: TButton;

    btnValidarXML: TButton;
    btnGerarXML: TButton;

    btnVersao: TButton;
    btnUFs: TButton;
    btnMunicipiosUF: TButton;
    btnSTIS: TButton;
    btnSTCBSIBS: TButton;
    btnNCM: TButton;
    btnNBS: TButton;
    btnFundamentacoes: TButton;
    btnClassTribPorId: TButton;
    btnClassTribIS: TButton;
    btnClassTribCBSIBS: TButton;
    btnAliqUniao: TButton;
    btnAliqUF: TButton;
    btnAliqMunicipio: TButton;

    edtBaseUrl: TEdit;
    edtTimeout: TEdit;
    edtUserAgent: TEdit;

    edtId: TEdit;
    edtVersao: TEdit;
    edtMunicipio: TEdit;
    edtUF: TEdit;
    edtCClassTribItem: TEdit;
    edtCSTItem: TEdit;
    edtNCM: TEdit;
    edtNBS: TEdit;
    edtBaseCalculoItem: TEdit;
    edtQtdItem: TEdit;
    edtUnItem: TEdit;

    edtXMLTipo: TEdit;
    edtXMLSubtipo: TEdit;

    edtDataISO: TEdit;
    edtSiglaUF: TEdit;
    edtCodigoUF: TEdit;
    edtCodigoMunicipio: TEdit;
    edtIdClassTrib: TEdit;

    edtNcmQuery: TEdit;
    edtNbsQuery: TEdit;

    MemoXML: TMemo;
    MemoROC: TMemo;
    MemoLog: TMemo;

    pnlConfig: TGroupBox;
    pnlOperacao: TGroupBox;
    pnlXML: TGroupBox;
    pnlDadosAbertos: TGroupBox;
    pnlLog: TGroupBox;

    Label1: TLabel;   // Base URL
    Label2: TLabel;   // Timeout
    Label3: TLabel;   // User-Agent
    Label4: TLabel;   // Id
    Label5: TLabel;   // Versão
    Label6: TLabel;   // Município
    Label7: TLabel;   // UF
    Label8: TLabel;   // cClassTrib item
    Label9: TLabel;   // CST item
    Label10: TLabel;  // NCM
    Label11: TLabel;  // NBS
    Label12: TLabel;  // BaseCalc item
    Label13: TLabel;  // Qtd
    Label14: TLabel;  // Unidade
    Label15: TLabel;  // Tipo XML
    Label16: TLabel;  // Subtipo XML
    Label17: TLabel;  // Data ISO
    Label18: TLabel;  // Sigla UF
    Label19: TLabel;  // Cod UF
    Label20: TLabel;  // Cod Município
    Label21: TLabel;  // Id ClassTrib
    Label22: TLabel;  // NCM Query
    Label23: TLabel;  // NBS Query

    procedure FormCreate(Sender: TObject);

    // Config
    procedure ApplyConfig;

    // Botões – Cálculo
    procedure btnCalcularRegimeGeralJSONClick(Sender: TObject);
    procedure btnCalcularRegimeGeralTipadoClick(Sender: TObject);
    procedure btnBaseISClick(Sender: TObject);
    procedure btnBaseCIBSClick(Sender: TObject);
    procedure btnPedagioClick(Sender: TObject);

    // XML
    procedure btnValidarXMLClick(Sender: TObject);
    procedure btnGerarXMLClick(Sender: TObject);

    // Dados abertos
    procedure btnVersaoClick(Sender: TObject);
    procedure btnUFsClick(Sender: TObject);
    procedure btnMunicipiosUFClick(Sender: TObject);
    procedure btnSTISClick(Sender: TObject);
    procedure btnSTCBSIBSClick(Sender: TObject);
    procedure btnNCMClick(Sender: TObject);
    procedure btnNBSClick(Sender: TObject);
    procedure btnFundamentacoesClick(Sender: TObject);
    procedure btnClassTribPorIdClick(Sender: TObject);
    procedure btnClassTribISClick(Sender: TObject);
    procedure btnClassTribCBSIBSClick(Sender: TObject);
    procedure btnAliqUniaoClick(Sender: TObject);
    procedure btnAliqUFClick(Sender: TObject);
    procedure btnAliqMunicipioClick(Sender: TObject);

    procedure AddLog(const S: string);

  private
    fpClient: TCalculadoraRTCClient;
    fpLogger: ICalcLogger;

    procedure LogJSON(const ATitle: string; const AData: TJSONData);
    procedure LogText(const ATitle, AText: string);
    procedure LogOk(const ATitle: string);
    procedure LogError(const AE: Exception);

    function StrToDblSafe(const AText: string): Double;
    function StrToInt64Safe(const AText: string): Int64;
  public
  end;

var
  FormCalcDemo: TFormCalcDemo;

implementation

{$R *.lfm}

{ TFormCalcDemo }

procedure TFormCalcDemo.FormCreate(Sender: TObject);
begin
  fpClient := TCalculadoraRTCClient.New;

  fpLogger := TCalcLogger.Create(@AddLog);

  fpClient.Logger(fpLogger);

//  edtBaseUrl.Text := 'https://piloto-cbs.tributos.gov.br/servico/calculadora-consumo/api';
  edtBaseUrl.Text := 'http://[::1]:8080/api';
  edtTimeout.Text := '30000';
  edtUserAgent.Text := 'CalculadoraRTC-Demo/1.0';

  edtId.Text := 'OP-001';
  edtVersao.Text := '1.0.0';
  edtMunicipio.Text := '3554003';
  edtUF.Text := 'SP';

  edtCClassTribItem.Text := '000001';
  edtCSTItem.Text := '000';
  edtNCM.Text := '01012100';
  edtNBS.Text := '';
  edtBaseCalculoItem.Text := '1000.00';
  edtQtdItem.Text := '0';
  edtUnItem.Text := '';

  edtXMLTipo.Text := 'nfe';
  edtXMLSubtipo.Text := 'grupo';

  edtDataISO.Text := '2026-01-01';
  edtSiglaUF.Text := 'SP';
  edtCodigoUF.Text := '35';
  edtCodigoMunicipio.Text := '3554003';
  edtIdClassTrib.Text := '1';
  edtNcmQuery.Text := '01012100';
  edtNbsQuery.Text := '122013000';

  ApplyConfig;
end;

procedure TFormCalcDemo.ApplyConfig;
begin
  fpClient.BaseUrl(edtBaseUrl.Text)
          .Timeout(StrToIntDef(edtTimeout.Text, 30000))
          .UserAgent(edtUserAgent.Text);
end;

procedure TFormCalcDemo.LogJSON(const ATitle: string; const AData: TJSONData);
begin
  fpLogger.LogText('==== ' + ATitle + ' ====');
  if Assigned(AData) then
    fpLogger.LogText(AData.FormatJSON())
  else
    fpLogger.LogText('(sem conteúdo)');
  fpLogger.LogText('');
end;

procedure TFormCalcDemo.LogText(const ATitle, AText: string);
begin
  fpLogger.LogText('==== ' + ATitle + ' ====');
  fpLogger.LogText(AText);
  fpLogger.LogText('');
end;

procedure TFormCalcDemo.LogOk(const ATitle: string);
begin
  fpLogger.LogText(ATitle + ': OK');
end;

procedure TFormCalcDemo.LogError(const AE: Exception);
begin
  fpLogger.LogText(AE.ClassName + ': ' + AE.Message);
end;

function TFormCalcDemo.StrToDblSafe(const AText: string): Double;
var
  LFS: TFormatSettings;
  LStr: string;
begin
  LFS := DefaultFormatSettings;
  LFS.DecimalSeparator := '.';
  LStr := StringReplace(Trim(AText), ',', '.', [rfReplaceAll]);
  Result := StrToFloatDef(LStr, 0.0, LFS);
end;

function TFormCalcDemo.StrToInt64Safe(const AText: string): Int64;
begin
  Result := StrToInt64Def(Trim(AText), 0);
end;

{ ===== Cálculo ===== }

procedure TFormCalcDemo.btnCalcularRegimeGeralJSONClick(Sender: TObject);
var
  LOperacaoInput: IOperacaoInput;
  LItemOperacaoInput: IItemOperacaoInput;
  LResp: TJSONData;
begin
  ApplyConfig;
  try
      LOperacaoInput := TOperacaoInput.New
            .Id(edtId.Text)
            .Versao(edtVersao.Text)
            .DataHoraEmissaoISO(DateTimeToISO8601TZ(Now, 0))
            .Municipio(StrToInt64Safe(edtMunicipio.Text))
            .UF(edtUF.Text);

      LItemOperacaoInput := LOperacaoInput.AddItem;
      LItemOperacaoInput.Numero(1)
           .CClassTrib(edtCClassTribItem.Text)
           .CST(edtCSTItem.Text)
           .BaseCalculo(StrToDblSafe(edtBaseCalculoItem.Text))
           .Quantidade(StrToDblSafe(edtQtdItem.Text))
           .Unidade(edtUnItem.Text);

      if edtNCM.Text <> '' then
        LItemOperacaoInput.NCM(edtNCM.Text)
      else if edtNBS.Text <> '' then
        LItemOperacaoInput.NBS(edtNBS.Text);

      LResp := fpClient.CalcularRegimeGeralJSON(LOperacaoInput);
      try
        LogJSON('Regime Geral (RAW)', LResp);
      finally
        LResp.Free;
      end;

  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnCalcularRegimeGeralTipadoClick(Sender: TObject);
var
  LOperacaoInput: IOperacaoInput;
  LROC: IROC;
begin
  ApplyConfig;
  try

     LOperacaoInput := TOperacaoInput.New
            .Id(edtId.Text)
            .Versao(edtVersao.Text)
            .DataHoraEmissaoISO(DateTimeToISO8601TZ(Now, 0))
            .Municipio(StrToInt64Safe(edtMunicipio.Text))
            .UF(edtUF.Text);

      with LOperacaoInput.AddItem do
      begin
        Numero(1);
        CClassTrib(edtCClassTribItem.Text);
        CST(edtCSTItem.Text);
        BaseCalculo(StrToDblSafe(edtBaseCalculoItem.Text));
        Quantidade(StrToDblSafe(edtQtdItem.Text));
        Unidade(edtUnItem.Text);
        if edtNCM.Text <> '' then
          NCM(edtNCM.Text)
        else if edtNBS.Text <> '' then
          NBS(edtNBS.Text);
      end;

      LROC := fpClient.CalcularRegimeGeral(LOperacaoInput);
      MemoROC.Lines.Text := LROC.total.tribCalc.IBSCBSTot.vBCIBSCBS.ToString;
      LogOk('Regime Geral (Tipado)');
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnBaseISClick(Sender: TObject);
var
  LCalcISBaseInput: ICalcISBaseInput;
  LJson: TJSONObject;
  LResp: TJSONData;
begin
  ApplyConfig;
  try
    LCalcISBaseInput :=
      TBaseCalculoISMercadoriasInput.New
        .ValorIntegralCobrado(StrToDblSafe(edtBaseCalculoItem.Text));

    LJson := LCalcISBaseInput.ToJSON;
    try
      NormalizeISBasePayload(LJson);
      LResp := fpClient.CalcularISMercadorias(LJson);
      try
        LogJSON('Base de Cálculo (IS – RAW)', LResp);
      finally
        LResp.Free;
      end;
    finally
      LJson.Free;
    end;

  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnBaseCIBSClick(Sender: TObject);
var
  LCalcCibsBaseInput: ICalcCibsBaseInput;
  LJson: TJSONObject;
  LResp: TJSONData;
begin
  ApplyConfig;

  LCalcCibsBaseInput :=
    TBaseCalculoCibsInput.New
      .ValorFornecimento(StrToDblSafe(edtBaseCalculoItem.Text));
  try
    LJson := LCalcCibsBaseInput.ToJSON;
    try
      NormalizeCibsBasePayload(LJson);
      LResp := fpClient.CalcularCibs(LJson);
      try
        LogJSON('Base de Cálculo (CBS/IBS – RAW)', LResp);
      finally
        LResp.Free;
      end;
    finally
      LJson.Free;
    end;

except
  on E: Exception do LogError(E);
end;
end;

procedure TFormCalcDemo.btnPedagioClick(Sender: TObject);
var
  LPedagioInput: IPedagioInput;
  LTrechoPedagioInput: ITrechoPedagioInput;
  LResp: TJSONData;
begin
  ApplyConfig;
  try

      LPedagioInput := TPedagioInput.New
         .DataHoraEmissaoISO(DateTimeToISO8601TZ(Now, 0))
         .CodigoMunicipioOrigem(StrToInt64Safe(edtCodigoMunicipio.Text))
         .UFMunicipioOrigem(edtUF.Text)
         .CST(edtCSTItem.Text)
         .BaseCalculo(StrToDblSafe(edtBaseCalculoItem.Text))
         .CClassTrib(edtCClassTribItem.Text);

      LTrechoPedagioInput := LPedagioInput.AddTrecho;
      LTrechoPedagioInput
        .Numero(1)
        .Municipio(StrToInt64Safe(edtCodigoMunicipio.Text))
        .UF(edtUF.Text)
        .Extensao(10.0);

      LResp := fpClient.CalcularPedagioJSON(LPedagioInput.ToJSON);
      try
        LogJSON('Pedágio (RAW)', LResp);
      finally
        LResp.Free;
      end;

  except
    on E: Exception do LogError(E);
  end;
end;

{ ===== XML ===== }

procedure TFormCalcDemo.btnValidarXMLClick(Sender: TObject);
var
  LOk: Boolean;
begin
  ApplyConfig;
  try
    LOk := fpClient.ValidarXml(edtXMLTipo.Text, edtXMLSubtipo.Text, MemoXML.Text);
    LogText('Validar XML', BoolToStr(LOk, True));
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnGerarXMLClick(Sender: TObject);
var
  LROCJson: TJSONData;
  LXML: string;
  LInput: TOperacaoInput;
begin
  ApplyConfig;
  LInput := TOperacaoInput.Create;
  try
    LInput.Id(edtId.Text)
          .Versao(edtVersao.Text)
          .DataHoraEmissaoISO(DateTimeToISO8601TZ(Now, 0))
          .Municipio(StrToInt64Safe(edtMunicipio.Text))
          .UF(edtUF.Text);

    with LInput.AddItem do
    begin
      Numero(1);
      CClassTrib(edtCClassTribItem.Text);
      CST(edtCSTItem.Text);
      BaseCalculo(StrToDblSafe(edtBaseCalculoItem.Text));
      Quantidade(StrToDblSafe(edtQtdItem.Text));
      Unidade(edtUnItem.Text);
      if edtNCM.Text <> '' then
        NCM(edtNCM.Text)
      else if edtNBS.Text <> '' then
        NBS(edtNBS.Text);
    end;

    LROCJson := fpClient.CalcularRegimeGeralJSON(LInput);
    try
      LXML := fpClient.GerarXml(TJSONObject(LROCJson.Clone));
      MemoXML.Lines.Text := LXML;
      LogOk('Gerar XML');
    finally
      LROCJson.Free;
    end;
  finally
    LInput.Free;
  end;
end;

{ ===== Dados abertos ===== }

procedure TFormCalcDemo.btnVersaoClick(Sender: TObject);
var
  D: TJSONData;
  LVersao: IVersaoOutput;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarVersao;
    LVersao := TVersaoOutput.FromJSON(TJSONObject(D));
    try
      LogJSON('Versão', D);
      MemoROC.Lines.Add(LVersao.VersaoApp);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnUFsClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarUfs;
    try
      LogJSON('UFs', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnMunicipiosUFClick(Sender: TObject);
var
  D: TJSONData;
  LListaMun: TListaMunicipio;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarMunicipiosPorSiglaUf(edtSiglaUF.Text);
    try
      LListaMun := ParseListaMunicipio(D);
      LogJSON('Municípios por UF', D);
      MemoROC.Lines.Add(Format('Total de Municípios: %d',[LListaMun.Count]));
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnSTISClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarSituacoesTributariasIS(edtDataISO.Text);
    try
      LogJSON('Situações Tributárias IS', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnSTCBSIBSClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarSituacoesTributariasCbsIbs(edtDataISO.Text);
    try
      LogJSON('Situações Tributárias CBS/IBS', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnNCMClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarNcm(edtNcmQuery.Text, edtDataISO.Text);
    try
      LogJSON('NCM', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnNBSClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarNbs(edtNbsQuery.Text, edtDataISO.Text);
    try
      LogJSON('NBS', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnFundamentacoesClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarFundamentacoesLegais(edtDataISO.Text);
    try
      LogJSON('Fundamentações Legais', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribPorIdClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarClassificacoesTributariasPorId(StrToInt64Safe(edtIdClassTrib.Text), edtDataISO.Text);
    try
      LogJSON('Classificação Tributária por Id', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribISClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarClassificacoesTributariasIS(edtDataISO.Text);
    try
      LogJSON('Classificações Tributárias IS', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribCBSIBSClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarClassificacoesTributariasCbsIbs(edtDataISO.Text);
    try
      LogJSON('Classificações Tributárias CBS/IBS', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqUniaoClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarAliquotaUniao(edtDataISO.Text);
    try
      LogJSON('Alíquota União', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqUFClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarAliquotaUf(StrToInt64Safe(edtCodigoUF.Text), edtDataISO.Text);
    try
      LogJSON('Alíquota UF', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqMunicipioClick(Sender: TObject);
var
  D: TJSONData;
begin
  ApplyConfig;
  try
    D := fpClient.ConsultarAliquotaMunicipio(StrToInt64Safe(edtCodigoMunicipio.Text), edtDataISO.Text);
    try
      LogJSON('Alíquota Município', D);
    finally
      D.Free;
    end;
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.AddLog(const S: string);
begin
  MemoLog.Lines.Add(S);
end;

end.

