unit CalculadoraRTC.Schemas.ROC.Inputs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson, jsonparser,
  fgl,
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Utils.DateTime;

type
  TTributacaoRegularInput = class
  private
    fpCST: string;
    fpCClassTrib: string;
  public
    function CST(const AValue: string): TTributacaoRegularInput;
    function CClassTrib(const AValue: string): TTributacaoRegularInput;

    function ToJSON: TJSONObject;

    property CSTValue: string read fpCST write fpCST;
    property CClassTribValue: string read fpCClassTrib write fpCClassTrib;
  end;

  TImpostoSeletivoInput = class
  private
    fpCST: string;
    fpBaseCalculo: Double;
    fpQuantidade: Double;
    fpUnidade: string;
    fpImpostoInformado: Double;
    fpCClassTrib: string;
  public
    function CST(const AValue: string): TImpostoSeletivoInput;
    function BaseCalculo(const AValue: Double): TImpostoSeletivoInput;
    function Quantidade(const AValue: Double): TImpostoSeletivoInput;
    function Unidade(const AValue: string): TImpostoSeletivoInput;
    function ImpostoInformado(const AValue: Double): TImpostoSeletivoInput;
    function CClassTrib(const AValue: string): TImpostoSeletivoInput;

    function ToJSON: TJSONObject;

    property CSTValue: string read fpCST write fpCST;
    property BaseCalculoValue: Double read fpBaseCalculo write fpBaseCalculo;
    property QuantidadeValue: Double read fpQuantidade write fpQuantidade;
    property UnidadeValue: string read fpUnidade write fpUnidade;
    property ImpostoInformadoValue: Double read fpImpostoInformado write fpImpostoInformado;
    property CClassTribValue: string read fpCClassTrib write fpCClassTrib;
  end;

  TOperacaoInput = class;

  TItemOperacaoInput = class
  private
    fpParent: TOperacaoInput;
    fpNumero: Integer;
    fpNCM: string;
    fpNBS: string;
    fpCST: string;
    fpBaseCalculo: Double;
    fpQuantidade: Double;
    fpUnidade: string;
    fpImpostoSeletivo: TImpostoSeletivoInput;
    fpTributacaoRegular: TTributacaoRegularInput;
    fpCClassTrib: string; // required
  public
    constructor Create(AParent: TOperacaoInput);
    destructor Destroy; override;

    function Numero(const AValue: Integer): TItemOperacaoInput;
    function NCM(const AValue: string): TItemOperacaoInput;
    function NBS(const AValue: string): TItemOperacaoInput;
    function CST(const AValue: string): TItemOperacaoInput;
    function BaseCalculo(const AValue: Double): TItemOperacaoInput;
    function Quantidade(const AValue: Double): TItemOperacaoInput;
    function Unidade(const AValue: string): TItemOperacaoInput;
    function CClassTrib(const AValue: string): TItemOperacaoInput;

    function ImpostoSeletivo: TImpostoSeletivoInput;
    function TributacaoRegular: TTributacaoRegularInput;

    function &End: TOperacaoInput;

    function ToJSON: TJSONObject;

    property NumeroValue: Integer read fpNumero write fpNumero;
    property NCMValue: string read fpNCM write fpNCM;
    property NBSValue: string read fpNBS write fpNBS;
    property CSTValue: string read fpCST write fpCST;
    property BaseCalculoValue: Double read fpBaseCalculo write fpBaseCalculo;
    property QuantidadeValue: Double read fpQuantidade write fpQuantidade;
    property UnidadeValue: string read fpUnidade write fpUnidade;
    property CClassTribValue: string read fpCClassTrib write fpCClassTrib;
  end;

  TItensOperacaoInput = class(specialize TFPGObjectList<TItemOperacaoInput>)
  end;

  TOperacaoInput = class
  private
    fpId: string;                 
    fpVersao: string;             
    fpDataHoraEmissao: string;    
    fpMunicipio: Int64;           
    fpUF: string;                 
    fpItens: TItensOperacaoInput; 
  public
    constructor Create;
    destructor Destroy; override;

    function Id(const AValue: string): TOperacaoInput;
    function Versao(const AValue: string): TOperacaoInput;
    function DataHoraEmissaoISO(const AISO: string): TOperacaoInput;
    function DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer = 0): TOperacaoInput;
    function Municipio(const AValue: Int64): TOperacaoInput;
    function UF(const AValue: string): TOperacaoInput;
    function AddItem: TItemOperacaoInput;

    function ToJSON: TJSONObject;

    property Itens: TItensOperacaoInput read fpItens;
    property IdValue: string read fpId write fpId;
    property VersaoValue: string read fpVersao write fpVersao;
    property DataHoraEmissaoValue: string read fpDataHoraEmissao write fpDataHoraEmissao;
    property MunicipioValue: Int64 read fpMunicipio write fpMunicipio;
    property UFValue: string read fpUF write fpUF;
  end;

implementation

{ TTributacaoRegularInput }

function TTributacaoRegularInput.CST(const AValue: string): TTributacaoRegularInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TTributacaoRegularInput.CClassTrib(const AValue: string): TTributacaoRegularInput;
begin
  fpCClassTrib := AValue;
  Result := Self;
end;

function TTributacaoRegularInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('cst', fpCST);
  Result.Add('cClassTrib', fpCClassTrib);
end;

{ TImpostoSeletivoInput }

function TImpostoSeletivoInput.CST(const AValue: string): TImpostoSeletivoInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.BaseCalculo(const AValue: Double): TImpostoSeletivoInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.Quantidade(const AValue: Double): TImpostoSeletivoInput;
begin
  fpQuantidade := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.Unidade(const AValue: string): TImpostoSeletivoInput;
begin
  fpUnidade := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.ImpostoInformado(const AValue: Double): TImpostoSeletivoInput;
begin
  fpImpostoInformado := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.CClassTrib(const AValue: string): TImpostoSeletivoInput;
begin
  fpCClassTrib := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('cst', fpCST);
  Result.Add('baseCalculo', JFloat(fpBaseCalculo));
  Result.Add('quantidade', JFloat(fpQuantidade));
  Result.Add('unidade', fpUnidade);
  Result.Add('impostoInformado', JFloat(fpImpostoInformado));
  Result.Add('cClassTrib', fpCClassTrib);
end;

{ TItemOperacaoInput }

constructor TItemOperacaoInput.Create(AParent: TOperacaoInput);
begin
  inherited Create;
  fpParent := AParent;
end;

destructor TItemOperacaoInput.Destroy;
begin
  fpImpostoSeletivo.Free;
  fpTributacaoRegular.Free;
  inherited Destroy;
end;

function TItemOperacaoInput.Numero(const AValue: Integer): TItemOperacaoInput;
begin
  fpNumero := AValue;
  Result := Self;
end;

function TItemOperacaoInput.NCM(const AValue: string): TItemOperacaoInput;
begin
  fpNCM := AValue;
  fpNBS := '';
  Result := Self;
end;

function TItemOperacaoInput.NBS(const AValue: string): TItemOperacaoInput;
begin
  fpNBS := AValue;
  fpNCM := '';
  Result := Self;
end;

function TItemOperacaoInput.CST(const AValue: string): TItemOperacaoInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TItemOperacaoInput.BaseCalculo(const AValue: Double): TItemOperacaoInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TItemOperacaoInput.Quantidade(const AValue: Double): TItemOperacaoInput;
begin
  fpQuantidade := AValue;
  Result := Self;
end;

function TItemOperacaoInput.Unidade(const AValue: string): TItemOperacaoInput;
begin
  fpUnidade := AValue;
  Result := Self;
end;

function TItemOperacaoInput.CClassTrib(const AValue: string): TItemOperacaoInput;
begin
  fpCClassTrib := AValue;
  Result := Self;
end;

function TItemOperacaoInput.ImpostoSeletivo: TImpostoSeletivoInput;
begin
  if fpImpostoSeletivo = nil then
    fpImpostoSeletivo := TImpostoSeletivoInput.Create;
  Result := fpImpostoSeletivo;
end;

function TItemOperacaoInput.TributacaoRegular: TTributacaoRegularInput;
begin
  if fpTributacaoRegular = nil then
    fpTributacaoRegular := TTributacaoRegularInput.Create;
  Result := fpTributacaoRegular;
end;

function TItemOperacaoInput.&End: TOperacaoInput;
begin
  Result := fpParent;
end;

function TItemOperacaoInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('numero', fpNumero);
  if fpNCM <> '' then
    Result.Add('ncm', fpNCM);
  if fpNBS <> '' then
    Result.Add('nbs', fpNBS);
  Result.Add('cst', fpCST);
  Result.Add('baseCalculo', JFloat(fpBaseCalculo));
  if fpQuantidade <> 0 then
    Result.Add('quantidade', JFloat(fpQuantidade));
  if fpUnidade <> '' then
    Result.Add('unidade', fpUnidade);
  if fpImpostoSeletivo <> nil then
    Result.Add('impostoSeletivo', fpImpostoSeletivo.ToJSON);
  if fpTributacaoRegular <> nil then
    Result.Add('tributacaoRegular', fpTributacaoRegular.ToJSON);
  Result.Add('cClassTrib', fpCClassTrib);
end;

{ TOperacaoInput }

constructor TOperacaoInput.Create;
begin
  inherited Create;
  fpItens := TItensOperacaoInput.Create(True);
end;

destructor TOperacaoInput.Destroy;
begin
  fpItens.Free;
  inherited Destroy;
end;

function TOperacaoInput.Id(const AValue: string): TOperacaoInput;
begin
  fpId := AValue;
  Result := Self;
end;

function TOperacaoInput.Versao(const AValue: string): TOperacaoInput;
begin
  fpVersao := AValue;
  Result := Self;
end;

function TOperacaoInput.DataHoraEmissaoISO(const AISO: string): TOperacaoInput;
begin
  fpDataHoraEmissao := AISO;
  Result := Self;
end;

function TOperacaoInput.DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer): TOperacaoInput;
begin
  fpDataHoraEmissao := DateTimeToISO8601TZ(AWhen, ATZOffsetMinutes);
  Result := Self;
end;

function TOperacaoInput.Municipio(const AValue: Int64): TOperacaoInput;
begin
  fpMunicipio := AValue;
  Result := Self;
end;

function TOperacaoInput.UF(const AValue: string): TOperacaoInput;
begin
  fpUF := AValue;
  Result := Self;
end;

function TOperacaoInput.AddItem: TItemOperacaoInput;
begin
  Result := TItemOperacaoInput.Create(Self);
  fpItens.Add(Result);
end;

function TOperacaoInput.ToJSON: TJSONObject;
var
  LArr: TJSONArray;
  LIt: TItemOperacaoInput;
begin
  Result := TJSONObject.Create;
  Result.Add('id', fpId);
  Result.Add('versao', fpVersao);
  Result.Add('dataHoraEmissao', fpDataHoraEmissao);
  Result.Add('municipio', fpMunicipio);
  Result.Add('uf', fpUF);

  LArr := TJSONArray.Create;
  for LIt in fpItens do
    LArr.Add(LIt.ToJSON);
  Result.Add('itens', LArr);
end;

end.
