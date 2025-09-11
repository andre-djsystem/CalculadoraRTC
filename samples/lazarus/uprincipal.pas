unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  fpjson,
  CalculadoraRTC.Calculadora,
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

    edtDataBase: TEdit;
    edtSiglaUF: TEdit;
    edtCodigoUF: TEdit;
    edtCodigoMunicipio: TEdit;
    edtIdClassTrib: TEdit;

    edtNcmQuery: TEdit;
    edtNbsQuery: TEdit;

    MemoXML: TMemo;
    MemoResp: TMemo;
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
    fpCalculadora: ICalculadoraRTC;
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
  fpCalculadora := TCalculadoraRTCCalculadora.New;

  fpLogger := TCalcLogger.Create(@AddLog);

  fpCalculadora.Logger(fpLogger);

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

  edtDataBase.Text := '2026-01-01';
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
  fpCalculadora.BaseUrl(edtBaseUrl.Text)
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

      LResp := fpCalculadora.CalcularRegimeGeralJSON(LOperacaoInput);
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

      LROC := fpCalculadora.CalcularRegimeGeral(LOperacaoInput);
      MemoResp.Lines.Text := LROC.total.tribCalc.IBSCBSTot.vBCIBSCBS.ToString;
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
      LResp := fpCalculadora.CalcularISMercadorias(LJson);
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
      LResp := fpCalculadora.CalcularCibs(LJson);
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

      LResp := fpCalculadora.CalcularPedagioJSON(LPedagioInput.ToJSON);
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
    LOk := fpCalculadora.ValidarXml(edtXMLTipo.Text, edtXMLSubtipo.Text, MemoXML.Text);
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

    LROCJson := fpCalculadora.CalcularRegimeGeralJSON(LInput);
    try
      LXML := fpCalculadora.GerarXml(TJSONObject(LROCJson.Clone));
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
  LVersao: IVersaoOutput;
begin
  ApplyConfig;
  try
    LVersao := fpCalculadora.ConsultarVersao;
    MemoResp.Lines.Clear;
    MemoResp.Lines.Add(LVersao.VersaoApp);
    MemoResp.Lines.Add(LVersao.VersaoDb);
    MemoResp.Lines.Add(LVersao.DataVersaoDb);
    MemoResp.Lines.Add(LVersao.Ambiente);
    MemoResp.Lines.Add(LVersao.DescricaoVersaoDb);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnUFsClick(Sender: TObject);
var
  LListaUF: TListaUF;
begin
  ApplyConfig;
  try
    LListaUF := fpCalculadora.ConsultarUfs;
    MemoResp.Clear;
    MemoResp.Lines.Add(LListaUF.Count.ToString);
    MemoResp.Lines.Add(LListaUF.Items[0].Sigla);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnMunicipiosUFClick(Sender: TObject);
var
  LListaMun: TListaMunicipio;
begin
  ApplyConfig;
  try
    LListaMun := fpCalculadora.ConsultarMunicipiosPorSiglaUf(edtSiglaUF.Text);
    MemoResp.Lines.Clear;
    MemoResp.Lines.Add(Format('Total de Municípios: %d',[LListaMun.Count]));
    MemoResp.Lines.Add(LListaMun.Items[0].Nome);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnSTISClick(Sender: TObject);
var
  LListaSitTribIS: TListaSituacaoTributaria;
begin
  ApplyConfig;
  try
    LListaSitTribIS := fpCalculadora.ConsultarSituacoesTributariasIS(edtDataBase.Text);
    MemoResp.Lines.Clear;
    MemoResp.Lines.Add(Format('Total de Situações Tributárias IS: %d',[LListaSitTribIS.Count]));
    if LListaSitTribIS.Count > 0 then
      MemoResp.Lines.Add(LListaSitTribIS.Items[0].Descricao);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnSTCBSIBSClick(Sender: TObject);
var
  LListaSitTribCBSIBS: TListaSituacaoTributaria;
begin
  ApplyConfig;
  try
    LListaSitTribCBSIBS := fpCalculadora.ConsultarSituacoesTributariasCbsIbs(edtDataBase.Text);
    MemoResp.Lines.Clear;
    MemoResp.Lines.Add(Format('Total de Situações Tributárias CBS/IBS: %d',[LListaSitTribCBSIBS.Count]));
    if LListaSitTribCBSIBS.Count > 0 then
      MemoResp.Lines.Add(LListaSitTribCBSIBS.Items[0].Descricao);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnNCMClick(Sender: TObject);
var
  LNCM: INcmOutput;
begin
  ApplyConfig;
  try
    LNCM := fpCalculadora.ConsultarNcm(edtNcmQuery.Text, edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(LNCM.Capitulo);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnNBSClick(Sender: TObject);
var
  LNbs: INbsOutput;
begin
  ApplyConfig;
  try
    LNbs := fpCalculadora.ConsultarNbs(edtNbsQuery.Text, edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(LNbs.Item);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnFundamentacoesClick(Sender: TObject);
var
  LFundClass: TListaFundClass;
begin
  ApplyConfig;
  try
    LFundClass := fpCalculadora.ConsultarFundamentacoesLegais(edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(LFundClass.Items[0].DescricaoClassificacaoTributaria);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribPorIdClick(Sender: TObject);
var
  LClassTrib: TListaClassTrib;
begin
  ApplyConfig;
  try
    LClassTrib := fpCalculadora.ConsultarClassificacoesTributariasPorId(StrToInt64Safe(edtIdClassTrib.Text), edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(Format('Total de Situações Tributárias por Id: %d',[LClassTrib.Count]));
    if LClassTrib.Count > 0 then
      MemoResp.Lines.Add(LClassTrib.Items[0].DescricaoTratamentoTributario);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribISClick(Sender: TObject);
var
  LClassTribIS: TListaClassTrib;
begin
  ApplyConfig;
  try
    LClassTribIS := fpCalculadora.ConsultarClassificacoesTributariasIS(edtDataBase.Text);
    MemoResp.Clear;
    if LClassTribIS.Count > 0 then
      MemoResp.Lines.Add(LClassTribIS.Items[0].Descricao)
    else
      MemoResp.Lines.Add('Lista Vazia');
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnClassTribCBSIBSClick(Sender: TObject);
var
  LClassTribCBSIBS: TListaClassTrib;
begin
  ApplyConfig;
  try
    LClassTribCBSIBS := fpCalculadora.ConsultarClassificacoesTributariasCbsIbs(edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(LClassTribCBSIBS.Items[0].Descricao);
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqUniaoClick(Sender: TObject);
var
  LAliqUniao: IAliquotaOutput;
begin
  ApplyConfig;
  try
    LAliqUniao := fpCalculadora.ConsultarAliquotaUniao(edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(FloatToStr(LAliqUniao.AliquotaReferencia));
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqUFClick(Sender: TObject);
var
  LAliqUF: IAliquotaOutput;
begin
  ApplyConfig;
  try
    LAliqUF := fpCalculadora.ConsultarAliquotaUf(StrToInt64Safe(edtCodigoUF.Text), edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(FloatToStr(LAliqUF.AliquotaReferencia));
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.btnAliqMunicipioClick(Sender: TObject);
var
  LAliqMun: IAliquotaOutput;
begin
  ApplyConfig;
  try
    LAliqMun := fpCalculadora.ConsultarAliquotaMunicipio(StrToInt64Safe(edtCodigoMunicipio.Text), edtDataBase.Text);
    MemoResp.Clear;
    MemoResp.Lines.Add(FloatToStr(LAliqMun.AliquotaReferencia));
  except
    on E: Exception do LogError(E);
  end;
end;

procedure TFormCalcDemo.AddLog(const S: string);
begin
  MemoLog.Lines.Add(S);
end;

end.

