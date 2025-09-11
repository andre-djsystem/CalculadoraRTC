unit CalculadoraRTC.Schemas.Pedagio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fgl,
  fpjson, jsonparser,
  CalculadoraRTC.Utils.JSON;

type
  ITrechoPedagioInput = interface
    ['{0C6A9A8E-7E2D-4939-A9A5-5D0B7D39D4C2}']
    function Numero(const AValue: Integer): ITrechoPedagioInput;
    function Municipio(const ACodigoIBGE: Int64): ITrechoPedagioInput;
    function UF(const AUF: string): ITrechoPedagioInput;
    function Extensao(const AKm: Double): ITrechoPedagioInput;
    function ToJSON: TJSONObject;
  end;

  IPedagioInput = interface
    ['{E431BF62-83D2-4AC7-8D52-7C6D0D9E6B0E}']
    function DataHoraEmissaoISO(const AISO: string): IPedagioInput;
    function CodigoMunicipioOrigem(const ACod: Int64): IPedagioInput;
    function UFMunicipioOrigem(const AUF: string): IPedagioInput;
    function CST(const ACst: string): IPedagioInput;
    function BaseCalculo(const AValue: Double): IPedagioInput;
    function CClassTrib(const ACode: string): IPedagioInput;
    function AddTrecho: ITrechoPedagioInput;
    function ToJSON: TJSONObject;
  end;

  ITributoPedagioOutput = interface
    ['{2E4E6079-4A3D-4B8A-8C37-0E8A4E4B46A0}']
    function Aliquota: Double;
    function AliquotaEfetiva: Double;
    function TributoCalculado: Double;
    function MemoriaCalculo: string;
  end;

  ITributoTotalPedagioOutput = interface
    ['{3B1B7C65-7D40-4F92-9C8D-7C7C2B8D8E11}']
    function BaseCalculo: Double;
    function ValorApurado: Double;
    function ValorDevido: Double;
    function ValorTributo: Double;
    function TotalMontanteDesonerado: Double;
  end;

  ITrechoPedagioOutput = interface
    ['{D9B7D498-4C2B-4B12-8B79-9D292C6B5E64}']
    function Numero: Integer;
    function Municipio: Int64;
    function UF: string;
    function BaseCalculo: Double;
    function ExtensaoTrecho: Double;
    function ExtensaoTotal: Double;
    function CBS: ITributoPedagioOutput;
    function IBSEstadual: ITributoPedagioOutput;
    function IBSMunicipal: ITributoPedagioOutput;
  end;

  ITotalPedagioOutput = interface
    ['{F93A730E-73B6-4A84-9E5D-6C9B7F9D99E0}']
    function CbsTotal: ITributoTotalPedagioOutput;
    function IbsEstadualTotal: ITributoTotalPedagioOutput;
    function IbsMunicipalTotal: ITributoTotalPedagioOutput;
  end;

  IPedagioOutput = interface
    ['{2C0F5C0B-7D88-4E8D-8B77-9C9E6E2B4B5A}']
    function DataHoraEmissao: string;
    function MunicipioOrigem: Int64;
    function UFMunicipioOrigem: string;
    function CST: string;
    function BaseCalculo: Double;
    function ExtensaoTotal: Double;
    function TrechosCount: Integer;
    function TrechoByIndex(const Idx: Integer): ITrechoPedagioOutput;
    function Total: ITotalPedagioOutput;
    function CClassTrib: string;
  end;

  { Inputs }

  TTrechoPedagioInput = class(TInterfacedObject, ITrechoPedagioInput)
  private
    fpNumero: Integer;
    fpMunicipio: Int64;
    fpUF: string;
    fpExtensao: Double;
  public
    class function New: ITrechoPedagioInput; static;

    { ITrechoPedagioInput }
    function Numero(const AValue: Integer): ITrechoPedagioInput;
    function Municipio(const ACodigoIBGE: Int64): ITrechoPedagioInput;
    function UF(const AUF: string): ITrechoPedagioInput;
    function Extensao(const AKm: Double): ITrechoPedagioInput;
    function ToJSON: TJSONObject;
  end;

  TPergTrechos = specialize TFPGList<ITrechoPedagioInput>;

  TPedagioInput = class(TInterfacedObject, IPedagioInput)
  private
    fpDataHoraEmissao: string;
    fpCodigoMunicipioOrigem: Int64;
    fpUFMunicipioOrigem: string;
    fpCST: string;
    fpBaseCalculo: Double;
    fpCClassTrib: string;
    fpTrechos: TPergTrechos;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IPedagioInput; static;

    { IPedagioInput }
    function DataHoraEmissaoISO(const AISO: string): IPedagioInput;
    function CodigoMunicipioOrigem(const ACod: Int64): IPedagioInput;
    function UFMunicipioOrigem(const AUF: string): IPedagioInput;
    function CST(const ACst: string): IPedagioInput;
    function BaseCalculo(const AValue: Double): IPedagioInput;
    function CClassTrib(const ACode: string): IPedagioInput;
    function AddTrecho: ITrechoPedagioInput;
    function ToJSON: TJSONObject;
  end;

  { Outputs }

  TTributoPedagioOutput = class(TInterfacedObject, ITributoPedagioOutput)
  private
    fpAliquota: Double;
    fpAliquotaEfetiva: Double;
    fpTributoCalculado: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): ITributoPedagioOutput; static;

    { ITributoPedagioOutput }
    function Aliquota: Double;
    function AliquotaEfetiva: Double;
    function TributoCalculado: Double;
    function MemoriaCalculo: string;
  end;

  TTributoTotalPedagioOutput = class(TInterfacedObject, ITributoTotalPedagioOutput)
  private
    fpBaseCalculo: Double;
    fpValorApurado: Double;
    fpValorDevido: Double;
    fpValorTributo: Double;
    fpTotalMontanteDesonerado: Double;
  public
    class function FromJSON(AObj: TJSONObject): ITributoTotalPedagioOutput; static;

    { ITributoTotalPedagioOutput }
    function BaseCalculo: Double;
    function ValorApurado: Double;
    function ValorDevido: Double;
    function ValorTributo: Double;
    function TotalMontanteDesonerado: Double;
  end;

  TTrechoPedagioOutput = class(TInterfacedObject, ITrechoPedagioOutput)
  private
    fpNumero: Integer;
    fpMunicipio: Int64;
    fpUF: string;
    fpBaseCalculo: Double;
    fpExtensaoTrecho: Double;
    fpExtensaoTotal: Double;
    fpCBS: ITributoPedagioOutput;
    fpIBSEstadual: ITributoPedagioOutput;
    fpIBSMunicipal: ITributoPedagioOutput;
  public
    class function FromJSON(AObj: TJSONObject): ITrechoPedagioOutput; static;

    { ITrechoPedagioOutput }
    function Numero: Integer;
    function Municipio: Int64;
    function UF: string;
    function BaseCalculo: Double;
    function ExtensaoTrecho: Double;
    function ExtensaoTotal: Double;
    function CBS: ITributoPedagioOutput;
    function IBSEstadual: ITributoPedagioOutput;
    function IBSMunicipal: ITributoPedagioOutput;
  end;

  TTotalPedagioOutput = class(TInterfacedObject, ITotalPedagioOutput)
  private
    fpCbsTotal: ITributoTotalPedagioOutput;
    fpIbsEstadualTotal: ITributoTotalPedagioOutput;
    fpIbsMunicipalTotal: ITributoTotalPedagioOutput;
  public
    class function FromJSON(AObj: TJSONObject): ITotalPedagioOutput; static;

    { ITotalPedagioOutput }
    function CbsTotal: ITributoTotalPedagioOutput;
    function IbsEstadualTotal: ITributoTotalPedagioOutput;
    function IbsMunicipalTotal: ITributoTotalPedagioOutput;
  end;

  TPedagioOutput = class(TInterfacedObject, IPedagioOutput)
  private
    fpDataHoraEmissao: string;
    fpMunicipioOrigem: Int64;
    fpUFMunicipioOrigem: string;
    fpCST: string;
    fpBaseCalculo: Double;
    fpExtensaoTotal: Double;
    fpTrechos: array of ITrechoPedagioOutput;
    fpTotal: ITotalPedagioOutput;
    fpCClassTrib: string;
  public
    class function FromJSON(AJson: TJSONData): IPedagioOutput; static;

    { IPedagioOutput }
    function DataHoraEmissao: string;
    function MunicipioOrigem: Int64;
    function UFMunicipioOrigem: string;
    function CST: string;
    function BaseCalculo: Double;
    function ExtensaoTotal: Double;
    function TrechosCount: Integer;
    function TrechoByIndex(const Idx: Integer): ITrechoPedagioOutput;
    function Total: ITotalPedagioOutput;
    function CClassTrib: string;
  end;

implementation

class function TTrechoPedagioInput.New: ITrechoPedagioInput;
begin
  Result := TTrechoPedagioInput.Create;
end;

function TTrechoPedagioInput.Numero(const AValue: Integer): ITrechoPedagioInput;
begin
  fpNumero := AValue;
  Result := Self;
end;

function TTrechoPedagioInput.Municipio(const ACodigoIBGE: Int64): ITrechoPedagioInput;
begin
  fpMunicipio := ACodigoIBGE;
  Result := Self;
end;

function TTrechoPedagioInput.UF(const AUF: string): ITrechoPedagioInput;
begin
  fpUF := AUF;
  Result := Self;
end;

function TTrechoPedagioInput.Extensao(const AKm: Double): ITrechoPedagioInput;
begin
  fpExtensao := AKm;
  Result := Self;
end;

function TTrechoPedagioInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('numero', fpNumero);
  Result.Add('municipio', fpMunicipio);
  Result.Add('uf', fpUF);
  Result.Add('extensao', JFloat(fpExtensao));
end;

constructor TPedagioInput.Create;
begin
  inherited Create;
  fpTrechos := TPergTrechos.Create;
end;

destructor TPedagioInput.Destroy;
begin
  fpTrechos.Free; // armazena interfaces; sem double-free
  inherited Destroy;
end;

class function TPedagioInput.New: IPedagioInput;
begin
  Result := TPedagioInput.Create;
end;

function TPedagioInput.DataHoraEmissaoISO(const AISO: string): IPedagioInput;
begin
  fpDataHoraEmissao := AISO;
  Result := Self;
end;

function TPedagioInput.CodigoMunicipioOrigem(const ACod: Int64): IPedagioInput;
begin
  fpCodigoMunicipioOrigem := ACod;
  Result := Self;
end;

function TPedagioInput.UFMunicipioOrigem(const AUF: string): IPedagioInput;
begin
  fpUFMunicipioOrigem := AUF;
  Result := Self;
end;

function TPedagioInput.CST(const ACst: string): IPedagioInput;
begin
  fpCST := ACst;
  Result := Self;
end;

function TPedagioInput.BaseCalculo(const AValue: Double): IPedagioInput;
begin
  fpBaseCalculo := AValue;
  Result := Self;
end;

function TPedagioInput.CClassTrib(const ACode: string): IPedagioInput;
begin
  fpCClassTrib := ACode;
  Result := Self;
end;

function TPedagioInput.AddTrecho: ITrechoPedagioInput;
begin
  Result := TTrechoPedagioInput.New;
  fpTrechos.Add(Result);
end;

function TPedagioInput.ToJSON: TJSONObject;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TJSONObject.Create;
  Result.Add('dataHoraEmissao', fpDataHoraEmissao);
  Result.Add('codigoMunicipioOrigem', fpCodigoMunicipioOrigem);
  Result.Add('ufMunicipioOrigem', fpUFMunicipioOrigem);
  Result.Add('cst', fpCST);
  Result.Add('baseCalculo', JFloat(fpBaseCalculo));
  Result.Add('cClassTrib', fpCClassTrib);

  LArr := TJSONArray.Create;
  for I := 0 to fpTrechos.Count - 1 do
    LArr.Add(fpTrechos[I].ToJSON);
  Result.Add('trechos', LArr);
end;

class function TTributoPedagioOutput.FromJSON(AObj: TJSONObject): ITributoPedagioOutput;
var
  L: TTributoPedagioOutput;
begin
  if AObj = nil then Exit(nil);
  L := TTributoPedagioOutput.Create;
  L.fpAliquota := JSONGetFloat(AObj, 'aliquota');
  L.fpAliquotaEfetiva := JSONGetFloat(AObj, 'aliquotaEfetiva');
  L.fpTributoCalculado := JSONGetFloat(AObj, 'tributoCalculado');
  L.fpMemoriaCalculo := JSONGetString(AObj, 'memoriaCalculo','');
  Result := L;
end;

function TTributoPedagioOutput.Aliquota: Double;
begin
  Result := fpAliquota;
end;

function TTributoPedagioOutput.AliquotaEfetiva: Double;
begin
  Result := fpAliquotaEfetiva;
end;

function TTributoPedagioOutput.TributoCalculado: Double;
begin
  Result := fpTributoCalculado;
end;

function TTributoPedagioOutput.MemoriaCalculo: string;
begin
  Result := fpMemoriaCalculo;
end;

class function TTributoTotalPedagioOutput.FromJSON(AObj: TJSONObject): ITributoTotalPedagioOutput;
var
  L: TTributoTotalPedagioOutput;
begin
  if AObj = nil then Exit(nil);
  L := TTributoTotalPedagioOutput.Create;
  L.fpBaseCalculo := JSONGetFloat(AObj, 'baseCalculo');
  L.fpValorApurado := JSONGetFloat(AObj, 'valorApurado');
  L.fpValorDevido := JSONGetFloat(AObj, 'valorDevido');
  L.fpValorTributo := JSONGetFloat(AObj, 'valorTributo');
  L.fpTotalMontanteDesonerado := JSONGetFloat(AObj, 'totalMontanteDesonerado');
  Result := L;
end;

function TTributoTotalPedagioOutput.BaseCalculo: Double;
begin
  Result := fpBaseCalculo;
end;

function TTributoTotalPedagioOutput.ValorApurado: Double;
begin
  Result := fpValorApurado;
end;

function TTributoTotalPedagioOutput.ValorDevido: Double;
begin
  Result := fpValorDevido;
end;

function TTributoTotalPedagioOutput.ValorTributo: Double;
begin
  Result := fpValorTributo;
end;

function TTributoTotalPedagioOutput.TotalMontanteDesonerado: Double;
begin
  Result := fpTotalMontanteDesonerado;
end;

class function TTrechoPedagioOutput.FromJSON(AObj: TJSONObject): ITrechoPedagioOutput;
var
  L: TTrechoPedagioOutput;
  LO: TJSONObject;
begin
  if AObj = nil then Exit(nil);
  L := TTrechoPedagioOutput.Create;
  L.fpNumero := JSONGetInt(AObj, 'numero');
  L.fpMunicipio := JSONGetInt64(AObj, 'municipio');
  L.fpUF := JSONGetString(AObj, 'uf','');
  L.fpBaseCalculo := JSONGetFloat(AObj, 'baseCalculo');
  L.fpExtensaoTrecho := JSONGetFloat(AObj, 'extensaoTrecho');
  L.fpExtensaoTotal := JSONGetFloat(AObj, 'extensaoTotal');

  LO := AObj.Find('cbs') as TJSONObject;
  if LO <> nil then L.fpCBS := TTributoPedagioOutput.FromJSON(LO);

  LO := AObj.Find('ibsEstadual') as TJSONObject;
  if LO <> nil then L.fpIBSEstadual := TTributoPedagioOutput.FromJSON(LO);

  LO := AObj.Find('ibsMunicipal') as TJSONObject;
  if LO <> nil then L.fpIBSMunicipal := TTributoPedagioOutput.FromJSON(LO);

  Result := L;
end;

function TTrechoPedagioOutput.Numero: Integer;
begin
  Result := fpNumero;
end;

function TTrechoPedagioOutput.Municipio: Int64;
begin
  Result := fpMunicipio;
end;

function TTrechoPedagioOutput.UF: string;
begin
  Result := fpUF;
end;

function TTrechoPedagioOutput.BaseCalculo: Double;
begin
  Result := fpBaseCalculo;
end;

function TTrechoPedagioOutput.ExtensaoTrecho: Double;
begin
  Result := fpExtensaoTrecho;
end;

function TTrechoPedagioOutput.ExtensaoTotal: Double;
begin
  Result := fpExtensaoTotal;
end;

function TTrechoPedagioOutput.CBS: ITributoPedagioOutput;
begin
  Result := fpCBS;
end;

function TTrechoPedagioOutput.IBSEstadual: ITributoPedagioOutput;
begin
  Result := fpIBSEstadual;
end;

function TTrechoPedagioOutput.IBSMunicipal: ITributoPedagioOutput;
begin
  Result := fpIBSMunicipal;
end;

class function TTotalPedagioOutput.FromJSON(AObj: TJSONObject): ITotalPedagioOutput;
var
  L: TTotalPedagioOutput;
  LO: TJSONObject;
begin
  if AObj = nil then Exit(nil);
  L := TTotalPedagioOutput.Create;

  LO := AObj.Find('cbsTotal') as TJSONObject;
  if LO <> nil then L.fpCbsTotal := TTributoTotalPedagioOutput.FromJSON(LO);

  LO := AObj.Find('ibsEstadualTotal') as TJSONObject;
  if LO <> nil then L.fpIbsEstadualTotal := TTributoTotalPedagioOutput.FromJSON(LO);

  LO := AObj.Find('ibsMunicipalTotal') as TJSONObject;
  if LO <> nil then L.fpIbsMunicipalTotal := TTributoTotalPedagioOutput.FromJSON(LO);

  Result := L;
end;

function TTotalPedagioOutput.CbsTotal: ITributoTotalPedagioOutput;
begin
  Result := fpCbsTotal;
end;

function TTotalPedagioOutput.IbsEstadualTotal: ITributoTotalPedagioOutput;
begin
  Result := fpIbsEstadualTotal;
end;

function TTotalPedagioOutput.IbsMunicipalTotal: ITributoTotalPedagioOutput;
begin
  Result := fpIbsMunicipalTotal;
end;

class function TPedagioOutput.FromJSON(AJson: TJSONData): IPedagioOutput;
var
  LObj: TJSONObject;
  LArr: TJSONArray;
  I: Integer;
  LT: TJSONObject;
  L: TPedagioOutput;
begin
  if (AJson = nil) or (AJson.JSONType <> jtObject) then Exit(nil);

  L := TPedagioOutput.Create;
  LObj := TJSONObject(AJson);

  L.fpDataHoraEmissao := JSONGetString(LObj, 'dataHoraEmissao','');
  L.fpMunicipioOrigem := JSONGetInt64(LObj, 'municipioOrigem');
  L.fpUFMunicipioOrigem := JSONGetString(LObj, 'ufMunicipioOrigem','');
  L.fpCST := JSONGetString(LObj, 'cst','');
  L.fpBaseCalculo := JSONGetFloat(LObj, 'baseCalculo');
  L.fpExtensaoTotal := JSONGetFloat(LObj, 'extensaoTotal');
  L.fpCClassTrib := JSONGetString(LObj, 'cClassTrib','');

  LArr := LObj.Find('trechos') as TJSONArray;
  if LArr <> nil then
  begin
    SetLength(L.fpTrechos, LArr.Count);
    for I := 0 to LArr.Count - 1 do
    begin
      LT := LArr.Objects[I];
      L.fpTrechos[I] := TTrechoPedagioOutput.FromJSON(LT);
    end;
  end;

  if LObj.Find('total') <> nil then
    L.fpTotal := TTotalPedagioOutput.FromJSON(LObj.Objects['total']);

  Result := L;
end;

function TPedagioOutput.DataHoraEmissao: string;
begin
  Result := fpDataHoraEmissao;
end;

function TPedagioOutput.MunicipioOrigem: Int64;
begin
  Result := fpMunicipioOrigem;
end;

function TPedagioOutput.UFMunicipioOrigem: string;
begin
  Result := fpUFMunicipioOrigem;
end;

function TPedagioOutput.CST: string;
begin
  Result := fpCST;
end;

function TPedagioOutput.BaseCalculo: Double;
begin
  Result := fpBaseCalculo;
end;

function TPedagioOutput.ExtensaoTotal: Double;
begin
  Result := fpExtensaoTotal;
end;

function TPedagioOutput.TrechosCount: Integer;
begin
  Result := Length(fpTrechos);
end;

function TPedagioOutput.TrechoByIndex(const Idx: Integer): ITrechoPedagioOutput;
begin
  if (Idx < 0) or (Idx >= Length(fpTrechos)) then
    Exit(nil);
  Result := fpTrechos[Idx];
end;

function TPedagioOutput.Total: ITotalPedagioOutput;
begin
  Result := fpTotal;
end;

function TPedagioOutput.CClassTrib: string;
begin
  Result := fpCClassTrib;
end;

end.

