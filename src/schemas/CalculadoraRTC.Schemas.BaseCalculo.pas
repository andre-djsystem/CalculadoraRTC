unit CalculadoraRTC.Schemas.BaseCalculo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson, jsonparser,
  CalculadoraRTC.Utils.JSON;

type
  TBaseCalculoISMercadoriasInput = class
  private
    fpValorIntegralCobrado: Double;
    fpAjusteValorOperacao: Double;
    fpJuros: Double;
    fpMultas: Double;
    fpAcrescimos: Double;
    fpEncargos: Double;
    fpDescontosCondicionais: Double;
    fpFretePorDentro: Double;
    fpOutrosTributos: Double;
    fpDemaisImportancias: Double;
    fpICMS: Double;
    fpISS: Double;
    fpPIS: Double;
    fpCOFINS: Double;
    fpBonificacao: Double;
    fpDevolucaoVendas: Double;
  public
    function ValorIntegralCobrado(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function AjusteValorOperacao(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function Juros(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function Multas(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function Acrescimos(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function Encargos(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function DescontosCondicionais(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function FretePorDentro(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function OutrosTributos(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function DemaisImportancias(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function ICMS(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function ISS(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function PIS(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function COFINS(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function Bonificacao(const AValue: Double): TBaseCalculoISMercadoriasInput;
    function DevolucaoVendas(const AValue: Double): TBaseCalculoISMercadoriasInput;

    function ToJSON: TJSONObject;
  end;

  TBaseCalculoCibsInput = class
  private
    fpValorFornecimento: Double;
    fpAjusteValorOperacao: Double;
    fpJuros: Double;
    fpMultas: Double;
    fpAcrescimos: Double;
    fpEncargos: Double;
    fpDescontosCondicionais: Double;
    fpFretePorDentro: Double;
    fpOutrosTributos: Double;
    fpImpostoSeletivo: Double;
    fpDemaisImportancias: Double;
    fpICMS: Double;
    fpISS: Double;
    fpPIS: Double;
    fpCOFINS: Double;
  public
    function ValorFornecimento(const AValue: Double): TBaseCalculoCibsInput;
    function AjusteValorOperacao(const AValue: Double): TBaseCalculoCibsInput;
    function Juros(const AValue: Double): TBaseCalculoCibsInput;
    function Multas(const AValue: Double): TBaseCalculoCibsInput;
    function Acrescimos(const AValue: Double): TBaseCalculoCibsInput;
    function Encargos(const AValue: Double): TBaseCalculoCibsInput;
    function DescontosCondicionais(const AValue: Double): TBaseCalculoCibsInput;
    function FretePorDentro(const AValue: Double): TBaseCalculoCibsInput;
    function OutrosTributos(const AValue: Double): TBaseCalculoCibsInput;
    function ImpostoSeletivo(const AValue: Double): TBaseCalculoCibsInput;
    function DemaisImportancias(const AValue: Double): TBaseCalculoCibsInput;
    function ICMS(const AValue: Double): TBaseCalculoCibsInput;
    function ISS(const AValue: Double): TBaseCalculoCibsInput;
    function PIS(const AValue: Double): TBaseCalculoCibsInput;
    function COFINS(const AValue: Double): TBaseCalculoCibsInput;

    function ToJSON: TJSONObject;
  end;

  TBaseCalculoISMercadoriasModel = class
  private
    fpBaseCalculo: Double;
  public
    class function FromJSON(AJson: TJSONData): TBaseCalculoISMercadoriasModel;
    property BaseCalculo: Double read fpBaseCalculo write fpBaseCalculo;
  end;

implementation

{ TBaseCalculoISMercadoriasInput }

function TBaseCalculoISMercadoriasInput.ValorIntegralCobrado(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpValorIntegralCobrado := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.AjusteValorOperacao(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpAjusteValorOperacao := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Juros(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpJuros := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Multas(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpMultas := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Acrescimos(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpAcrescimos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Encargos(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpEncargos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DescontosCondicionais(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpDescontosCondicionais := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.FretePorDentro(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpFretePorDentro := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.OutrosTributos(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpOutrosTributos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DemaisImportancias(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpDemaisImportancias := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.ICMS(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpICMS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.ISS(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpISS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.PIS(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpPIS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.COFINS(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpCOFINS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Bonificacao(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpBonificacao := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DevolucaoVendas(
  const AValue: Double): TBaseCalculoISMercadoriasInput;
begin
  fpDevolucaoVendas := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('valorIntegralCobrado', JFloat(fpValorIntegralCobrado));
  Result.Add('ajusteValorOperacao', JFloat(fpAjusteValorOperacao));
  Result.Add('juros', JFloat(fpJuros));
  Result.Add('multas', JFloat(fpMultas));
  Result.Add('acrescimos', JFloat(fpAcrescimos));
  Result.Add('encargos', JFloat(fpEncargos));
  Result.Add('descontosCondicionais', JFloat(fpDescontosCondicionais));
  Result.Add('fretePorDentro', JFloat(fpFretePorDentro));
  Result.Add('outrosTributos', JFloat(fpOutrosTributos));
  Result.Add('demaisImportancias', JFloat(fpDemaisImportancias));
  Result.Add('icms', JFloat(fpICMS));
  Result.Add('iss', JFloat(fpISS));
  Result.Add('pis', JFloat(fpPIS));
  Result.Add('cofins', JFloat(fpCOFINS));
  Result.Add('bonificacao', JFloat(fpBonificacao));
  Result.Add('devolucaoVendas', JFloat(fpDevolucaoVendas));
end;

{ TBaseCalculoCibsInput }

function TBaseCalculoCibsInput.ValorFornecimento(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpValorFornecimento := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.AjusteValorOperacao(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpAjusteValorOperacao := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Juros(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpJuros := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Multas(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpMultas := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Acrescimos(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpAcrescimos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Encargos(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpEncargos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.DescontosCondicionais(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpDescontosCondicionais := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.FretePorDentro(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpFretePorDentro := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.OutrosTributos(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpOutrosTributos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ImpostoSeletivo(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpImpostoSeletivo := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.DemaisImportancias(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpDemaisImportancias := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ICMS(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpICMS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ISS(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpISS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.PIS(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpPIS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.COFINS(
  const AValue: Double): TBaseCalculoCibsInput;
begin
  fpCOFINS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('valorFornecimento', JFloat(fpValorFornecimento));
  Result.Add('ajusteValorOperacao', JFloat(fpAjusteValorOperacao));
  Result.Add('juros', JFloat(fpJuros));
  Result.Add('multas', JFloat(fpMultas));
  Result.Add('acrescimos', JFloat(fpAcrescimos));
  Result.Add('encargos', JFloat(fpEncargos));
  Result.Add('descontosCondicionais', JFloat(fpDescontosCondicionais));
  Result.Add('fretePorDentro', JFloat(fpFretePorDentro));
  Result.Add('outrosTributos', JFloat(fpOutrosTributos));
  Result.Add('impostoSeletivo', JFloat(fpImpostoSeletivo));
  Result.Add('demaisImportancias', JFloat(fpDemaisImportancias));
  Result.Add('icms', JFloat(fpICMS));
  Result.Add('iss', JFloat(fpISS));
  Result.Add('pis', JFloat(fpPIS));
  Result.Add('cofins', JFloat(fpCOFINS));
end;

{ TBaseCalculoISMercadoriasModel }

class function TBaseCalculoISMercadoriasModel.FromJSON(
  AJson: TJSONData): TBaseCalculoISMercadoriasModel;
var
  LObj: TJSONObject;
begin
  Result := TBaseCalculoISMercadoriasModel.Create;
  if (AJson = nil) or (AJson.JSONType <> jtObject) then
    Exit;

  LObj := TJSONObject(AJson);
  Result.fpBaseCalculo := JSONGetFloat(LObj, 'baseCalculo');
end;

end.
