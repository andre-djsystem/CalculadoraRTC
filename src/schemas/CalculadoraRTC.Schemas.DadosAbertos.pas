unit CalculadoraRTC.Schemas.DadosAbertos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, fgl,
  CalculadoraRTC.Utils.JSON;

type
  IVersaoOutput = interface
    ['{B0E2B1E8-2B32-4D6B-B7B1-5A0FE8B9B9F5}']
    function VersaoApp: string;
    function VersaoDb: string;
    function DescricaoVersaoDb: string;
    function DataVersaoDb: string;
    function Ambiente: string;
  end;

  TVersaoOutput = class(TInterfacedObject, IVersaoOutput)
  private
    fpVersaoApp: string;
    fpVersaoDb: string;
    fpDescricaoVersaoDb: string;
    fpDataVersaoDb: string;
    fpAmbiente: string;
  public
    class function New: IVersaoOutput; static;
    class function FromJSON(AJson: TJSONData): IVersaoOutput; static;

    function VersaoApp: string;
    function VersaoDb: string;
    function DescricaoVersaoDb: string;
    function DataVersaoDb: string;
    function Ambiente: string;
  end;

  IUFOutput = interface
    ['{A6E8F8E0-5D41-4010-9B77-0B4F7E6F4B64}']
    function Sigla: string;
    function Nome: string;
    function Codigo: Int64;
  end;

  TUFOutput = class(TInterfacedObject, IUFOutput)
  private
    fpSigla: string;
    fpNome: string;
    fpCodigo: Int64;
  public
    class function New: IUFOutput; static;
    class function FromJSON(AJson: TJSONData): IUFOutput; static;

    function Sigla: string;
    function Nome: string;
    function Codigo: Int64;
  end;

  TListaUF = specialize TFPGList<IUFOutput>;

  IMunicipioOutput = interface
    ['{B8C7164E-6A25-4D3B-9D0E-4F0A5B9A9A53}']
    function Codigo: Int64;
    function Nome: string;
  end;

  TMunicipioOutput = class(TInterfacedObject, IMunicipioOutput)
  private
    fpCodigo: Int64;
    fpNome: string;
  public
    class function New: IMunicipioOutput; static;
    class function FromJSON(AJson: TJSONData): IMunicipioOutput; static;

    function Codigo: Int64;
    function Nome: string;
  end;

  TListaMunicipio = specialize TFPGList<IMunicipioOutput>;

  ISituacaoTributariaOutput = interface
    ['{8F7C7D36-6D2B-4FCE-9D0A-7B4D2C3E92A1}']
    function Id: Int64;
    function Codigo: string;
    function Descricao: string;
  end;

  TSituacaoTributariaOutput = class(TInterfacedObject, ISituacaoTributariaOutput)
  private
    fpId: Int64;
    fpCodigo: string;
    fpDescricao: string;
  public
    class function New: ISituacaoTributariaOutput; static;
    class function FromJSON(AJson: TJSONData): ISituacaoTributariaOutput; static;

    function Id: Int64;
    function Codigo: string;
    function Descricao: string;
  end;

  TListaSituacaoTributaria = specialize TFPGList<ISituacaoTributariaOutput>;

  INcmOutput = interface
    ['{A1E9A5D8-9D2C-4F1F-AE24-7A4E5E7B2B2E}']
    function TributadoPeloImpostoSeletivo: Boolean;
    function AliquotaAdValorem: Double;
    function AliquotaAdRem: Double;
    function Capitulo: string;
    function Posicao: string;
    function Subposicao: string;
    function Item: string;
    function Subitem: string;
  end;

  TNcmOutput = class(TInterfacedObject, INcmOutput)
  private
    fpTributadoPeloImpostoSeletivo: Boolean;
    fpAliquotaAdValorem: Double;
    fpAliquotaAdRem: Double;
    fpCapitulo: string;
    fpPosicao: string;
    fpSubposicao: string;
    fpItem: string;
    fpSubitem: string;
  public
    class function New: INcmOutput; static;
    class function FromJSON(AJson: TJSONData): INcmOutput; static;

    function TributadoPeloImpostoSeletivo: Boolean;
    function AliquotaAdValorem: Double;
    function AliquotaAdRem: Double;
    function Capitulo: string;
    function Posicao: string;
    function Subposicao: string;
    function Item: string;
    function Subitem: string;
  end;

  TListaNCM = specialize TFPGList<INcmOutput>;

  INbsOutput = interface
    ['{D4B0B8CD-9E3D-4E0D-8E59-66C8D7B2F9C5}']
    function TributadoPeloImpostoSeletivo: Boolean;
    function AliquotaAdValorem: Double;
    function Capitulo: string;
    function Posicao: string;
    function Subposicao1: string;
    function Subposicao2: string;
    function Item: string;
  end;

  TNbsOutput = class(TInterfacedObject, INbsOutput)
  private
    fpTributadoPeloImpostoSeletivo: Boolean;
    fpAliquotaAdValorem: Double;
    fpCapitulo: string;
    fpPosicao: string;
    fpSubposicao1: string;
    fpSubposicao2: string;
    fpItem: string;
  public
    class function New: INbsOutput; static;
    class function FromJSON(AJson: TJSONData): INbsOutput; static;

    function TributadoPeloImpostoSeletivo: Boolean;
    function AliquotaAdValorem: Double;
    function Capitulo: string;
    function Posicao: string;
    function Subposicao1: string;
    function Subposicao2: string;
    function Item: string;
  end;

  TListaNBS = specialize TFPGList<INbsOutput>;

  IFundamentacaoClassificacaoOutput = interface
    ['{0EBA3A72-5E5D-4A51-8D41-9E7D1E68E4F0}']
    function CodigoClassificacaoTributaria: string;
    function DescricaoClassificacaoTributaria: string;
    function CodigoSituacaoTributaria: string;
    function DescricaoSituacaoTributaria: string;
    function ConjuntoTributo: string;
    function Texto: string;
    function TextoCurto: string;
    function ReferenciaNormativa: string;
  end;

  TFundamentacaoClassificacaoOutput = class(TInterfacedObject, IFundamentacaoClassificacaoOutput)
  private
    fpCodigoClassificacaoTributaria: string;
    fpDescricaoClassificacaoTributaria: string;
    fpCodigoSituacaoTributaria: string;
    fpDescricaoSituacaoTributaria: string;
    fpConjuntoTributo: string;
    fpTexto: string;
    fpTextoCurto: string;
    fpReferenciaNormativa: string;
  public
    class function New: IFundamentacaoClassificacaoOutput; static;
    class function FromJSON(AJson: TJSONData): IFundamentacaoClassificacaoOutput; static;

    function CodigoClassificacaoTributaria: string;
    function DescricaoClassificacaoTributaria: string;
    function CodigoSituacaoTributaria: string;
    function DescricaoSituacaoTributaria: string;
    function ConjuntoTributo: string;
    function Texto: string;
    function TextoCurto: string;
    function ReferenciaNormativa: string;
  end;

  TListaFundClass = specialize TFPGList<IFundamentacaoClassificacaoOutput>;

  IClassificacaoTributariaOutput = interface
    ['{C0D2F12E-3CC3-4B73-9C51-2E6D9D5E8AA0}']
    function Codigo: string;
    function Descricao: string;
    function TipoAliquota: string;
    function Nomenclatura: string;
    function DescricaoTratamentoTributario: string;
    function IncompativelComSuspensao: Boolean;
    function ExigeGrupoDesoneracao: Boolean;
    function PossuiPercentualReducao: Boolean;
    function IndicaApropriacaoCreditoAdquirenteCbs: Boolean;
    function IndicaApropriacaoCreditoAdquirenteIbs: Boolean;
    function IndicaCreditoPresumidoFornecedor: Boolean;
    function IndicaCreditoPresumidoAdquirente: Boolean;
    function CreditoOperacaoAntecedente: string;
    function PercentualReducaoCbs: Double;
    function PercentualReducaoIbsUf: Double;
    function PercentualReducaoIbsMun: Double;
  end;

  TClassificacaoTributariaOutput = class(TInterfacedObject, IClassificacaoTributariaOutput)
  private
    fpCodigo: string;
    fpDescricao: string;
    fpTipoAliquota: string;
    fpNomenclatura: string;
    fpDescricaoTratamentoTributario: string;
    fpIncompativelComSuspensao: Boolean;
    fpExigeGrupoDesoneracao: Boolean;
    fpPossuiPercentualReducao: Boolean;
    fpIndicaApropriacaoCreditoAdquirenteCbs: Boolean;
    fpIndicaApropriacaoCreditoAdquirenteIbs: Boolean;
    fpIndicaCreditoPresumidoFornecedor: Boolean;
    fpIndicaCreditoPresumidoAdquirente: Boolean;
    fpCreditoOperacaoAntecedente: string;
    fpPercentualReducaoCbs: Double;
    fpPercentualReducaoIbsUf: Double;
    fpPercentualReducaoIbsMun: Double;
  public
    class function New: IClassificacaoTributariaOutput; static;
    class function FromJSON(AJson: TJSONData): IClassificacaoTributariaOutput; static;

    function Codigo: string;
    function Descricao: string;
    function TipoAliquota: string;
    function Nomenclatura: string;
    function DescricaoTratamentoTributario: string;
    function IncompativelComSuspensao: Boolean;
    function ExigeGrupoDesoneracao: Boolean;
    function PossuiPercentualReducao: Boolean;
    function IndicaApropriacaoCreditoAdquirenteCbs: Boolean;
    function IndicaApropriacaoCreditoAdquirenteIbs: Boolean;
    function IndicaCreditoPresumidoFornecedor: Boolean;
    function IndicaCreditoPresumidoAdquirente: Boolean;
    function CreditoOperacaoAntecedente: string;
    function PercentualReducaoCbs: Double;
    function PercentualReducaoIbsUf: Double;
    function PercentualReducaoIbsMun: Double;
  end;

  TListaClassTrib = specialize TFPGList<IClassificacaoTributariaOutput>;

  IAliquotaOutput = interface
    ['{B1EDFF4C-2F8C-4C2C-8F78-2511AB03B278}']
    function AliquotaReferencia: Double;
    function AliquotaPropria: Double;
    function FormaAplicacao: string; // SUBSTITUICAO | ACRESCIMO | DECRESCIMO
  end;

  TAliquotaOutput = class(TInterfacedObject, IAliquotaOutput)
  private
    fpAliquotaReferencia: Double;
    fpAliquotaPropria: Double;
    fpFormaAplicacao: string;
  public
    class function New: IAliquotaOutput; static;
    class function FromJSON(AJson: TJSONData): IAliquotaOutput; static;

    function AliquotaReferencia: Double;
    function AliquotaPropria: Double;
    function FormaAplicacao: string;
  end;

  TListaAliquota = specialize TFPGList<IAliquotaOutput>;

  function ParseListaUF(AData: TJSONData): TListaUF;
  function ParseListaMunicipio(AData: TJSONData): TListaMunicipio;
  function ParseListaSituacaoTributaria(AData: TJSONData): TListaSituacaoTributaria;
  function ParseListaNCM(AData: TJSONData): TListaNCM;
  function ParseListaNBS(AData: TJSONData): TListaNBS;
  function ParseListaFundClass(AData: TJSONData): TListaFundClass;
  function ParseListaClassificacaoTributaria(AData: TJSONData): TListaClassTrib;
  function ParseListaAliquota(AData: TJSONData): TListaAliquota;

implementation

function ParseListaUF(AData: TJSONData): TListaUF;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaUF.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TUFOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaMunicipio(AData: TJSONData): TListaMunicipio;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaMunicipio.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TMunicipioOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaSituacaoTributaria(AData: TJSONData
  ): TListaSituacaoTributaria;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaSituacaoTributaria.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TSituacaoTributariaOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaNCM(AData: TJSONData): TListaNCM;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaNCM.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TNcmOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaNBS(AData: TJSONData): TListaNBS;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaNBS.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TNbsOutput.FromJSON(LArr.Objects[I]));
end;


function ParseListaFundClass(AData: TJSONData): TListaFundClass;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaFundClass.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TFundamentacaoClassificacaoOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaClassificacaoTributaria(AData: TJSONData): TListaClassTrib;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaClassTrib.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TClassificacaoTributariaOutput.FromJSON(LArr.Objects[I]));
end;

function ParseListaAliquota(AData: TJSONData): TListaAliquota;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TListaAliquota.Create;
  if (AData = nil) or (AData.JSONType <> jtArray) then
    Exit;

  LArr := TJSONArray(AData);
  for I := 0 to LArr.Count - 1 do
    Result.Add(TAliquotaOutput.FromJSON(LArr.Objects[I]));
end;

{ TVersaoOutput }

class function TVersaoOutput.New: IVersaoOutput;
begin
  Result := TVersaoOutput.Create;
end;

class function TVersaoOutput.FromJSON(AJson: TJSONData): IVersaoOutput;
var
  LObj: TJSONObject;
  LOut: TVersaoOutput;
begin
  LOut := TVersaoOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpVersaoApp := JSONGetString(LObj, 'versaoApp', '');
    LOut.fpVersaoDb := JSONGetString(LObj, 'versaoDb', '');
    LOut.fpDescricaoVersaoDb := JSONGetString(LObj, 'descricaoVersaoDb', '');
    LOut.fpDataVersaoDb := JSONGetString(LObj, 'dataVersaoDb', '');
    LOut.fpAmbiente := JSONGetString(LObj, 'ambiente', '');
  end;
  Result := LOut;
end;

function TVersaoOutput.VersaoApp: string;
begin
  Result := fpVersaoApp;
end;

function TVersaoOutput.VersaoDb: string;
begin
  Result := fpVersaoDb;
end;

function TVersaoOutput.DescricaoVersaoDb: string;
begin
  Result := fpDescricaoVersaoDb;
end;

function TVersaoOutput.DataVersaoDb: string;
begin
  Result := fpDataVersaoDb;
end;

function TVersaoOutput.Ambiente: string;
begin
  Result := fpAmbiente;
end;

{ TUFOutput }

class function TUFOutput.New: IUFOutput;
begin
  Result := TUFOutput.Create;
end;

class function TUFOutput.FromJSON(AJson: TJSONData): IUFOutput;
var
  LObj: TJSONObject;
  LOut: TUFOutput;
begin
  LOut := TUFOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpSigla := JSONGetString(LObj, 'sigla', '');
    LOut.fpNome := JSONGetString(LObj, 'nome', '');
    LOut.fpCodigo := JSONGetInt64(LObj, 'codigo');
  end;
  Result := LOut;
end;

function TUFOutput.Sigla: string;
begin
  Result := fpSigla;
end;

function TUFOutput.Nome: string;
begin
  Result := fpNome;
end;

function TUFOutput.Codigo: Int64;
begin
  Result := fpCodigo;
end;

{ TMunicipioOutput }

class function TMunicipioOutput.New: IMunicipioOutput;
begin
  Result := TMunicipioOutput.Create;
end;

class function TMunicipioOutput.FromJSON(AJson: TJSONData): IMunicipioOutput;
var
  LObj: TJSONObject;
  LOut: TMunicipioOutput;
begin
  LOut := TMunicipioOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpCodigo := JSONGetInt64(LObj, 'codigo');
    LOut.fpNome := JSONGetString(LObj, 'nome', '');
  end;
  Result := LOut;
end;

function TMunicipioOutput.Codigo: Int64;
begin
  Result := fpCodigo;
end;

function TMunicipioOutput.Nome: string;
begin
  Result := fpNome;
end;

{ TSituacaoTributariaOutput }

class function TSituacaoTributariaOutput.New: ISituacaoTributariaOutput;
begin
  Result := TSituacaoTributariaOutput.Create;
end;

class function TSituacaoTributariaOutput.FromJSON(AJson: TJSONData): ISituacaoTributariaOutput;
var
  LObj: TJSONObject;
  LOut: TSituacaoTributariaOutput;
begin
  LOut := TSituacaoTributariaOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpId := JSONGetInt64(LObj, 'id');
    LOut.fpCodigo := JSONGetString(LObj, 'codigo', '');
    LOut.fpDescricao := JSONGetString(LObj, 'descricao', '');
  end;
  Result := LOut;
end;

function TSituacaoTributariaOutput.Id: Int64;
begin
  Result := fpId;
end;

function TSituacaoTributariaOutput.Codigo: string;
begin
  Result := fpCodigo;
end;

function TSituacaoTributariaOutput.Descricao: string;
begin
  Result := fpDescricao;
end;

{ TNcmOutput }

class function TNcmOutput.New: INcmOutput;
begin
  Result := TNcmOutput.Create;
end;

class function TNcmOutput.FromJSON(AJson: TJSONData): INcmOutput;
var
  LObj: TJSONObject;
  LOut: TNcmOutput;
begin
  LOut := TNcmOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpTributadoPeloImpostoSeletivo := JSONGetBool(LObj, 'tributadoPeloImpostoSeletivo', False);
    LOut.fpAliquotaAdValorem := JSONGetFloat(LObj, 'aliquotaAdValorem');
    LOut.fpAliquotaAdRem := JSONGetFloat(LObj, 'aliquotaAdRem');
    LOut.fpCapitulo := JSONGetString(LObj, 'capitulo', '');
    LOut.fpPosicao := JSONGetString(LObj, 'posicao', '');
    LOut.fpSubposicao := JSONGetString(LObj, 'subposicao', '');
    LOut.fpItem := JSONGetString(LObj, 'item', '');
    LOut.fpSubitem := JSONGetString(LObj, 'subitem', '');
  end;
  Result := LOut;
end;

function TNcmOutput.TributadoPeloImpostoSeletivo: Boolean;
begin
  Result := fpTributadoPeloImpostoSeletivo;
end;

function TNcmOutput.AliquotaAdValorem: Double;
begin
  Result := fpAliquotaAdValorem;
end;

function TNcmOutput.AliquotaAdRem: Double;
begin
  Result := fpAliquotaAdRem;
end;

function TNcmOutput.Capitulo: string;
begin
  Result := fpCapitulo;
end;

function TNcmOutput.Posicao: string;
begin
  Result := fpPosicao;
end;

function TNcmOutput.Subposicao: string;
begin
  Result := fpSubposicao;
end;

function TNcmOutput.Item: string;
begin
  Result := fpItem;
end;

function TNcmOutput.Subitem: string;
begin
  Result := fpSubitem;
end;

{ TNbsOutput }

class function TNbsOutput.New: INbsOutput;
begin
  Result := TNbsOutput.Create;
end;

class function TNbsOutput.FromJSON(AJson: TJSONData): INbsOutput;
var
  LObj: TJSONObject;
  LOut: TNbsOutput;
begin
  LOut := TNbsOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpTributadoPeloImpostoSeletivo := JSONGetBool(LObj, 'tributadoPeloImpostoSeletivo', False);
    LOut.fpAliquotaAdValorem := JSONGetFloat(LObj, 'aliquotaAdValorem');
    LOut.fpCapitulo := JSONGetString(LObj, 'capitulo', '');
    LOut.fpPosicao := JSONGetString(LObj, 'posicao', '');
    LOut.fpSubposicao1 := JSONGetString(LObj, 'subposicao1', '');
    LOut.fpSubposicao2 := JSONGetString(LObj, 'subposicao2', '');
    LOut.fpItem := JSONGetString(LObj, 'item', '');
  end;
  Result := LOut;
end;

function TNbsOutput.TributadoPeloImpostoSeletivo: Boolean;
begin
  Result := fpTributadoPeloImpostoSeletivo;
end;

function TNbsOutput.AliquotaAdValorem: Double;
begin
  Result := fpAliquotaAdValorem;
end;

function TNbsOutput.Capitulo: string;
begin
  Result := fpCapitulo;
end;

function TNbsOutput.Posicao: string;
begin
  Result := fpPosicao;
end;

function TNbsOutput.Subposicao1: string;
begin
  Result := fpSubposicao1;
end;

function TNbsOutput.Subposicao2: string;
begin
  Result := fpSubposicao2;
end;

function TNbsOutput.Item: string;
begin
  Result := fpItem;
end;

{ TFundamentacaoClassificacaoOutput }

class function TFundamentacaoClassificacaoOutput.New: IFundamentacaoClassificacaoOutput;
begin
  Result := TFundamentacaoClassificacaoOutput.Create;
end;

class function TFundamentacaoClassificacaoOutput.FromJSON(AJson: TJSONData): IFundamentacaoClassificacaoOutput;
var
  LObj: TJSONObject;
  LOut: TFundamentacaoClassificacaoOutput;
begin
  LOut := TFundamentacaoClassificacaoOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpCodigoClassificacaoTributaria := JSONGetString(LObj, 'codigoClassificacaoTributaria', '');
    LOut.fpDescricaoClassificacaoTributaria := JSONGetString(LObj, 'descricaoClassificacaoTributaria', '');
    LOut.fpCodigoSituacaoTributaria := JSONGetString(LObj, 'codigoSituacaoTributaria', '');
    LOut.fpDescricaoSituacaoTributaria := JSONGetString(LObj, 'descricaoSituacaoTributaria', '');
    LOut.fpConjuntoTributo := JSONGetString(LObj, 'conjuntoTributo', '');
    LOut.fpTexto := JSONGetString(LObj, 'texto', '');
    LOut.fpTextoCurto := JSONGetString(LObj, 'textoCurto', '');
    LOut.fpReferenciaNormativa := JSONGetString(LObj, 'referenciaNormativa', '');
  end;
  Result := LOut;
end;

function TFundamentacaoClassificacaoOutput.CodigoClassificacaoTributaria: string;
begin
  Result := fpCodigoClassificacaoTributaria;
end;

function TFundamentacaoClassificacaoOutput.DescricaoClassificacaoTributaria: string;
begin
  Result := fpDescricaoClassificacaoTributaria;
end;

function TFundamentacaoClassificacaoOutput.CodigoSituacaoTributaria: string;
begin
  Result := fpCodigoSituacaoTributaria;
end;

function TFundamentacaoClassificacaoOutput.DescricaoSituacaoTributaria: string;
begin
  Result := fpDescricaoSituacaoTributaria;
end;

function TFundamentacaoClassificacaoOutput.ConjuntoTributo: string;
begin
  Result := fpConjuntoTributo;
end;

function TFundamentacaoClassificacaoOutput.Texto: string;
begin
  Result := fpTexto;
end;

function TFundamentacaoClassificacaoOutput.TextoCurto: string;
begin
  Result := fpTextoCurto;
end;

function TFundamentacaoClassificacaoOutput.ReferenciaNormativa: string;
begin
  Result := fpReferenciaNormativa;
end;

{ TClassificacaoTributariaOutput }

class function TClassificacaoTributariaOutput.New: IClassificacaoTributariaOutput;
begin
  Result := TClassificacaoTributariaOutput.Create;
end;

class function TClassificacaoTributariaOutput.FromJSON(AJson: TJSONData): IClassificacaoTributariaOutput;
var
  LObj: TJSONObject;
  LOut: TClassificacaoTributariaOutput;
begin
  LOut := TClassificacaoTributariaOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpCodigo := JSONGetString(LObj, 'codigo', '');
    LOut.fpDescricao := JSONGetString(LObj, 'descricao', '');
    LOut.fpTipoAliquota := JSONGetString(LObj, 'tipoAliquota', '');
    LOut.fpNomenclatura := JSONGetString(LObj, 'nomenclatura', '');
    LOut.fpDescricaoTratamentoTributario := JSONGetString(LObj, 'descricaoTratamentoTributario', '');
    LOut.fpIncompativelComSuspensao := JSONGetBool(LObj, 'incompativelComSuspensao', False);
    LOut.fpExigeGrupoDesoneracao := JSONGetBool(LObj, 'exigeGrupoDesoneracao', False);
    LOut.fpPossuiPercentualReducao := JSONGetBool(LObj, 'possuiPercentualReducao', False);
    LOut.fpIndicaApropriacaoCreditoAdquirenteCbs := JSONGetBool(LObj, 'indicaApropriacaoCreditoAdquirenteCbs', False);
    LOut.fpIndicaApropriacaoCreditoAdquirenteIbs := JSONGetBool(LObj, 'indicaApropriacaoCreditoAdquirenteIbs', False);
    LOut.fpIndicaCreditoPresumidoFornecedor := JSONGetBool(LObj, 'indicaCreditoPresumidoFornecedor', False);
    LOut.fpIndicaCreditoPresumidoAdquirente := JSONGetBool(LObj, 'indicaCreditoPresumidoAdquirente', False);
    LOut.fpCreditoOperacaoAntecedente := JSONGetString(LObj, 'creditoOperacaoAntecedente', '');
    LOut.fpPercentualReducaoCbs := JSONGetFloat(LObj, 'percentualReducaoCbs');
    LOut.fpPercentualReducaoIbsUf := JSONGetFloat(LObj, 'percentualReducaoIbsUf');
    LOut.fpPercentualReducaoIbsMun := JSONGetFloat(LObj, 'percentualReducaoIbsMun');
  end;
  Result := LOut;
end;

function TClassificacaoTributariaOutput.Codigo: string;
begin
  Result := fpCodigo;
end;

function TClassificacaoTributariaOutput.Descricao: string;
begin
  Result := fpDescricao;
end;

function TClassificacaoTributariaOutput.TipoAliquota: string;
begin
  Result := fpTipoAliquota;
end;

function TClassificacaoTributariaOutput.Nomenclatura: string;
begin
  Result := fpNomenclatura;
end;

function TClassificacaoTributariaOutput.DescricaoTratamentoTributario: string;
begin
  Result := fpDescricaoTratamentoTributario;
end;

function TClassificacaoTributariaOutput.IncompativelComSuspensao: Boolean;
begin
  Result := fpIncompativelComSuspensao;
end;

function TClassificacaoTributariaOutput.ExigeGrupoDesoneracao: Boolean;
begin
  Result := fpExigeGrupoDesoneracao;
end;

function TClassificacaoTributariaOutput.PossuiPercentualReducao: Boolean;
begin
  Result := fpPossuiPercentualReducao;
end;

function TClassificacaoTributariaOutput.IndicaApropriacaoCreditoAdquirenteCbs: Boolean;
begin
  Result := fpIndicaApropriacaoCreditoAdquirenteCbs;
end;

function TClassificacaoTributariaOutput.IndicaApropriacaoCreditoAdquirenteIbs: Boolean;
begin
  Result := fpIndicaApropriacaoCreditoAdquirenteIbs;
end;

function TClassificacaoTributariaOutput.IndicaCreditoPresumidoFornecedor: Boolean;
begin
  Result := fpIndicaCreditoPresumidoFornecedor;
end;

function TClassificacaoTributariaOutput.IndicaCreditoPresumidoAdquirente: Boolean;
begin
  Result := fpIndicaCreditoPresumidoAdquirente;
end;

function TClassificacaoTributariaOutput.CreditoOperacaoAntecedente: string;
begin
  Result := fpCreditoOperacaoAntecedente;
end;

function TClassificacaoTributariaOutput.PercentualReducaoCbs: Double;
begin
  Result := fpPercentualReducaoCbs;
end;

function TClassificacaoTributariaOutput.PercentualReducaoIbsUf: Double;
begin
  Result := fpPercentualReducaoIbsUf;
end;

function TClassificacaoTributariaOutput.PercentualReducaoIbsMun: Double;
begin
  Result := fpPercentualReducaoIbsMun;
end;

{ TAliquotaOutput }

class function TAliquotaOutput.New: IAliquotaOutput;
begin
  Result := TAliquotaOutput.Create;
end;

class function TAliquotaOutput.FromJSON(AJson: TJSONData): IAliquotaOutput;
var
  LObj: TJSONObject;
  LOut: TAliquotaOutput;
begin
  LOut := TAliquotaOutput.Create;
  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);
    LOut.fpAliquotaReferencia := JSONGetFloat(LObj, 'aliquotaReferencia');
    LOut.fpAliquotaPropria := JSONGetFloat(LObj, 'aliquotaPropria');
    LOut.fpFormaAplicacao := JSONGetString(LObj, 'formaAplicacao', '');
  end;
  Result := LOut;
end;

function TAliquotaOutput.AliquotaReferencia: Double;
begin
  Result := fpAliquotaReferencia;
end;

function TAliquotaOutput.AliquotaPropria: Double;
begin
  Result := fpAliquotaPropria;
end;

function TAliquotaOutput.FormaAplicacao: string;
begin
  Result := fpFormaAplicacao;
end;

end.

