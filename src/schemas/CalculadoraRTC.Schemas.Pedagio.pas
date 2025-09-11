unit CalculadoraRTC.Schemas.Pedagio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson, jsonparser, fgl,
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Utils.DateTime;

type
  TTrechoPedagioInput = class
  private
    fpNumero: Integer;
    fpCodigoMunicipio: Int64;
    fpUF: string;
    fpExtensao: Double; // em km
  public
    function Numero(const AValue: Integer): TTrechoPedagioInput;
    function CodigoMunicipio(const AValue: Int64): TTrechoPedagioInput;
    function UF(const AValue: string): TTrechoPedagioInput;
    function Extensao(const AKm: Double): TTrechoPedagioInput;

    function ToJSON: TJSONObject;
  end;

  TTrechosPedagioInput = class(specialize TFPGObjectList<TTrechoPedagioInput>)
  end;

  TPedagioInput = class
  private
    fpDataHoraEmissao: string; // ISO-8601 (preferencialmente com TZ)
    fpCodigoMunicipioOrigem: Int64;
    fpUFMunicipioOrigem: string;
    fpCST: string;
    fpBaseCalculo: Double;
    fpCClassTrib: string;
    fpTrechos: TTrechosPedagioInput;
  public
    constructor Create;
    destructor Destroy; override;

    function DataHoraEmissaoISO(const AISO: string): TPedagioInput;
    function DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer = 0): TPedagioInput;
    function CodigoMunicipioOrigem(const AValue: Int64): TPedagioInput;
    function UFMunicipioOrigem(const AValue: string): TPedagioInput;
    function CST(const AValue: string): TPedagioInput;
    function BaseCalculo(const AValue: Double): TPedagioInput;
    function CClassTrib(const AValue: string): TPedagioInput;
    function AddTrecho: TTrechoPedagioInput;

    function ToJSON: TJSONObject;

    property Trechos: TTrechosPedagioInput read fpTrechos;
  end;

  TTributoPedagioOutput = class
  private
    fpAliquota: Double;
    fpAliquotaEfetiva: Double;
    fpTributoCalculado: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): TTributoPedagioOutput;

    property Aliquota: Double read fpAliquota write fpAliquota;
    property AliquotaEfetiva: Double read fpAliquotaEfetiva write fpAliquotaEfetiva;
    property TributoCalculado: Double read fpTributoCalculado write fpTributoCalculado;
    property MemoriaCalculo: string read fpMemoriaCalculo write fpMemoriaCalculo;
  end;

  TTributoTotalPedagioOutput = class
  private
    fpAliquotaTotal: Double;
    fpAliquotaEfetivaTotal: Double;
    fpTributoTotal: Double;
  public
    class function FromJSON(AObj: TJSONObject): TTributoTotalPedagioOutput;

    property AliquotaTotal: Double read fpAliquotaTotal write fpAliquotaTotal;
    property AliquotaEfetivaTotal: Double read fpAliquotaEfetivaTotal write fpAliquotaEfetivaTotal;
    property TributoTotal: Double read fpTributoTotal write fpTributoTotal;
  end;

  TTrechoPedagioOutput = class
  private
    fpNumero: Integer;
    fpMunicipio: Int64;
    fpUF: string;
    fpExtensao: Double;

    fpCBS: TTributoPedagioOutput;
    fpIBSEstadual: TTributoPedagioOutput;
    fpIBSMunicipal: TTributoPedagioOutput;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TTrechoPedagioOutput;

    property Numero: Integer read fpNumero write fpNumero;
    property Municipio: Int64 read fpMunicipio write fpMunicipio;
    property UF: string read fpUF write fpUF;
    property Extensao: Double read fpExtensao write fpExtensao;

    property CBS: TTributoPedagioOutput read fpCBS write fpCBS;
    property IBSEstadual: TTributoPedagioOutput read fpIBSEstadual write fpIBSEstadual;
    property IBSMunicipal: TTributoPedagioOutput read fpIBSMunicipal write fpIBSMunicipal;
  end;

  TTrechosPedagioOutput = class(specialize TFPGObjectList<TTrechoPedagioOutput>)
  end;

  TPedagioOutput = class
  private
    fpTrechos: TTrechosPedagioOutput;
    fpCBSTotal: TTributoTotalPedagioOutput;
    fpIBSEstadualTotal: TTributoTotalPedagioOutput;
    fpIBSMunicipalTotal: TTributoTotalPedagioOutput;
  public
    constructor Create;
    destructor Destroy; override;
    class function FromJSON(AJson: TJSONData): TPedagioOutput;

    property Trechos: TTrechosPedagioOutput read fpTrechos;
    property CBSTotal: TTributoTotalPedagioOutput read fpCBSTotal write fpCBSTotal;
    property IBSEstadualTotal: TTributoTotalPedagioOutput read fpIBSEstadualTotal write fpIBSEstadualTotal;
    property IBSMunicipalTotal: TTributoTotalPedagioOutput read fpIBSMunicipalTotal write fpIBSMunicipalTotal;
  end;

implementation

{ TTrechoPedagioInput }

function TTrechoPedagioInput.Numero(const AValue: Integer): TTrechoPedagioInput;
begin
  fpNumero := AValue;
  Result := Self;
end;

function TTrechoPedagioInput.CodigoMunicipio(const AValue: Int64): TTrechoPedagioInput;
begin
  fpCodigoMunicipio := AValue;
  Result := Self;
end;

function TTrechoPedagioInput.UF(const AValue: string): TTrechoPedagioInput;
begin
  fpUF := AValue;
  Result := Self;
end;

function TTrechoPedagioInput.Extensao(const AKm: Double): TTrechoPedagioInput;
begin
  fpExtensao := AKm;
  Result := Self;
end;

function TTrechoPedagioInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('numero', fpNumero);
  Result.Add('municipio', fpCodigoMunicipio);
  Result.Add('uf', fpUF);
  Result.Add('extensao', JFloat(fpExtensao));
end;

{ TPedagioInput }

constructor TPedagioInput.Create;
begin
  inherited Create;
  fpTrechos := TTrechosPedagioInput.Create(True);
end;

destructor TPedagioInput.Destroy;
begin
  fpTrechos.Free;
  inherited Destroy;
end;

function TPedagioInput.DataHoraEmissaoISO(const AISO: string): TPedagioInput;
begin
  fpDataHoraEmissao := AISO;
  Result := Self;
end;

function TPedagioInput.DataHoraEmissao(const AWhen: TDateTime; const ATZOffsetMinutes: Integer): TPedagioInput;
begin
  fpDataHoraEmissao := DateTimeToISO8601TZ(AWhen, ATZOffsetMinutes);
  Result := Self;
end;

function TPedagioInput.CodigoMunicipioOrigem(const AValue: Int64): TPedagioInput;
begin
  fpCodigoMunicipioOrigem := AValue;
  Result := Self;
end;

function TPedagioInput.UFMunicipioOrigem(const AValue: string): TPedagioInput;
begin
  fpUFMunicipioOrigem := AValue;
  Result := Self;
end;

function TPedagioInput.CST(const AValue: string): TPedagioInput;
begin
  fpCST := AValue;
  Result := Self;
end;

function TPedagioInput.BaseCalculo(const AValue: Double): TPedagioInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TPedagioInput.CClassTrib(const AValue: string): TPedagioInput;
begin
  fpCClassTrib := AValue;
  Result := Self;
end;

function TPedagioInput.AddTrecho: TTrechoPedagioInput;
begin
  Result := TTrechoPedagioInput.Create;
  fpTrechos.Add(Result);
end;

function TPedagioInput.ToJSON: TJSONObject;
var
  LArr: TJSONArray;
  LIt: TTrechoPedagioInput;
begin
  Result := TJSONObject.Create;
  Result.Add('dataHoraEmissao', fpDataHoraEmissao);
  Result.Add('codigoMunicipioOrigem', fpCodigoMunicipioOrigem);
  Result.Add('ufMunicipioOrigem', fpUFMunicipioOrigem);
  Result.Add('cst', fpCST);
  Result.Add('baseCalculo', JFloat(fpBaseCalculo));
  Result.Add('cClassTrib', fpCClassTrib);

  LArr := TJSONArray.Create;
  for LIt in fpTrechos do
    LArr.Add(LIt.ToJSON);
  Result.Add('trechos', LArr);
end;

{ TTributoPedagioOutput }

class function TTributoPedagioOutput.FromJSON(AObj: TJSONObject): TTributoPedagioOutput;
begin
  Result := TTributoPedagioOutput.Create;
  if AObj = nil then
    Exit;

  Result.fpAliquota := JSONGetFloat(AObj, 'aliquota');
  Result.fpAliquotaEfetiva := JSONGetFloat(AObj, 'aliquotaEfetiva');
  Result.fpTributoCalculado := JSONGetFloat(AObj, 'tributoCalculado');
  Result.fpMemoriaCalculo := AObj.Get('memoriaCalculo', '');
end;

{ TTributoTotalPedagioOutput }

class function TTributoTotalPedagioOutput.FromJSON(AObj: TJSONObject): TTributoTotalPedagioOutput;
begin
  Result := TTributoTotalPedagioOutput.Create;
  if AObj = nil then
    Exit;

  Result.fpAliquotaTotal := JSONGetFloat(AObj, 'aliquotaTotal');
  Result.fpAliquotaEfetivaTotal := JSONGetFloat(AObj, 'aliquotaEfetivaTotal');
  Result.fpTributoTotal := JSONGetFloat(AObj, 'tributoTotal');
end;

{ TTrechoPedagioOutput }

destructor TTrechoPedagioOutput.Destroy;
begin
  fpCBS.Free;
  fpIBSEstadual.Free;
  fpIBSMunicipal.Free;
  inherited Destroy;
end;

class function TTrechoPedagioOutput.FromJSON(AObj: TJSONObject): TTrechoPedagioOutput;
var
  LObj: TJSONObject;
begin
  Result := TTrechoPedagioOutput.Create;
  if AObj = nil then
    Exit;

  Result.fpNumero := JSONGetInt(AObj, 'numero');
  Result.fpMunicipio := JSONGetInt64(AObj, 'municipio');
  Result.fpUF := AObj.Get('uf', '');
  Result.fpExtensao := JSONGetFloat(AObj, 'extensao');

  LObj := AObj.Find('cbs') as TJSONObject;
  if LObj <> nil then
    Result.fpCBS := TTributoPedagioOutput.FromJSON(LObj);

  LObj := AObj.Find('ibsEstadual') as TJSONObject;
  if LObj <> nil then
    Result.fpIBSEstadual := TTributoPedagioOutput.FromJSON(LObj);

  LObj := AObj.Find('ibsMunicipal') as TJSONObject;
  if LObj <> nil then
    Result.fpIBSMunicipal := TTributoPedagioOutput.FromJSON(LObj);
end;

{ TPedagioOutput }

constructor TPedagioOutput.Create;
begin
  inherited Create;
  fpTrechos := TTrechosPedagioOutput.Create(True);
end;

destructor TPedagioOutput.Destroy;
begin
  fpTrechos.Free;
  fpCBSTotal.Free;
  fpIBSEstadualTotal.Free;
  fpIBSMunicipalTotal.Free;
  inherited Destroy;
end;

class function TPedagioOutput.FromJSON(AJson: TJSONData): TPedagioOutput;
var
  LObj: TJSONObject;
  LArr: TJSONArray;
  I: Integer;
  LT: TJSONObject;
  LItem: TTrechoPedagioOutput;
begin
  Result := TPedagioOutput.Create;
  if (AJson = nil) or (AJson.JSONType <> jtObject) then
    Exit;

  LObj := TJSONObject(AJson);

  LArr := LObj.Find('trechos') as TJSONArray;
  if LArr <> nil then
  begin
    for I := 0 to LArr.Count - 1 do
    begin
      LT := LArr.Objects[I];
      LItem := TTrechoPedagioOutput.FromJSON(LT);
      Result.fpTrechos.Add(LItem);
    end;
  end;

  if LObj.Find('cbsTotal') <> nil then
    Result.fpCBSTotal := TTributoTotalPedagioOutput.FromJSON(LObj.Objects['cbsTotal']);

  if LObj.Find('ibsEstadualTotal') <> nil then
    Result.fpIBSEstadualTotal := TTributoTotalPedagioOutput.FromJSON(LObj.Objects['ibsEstadualTotal']);

  if LObj.Find('ibsMunicipalTotal') <> nil then
    Result.fpIBSMunicipalTotal := TTributoTotalPedagioOutput.FromJSON(LObj.Objects['ibsMunicipalTotal']);
end;

end.
