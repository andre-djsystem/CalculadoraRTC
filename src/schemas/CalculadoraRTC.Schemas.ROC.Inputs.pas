unit CalculadoraRTC.Schemas.ROC.Inputs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Utils.DateTime;

type
  {===================== Interfaces (Fluent) =====================}

  ITributacaoRegularInput = interface
    ['{A7D7C5D4-7F7E-4B8E-9F84-4A5F8D6F9E10}']
    function CST(const AValue: string): ITributacaoRegularInput;
    function CClassTrib(const AValue: string): ITributacaoRegularInput;
    function ToJSON: TJSONObject;
  end;

  IImpostoSeletivoInput = interface
    ['{9A9BC44D-47E1-4E3D-AB4B-4C2D140A0F21}']
    function CST(const AValue: string): IImpostoSeletivoInput;
    function BaseCalculo(const AValue: Double): IImpostoSeletivoInput;
    function Quantidade(const AValue: Double): IImpostoSeletivoInput;
    function Unidade(const AValue: string): IImpostoSeletivoInput;
    function ImpostoInformado(const AValue: Double): IImpostoSeletivoInput;
    function CClassTrib(const AValue: string): IImpostoSeletivoInput;
    function ToJSON: TJSONObject;
  end;

  IOperacaoInput = interface; // fwd

  IItemOperacaoInput = interface
    ['{B6E6D0D5-7B8F-42E3-8430-6E1B6E1180B1}']
    function Numero(const AValue: Integer): IItemOperacaoInput;
    function NCM(const AValue: string): IItemOperacaoInput;
    function NBS(const AValue: string): IItemOperacaoInput;
    function CST(const AValue: string): IItemOperacaoInput;
    function BaseCalculo(const AValue: Double): IItemOperacaoInput;
    function Quantidade(const AValue: Double): IItemOperacaoInput;
    function Unidade(const AValue: string): IItemOperacaoInput;
    function CClassTrib(const AValue: string): IItemOperacaoInput;

    function ImpostoSeletivo: IImpostoSeletivoInput;        // encadeia
    function TributacaoRegular: ITributacaoRegularInput;     // encadeia
    function &End: IOperacaoInput;                           // volta ao pai

    function ToJSON: TJSONObject;
  end;

  IOperacaoInput = interface
    ['{C1E4D1E9-EB78-4FF3-9B24-3B3C9B2E1152}']
    function Id(const AValue: string): IOperacaoInput;
    function Versao(const AValue: string): IOperacaoInput;
    function DataHoraEmissaoISO(const AISO: string): IOperacaoInput;
    function DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer = 0): IOperacaoInput;
    function Municipio(const AValue: Int64): IOperacaoInput;
    function UF(const AValue: string): IOperacaoInput;

    function AddItem: IItemOperacaoInput;

    function ToJSON: TJSONObject;
  end;

  {===================== Implementações =====================}

  TTributacaoRegularInput = class(TInterfacedObject, ITributacaoRegularInput)
  private
    fpCST: string;
    fpCClassTrib: string;
  public
    class function New: ITributacaoRegularInput; static;

    { ITributacaoRegularInput }
    function CST(const AValue: string): ITributacaoRegularInput;
    function CClassTrib(const AValue: string): ITributacaoRegularInput;
    function ToJSON: TJSONObject;
  end;

  TImpostoSeletivoInput = class(TInterfacedObject, IImpostoSeletivoInput)
  private
    fpCST: string;
    fpBaseCalculo: Double;
    fpQuantidade: Double;
    fpUnidade: string;
    fpImpostoInformado: Double;
    fpCClassTrib: string;
  public
    class function New: IImpostoSeletivoInput; static;

    { IImpostoSeletivoInput }
    function CST(const AValue: string): IImpostoSeletivoInput;
    function BaseCalculo(const AValue: Double): IImpostoSeletivoInput;
    function Quantidade(const AValue: Double): IImpostoSeletivoInput;
    function Unidade(const AValue: string): IImpostoSeletivoInput;
    function ImpostoInformado(const AValue: Double): IImpostoSeletivoInput;
    function CClassTrib(const AValue: string): IImpostoSeletivoInput;
    function ToJSON: TJSONObject;
  end;

  TItemOperacaoInput = class(TInterfacedObject, IItemOperacaoInput)
  private
    fpParent: IOperacaoInput;
    fpNumero: Integer;
    fpNCM: string;
    fpNBS: string;
    fpCST: string;
    fpBaseCalculo: Double;
    fpQuantidade: Double;
    fpUnidade: string;
    fpImpostoSeletivo: IImpostoSeletivoInput;
    fpTributacaoRegular: ITributacaoRegularInput;
    fpCClassTrib: string;
  public
    constructor Create(const AParent: IOperacaoInput);
    class function New(const AParent: IOperacaoInput): IItemOperacaoInput; static;

    { IItemOperacaoInput }
    function Numero(const AValue: Integer): IItemOperacaoInput;
    function NCM(const AValue: string): IItemOperacaoInput;
    function NBS(const AValue: string): IItemOperacaoInput;
    function CST(const AValue: string): IItemOperacaoInput;
    function BaseCalculo(const AValue: Double): IItemOperacaoInput;
    function Quantidade(const AValue: Double): IItemOperacaoInput;
    function Unidade(const AValue: string): IItemOperacaoInput;
    function CClassTrib(const AValue: string): IItemOperacaoInput;

    function ImpostoSeletivo: IImpostoSeletivoInput;
    function TributacaoRegular: ITributacaoRegularInput;
    function &End: IOperacaoInput;

    function ToJSON: TJSONObject;
  end;

  TOperacaoInput = class(TInterfacedObject, IOperacaoInput)
  private
    fpId: string;
    fpVersao: string;
    fpDataHoraEmissao: string;
    fpMunicipio: Int64;
    fpUF: string;
    fpItens: array of IItemOperacaoInput;
  public
    class function New: IOperacaoInput; static;

    { IOperacaoInput }
    function Id(const AValue: string): IOperacaoInput;
    function Versao(const AValue: string): IOperacaoInput;
    function DataHoraEmissaoISO(const AISO: string): IOperacaoInput;
    function DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer = 0): IOperacaoInput;
    function Municipio(const AValue: Int64): IOperacaoInput;
    function UF(const AValue: string): IOperacaoInput;

    function AddItem: IItemOperacaoInput;

    function ToJSON: TJSONObject;
  end;

implementation

{===================== TTributacaoRegularInput =====================}

class function TTributacaoRegularInput.New: ITributacaoRegularInput;
begin
  Result := TTributacaoRegularInput.Create;
end;

function TTributacaoRegularInput.CST(const AValue: string): ITributacaoRegularInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TTributacaoRegularInput.CClassTrib(const AValue: string): ITributacaoRegularInput;
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

{===================== TImpostoSeletivoInput =====================}

class function TImpostoSeletivoInput.New: IImpostoSeletivoInput;
begin
  Result := TImpostoSeletivoInput.Create;
end;

function TImpostoSeletivoInput.CST(const AValue: string): IImpostoSeletivoInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.BaseCalculo(const AValue: Double): IImpostoSeletivoInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.Quantidade(const AValue: Double): IImpostoSeletivoInput;
begin
  fpQuantidade := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.Unidade(const AValue: string): IImpostoSeletivoInput;
begin
  fpUnidade := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.ImpostoInformado(const AValue: Double): IImpostoSeletivoInput;
begin
  fpImpostoInformado := AValue;
  Result := Self;
end;

function TImpostoSeletivoInput.CClassTrib(const AValue: string): IImpostoSeletivoInput;
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

{===================== TItemOperacaoInput =====================}

constructor TItemOperacaoInput.Create(const AParent: IOperacaoInput);
begin
  inherited Create;
  fpParent := AParent;
end;

class function TItemOperacaoInput.New(const AParent: IOperacaoInput): IItemOperacaoInput;
begin
  Result := TItemOperacaoInput.Create(AParent);
end;

function TItemOperacaoInput.Numero(const AValue: Integer): IItemOperacaoInput;
begin
  fpNumero := AValue;
  Result := Self;
end;

function TItemOperacaoInput.NCM(const AValue: string): IItemOperacaoInput;
begin
  fpNCM := AValue;
  fpNBS := '';
  Result := Self;
end;

function TItemOperacaoInput.NBS(const AValue: string): IItemOperacaoInput;
begin
  fpNBS := AValue;
  fpNCM := '';
  Result := Self;
end;

function TItemOperacaoInput.CST(const AValue: string): IItemOperacaoInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TItemOperacaoInput.BaseCalculo(const AValue: Double): IItemOperacaoInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TItemOperacaoInput.Quantidade(const AValue: Double): IItemOperacaoInput;
begin
  fpQuantidade := AValue;
  Result := Self;
end;

function TItemOperacaoInput.Unidade(const AValue: string): IItemOperacaoInput;
begin
  fpUnidade := AValue;
  Result := Self;
end;

function TItemOperacaoInput.CClassTrib(const AValue: string): IItemOperacaoInput;
begin
  fpCClassTrib := AValue;
  Result := Self;
end;

function TItemOperacaoInput.ImpostoSeletivo: IImpostoSeletivoInput;
begin
  if fpImpostoSeletivo = nil then
    fpImpostoSeletivo := TImpostoSeletivoInput.New;
  Result := fpImpostoSeletivo;
end;

function TItemOperacaoInput.TributacaoRegular: ITributacaoRegularInput;
begin
  if fpTributacaoRegular = nil then
    fpTributacaoRegular := TTributacaoRegularInput.New;
  Result := fpTributacaoRegular;
end;

function TItemOperacaoInput.&End: IOperacaoInput;
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

{===================== TOperacaoInput =====================}

class function TOperacaoInput.New: IOperacaoInput;
begin
  Result := TOperacaoInput.Create;
end;

function TOperacaoInput.Id(const AValue: string): IOperacaoInput;
begin
  fpId := AValue;
  Result := Self;
end;

function TOperacaoInput.Versao(const AValue: string): IOperacaoInput;
begin
  fpVersao := AValue;
  Result := Self;
end;

function TOperacaoInput.DataHoraEmissaoISO(const AISO: string): IOperacaoInput;
begin
  fpDataHoraEmissao := AISO;
  Result := Self;
end;

function TOperacaoInput.DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer): IOperacaoInput;
begin
  fpDataHoraEmissao := DateTimeToISO8601TZ(AWhen, ATZOffsetMinutes);
  Result := Self;
end;

function TOperacaoInput.Municipio(const AValue: Int64): IOperacaoInput;
begin
  fpMunicipio := AValue;
  Result := Self;
end;

function TOperacaoInput.UF(const AValue: string): IOperacaoInput;
begin
  fpUF := AValue;
  Result := Self;
end;

function TOperacaoInput.AddItem: IItemOperacaoInput;
var
  L: IItemOperacaoInput;
  N: Integer;
begin
  L := TItemOperacaoInput.New(Self);
  N := Length(fpItens);
  SetLength(fpItens, N + 1);
  fpItens[N] := L;
  Result := L;
end;

function TOperacaoInput.ToJSON: TJSONObject;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TJSONObject.Create;
  Result.Add('id', fpId);
  Result.Add('versao', fpVersao);
  Result.Add('dataHoraEmissao', fpDataHoraEmissao);
  Result.Add('municipio', fpMunicipio);
  Result.Add('uf', fpUF);

  LArr := TJSONArray.Create;
  for I := 0 to High(fpItens) do
    LArr.Add(fpItens[I].ToJSON);
  Result.Add('itens', LArr);
end;

end.

