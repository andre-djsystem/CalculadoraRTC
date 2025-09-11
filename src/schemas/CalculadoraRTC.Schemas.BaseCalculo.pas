unit CalculadoraRTC.Schemas.BaseCalculo;

{$mode objfpc}{$H+}
{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, fpjson, jsonparser,
  CalculadoraRTC.Utils.JSON;

type
  ICalcISBaseInput = interface
    ['{7F9B5F7D-22B2-4C4B-9C7C-9C8F2F6E9C25}']
    function ValorIntegralCobrado(const AValue: Double): ICalcISBaseInput;
    function AjusteValorOperacao(const AValue: Double): ICalcISBaseInput;
    function Juros(const AValue: Double): ICalcISBaseInput;
    function Multas(const AValue: Double): ICalcISBaseInput;
    function Acrescimos(const AValue: Double): ICalcISBaseInput;
    function Encargos(const AValue: Double): ICalcISBaseInput;
    function DescontosCondicionais(const AValue: Double): ICalcISBaseInput;
    function FretePorDentro(const AValue: Double): ICalcISBaseInput;
    function OutrosTributos(const AValue: Double): ICalcISBaseInput;
    function DemaisImportancias(const AValue: Double): ICalcISBaseInput;
    function ICMS(const AValue: Double): ICalcISBaseInput;
    function ISS(const AValue: Double): ICalcISBaseInput;
    function PIS(const AValue: Double): ICalcISBaseInput;
    function COFINS(const AValue: Double): ICalcISBaseInput;
    function Bonificacao(const AValue: Double): ICalcISBaseInput;
    function DevolucaoVendas(const AValue: Double): ICalcISBaseInput;

    function ToJSON: TJSONObject;
  end;

  ICalcCibsBaseInput = interface
    ['{1C21F0E2-73C7-4C35-A89D-1ABF7E6F0B56}']
    function ValorFornecimento(const AValue: Double): ICalcCibsBaseInput;
    function AjusteValorOperacao(const AValue: Double): ICalcCibsBaseInput;
    function Juros(const AValue: Double): ICalcCibsBaseInput;
    function Multas(const AValue: Double): ICalcCibsBaseInput;
    function Acrescimos(const AValue: Double): ICalcCibsBaseInput;
    function Encargos(const AValue: Double): ICalcCibsBaseInput;
    function DescontosCondicionais(const AValue: Double): ICalcCibsBaseInput;
    function FretePorDentro(const AValue: Double): ICalcCibsBaseInput;
    function OutrosTributos(const AValue: Double): ICalcCibsBaseInput;
    function ImpostoSeletivo(const AValue: Double): ICalcCibsBaseInput;
    function DemaisImportancias(const AValue: Double): ICalcCibsBaseInput;
    function ICMS(const AValue: Double): ICalcCibsBaseInput;
    function ISS(const AValue: Double): ICalcCibsBaseInput;
    function PIS(const AValue: Double): ICalcCibsBaseInput;
    function COFINS(const AValue: Double): ICalcCibsBaseInput;

    function ToJSON: TJSONObject;
  end;

  TBaseCalculoISMercadoriasInput = class(TInterfacedObject, ICalcISBaseInput)
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
    class function New: ICalcISBaseInput;

    function ValorIntegralCobrado(const AValue: Double): ICalcISBaseInput;
    function AjusteValorOperacao(const AValue: Double): ICalcISBaseInput;
    function Juros(const AValue: Double): ICalcISBaseInput;
    function Multas(const AValue: Double): ICalcISBaseInput;
    function Acrescimos(const AValue: Double): ICalcISBaseInput;
    function Encargos(const AValue: Double): ICalcISBaseInput;
    function DescontosCondicionais(const AValue: Double): ICalcISBaseInput;
    function FretePorDentro(const AValue: Double): ICalcISBaseInput;
    function OutrosTributos(const AValue: Double): ICalcISBaseInput;
    function DemaisImportancias(const AValue: Double): ICalcISBaseInput;
    function ICMS(const AValue: Double): ICalcISBaseInput;
    function ISS(const AValue: Double): ICalcISBaseInput;
    function PIS(const AValue: Double): ICalcISBaseInput;
    function COFINS(const AValue: Double): ICalcISBaseInput;
    function Bonificacao(const AValue: Double): ICalcISBaseInput;
    function DevolucaoVendas(const AValue: Double): ICalcISBaseInput;

    function ToJSON: TJSONObject;
  end;

  TBaseCalculoCibsInput = class(TInterfacedObject, ICalcCibsBaseInput)
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
    class function New: ICalcCibsBaseInput;

    function ValorFornecimento(const AValue: Double): ICalcCibsBaseInput;
    function AjusteValorOperacao(const AValue: Double): ICalcCibsBaseInput;
    function Juros(const AValue: Double): ICalcCibsBaseInput;
    function Multas(const AValue: Double): ICalcCibsBaseInput;
    function Acrescimos(const AValue: Double): ICalcCibsBaseInput;
    function Encargos(const AValue: Double): ICalcCibsBaseInput;
    function DescontosCondicionais(const AValue: Double): ICalcCibsBaseInput;
    function FretePorDentro(const AValue: Double): ICalcCibsBaseInput;
    function OutrosTributos(const AValue: Double): ICalcCibsBaseInput;
    function ImpostoSeletivo(const AValue: Double): ICalcCibsBaseInput;
    function DemaisImportancias(const AValue: Double): ICalcCibsBaseInput;
    function ICMS(const AValue: Double): ICalcCibsBaseInput;
    function ISS(const AValue: Double): ICalcCibsBaseInput;
    function PIS(const AValue: Double): ICalcCibsBaseInput;
    function COFINS(const AValue: Double): ICalcCibsBaseInput;

    function ToJSON: TJSONObject;
  end;

implementation

{ TBaseCalculoISMercadoriasInput }

class function TBaseCalculoISMercadoriasInput.New: ICalcISBaseInput;
begin
  Result := Create;
end;

function TBaseCalculoISMercadoriasInput.ValorIntegralCobrado(
  const AValue: Double): ICalcISBaseInput;
begin
  fpValorIntegralCobrado := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.AjusteValorOperacao(
  const AValue: Double): ICalcISBaseInput;
begin
  fpAjusteValorOperacao := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Juros(
  const AValue: Double): ICalcISBaseInput;
begin
  fpJuros := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Multas(
  const AValue: Double): ICalcISBaseInput;
begin
  fpMultas := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Acrescimos(
  const AValue: Double): ICalcISBaseInput;
begin
  fpAcrescimos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Encargos(
  const AValue: Double): ICalcISBaseInput;
begin
  fpEncargos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DescontosCondicionais(
  const AValue: Double): ICalcISBaseInput;
begin
  fpDescontosCondicionais := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.FretePorDentro(
  const AValue: Double): ICalcISBaseInput;
begin
  fpFretePorDentro := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.OutrosTributos(
  const AValue: Double): ICalcISBaseInput;
begin
  fpOutrosTributos := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DemaisImportancias(
  const AValue: Double): ICalcISBaseInput;
begin
  fpDemaisImportancias := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.ICMS(
  const AValue: Double): ICalcISBaseInput;
begin
  fpICMS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.ISS(
  const AValue: Double): ICalcISBaseInput;
begin
  fpISS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.PIS(
  const AValue: Double): ICalcISBaseInput;
begin
  fpPIS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.COFINS(
  const AValue: Double): ICalcISBaseInput;
begin
  fpCOFINS := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.Bonificacao(
  const AValue: Double): ICalcISBaseInput;
begin
  fpBonificacao := AValue;
  Result := Self;
end;

function TBaseCalculoISMercadoriasInput.DevolucaoVendas(
  const AValue: Double): ICalcISBaseInput;
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

class function TBaseCalculoCibsInput.New: ICalcCibsBaseInput;
begin
  Result := Create;
end;

function TBaseCalculoCibsInput.ValorFornecimento(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpValorFornecimento := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.AjusteValorOperacao(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpAjusteValorOperacao := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Juros(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpJuros := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Multas(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpMultas := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Acrescimos(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpAcrescimos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.Encargos(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpEncargos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.DescontosCondicionais(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpDescontosCondicionais := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.FretePorDentro(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpFretePorDentro := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.OutrosTributos(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpOutrosTributos := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ImpostoSeletivo(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpImpostoSeletivo := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.DemaisImportancias(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpDemaisImportancias := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ICMS(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpICMS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.ISS(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpISS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.PIS(
  const AValue: Double): ICalcCibsBaseInput;
begin
  fpPIS := AValue;
  Result := Self;
end;

function TBaseCalculoCibsInput.COFINS(
  const AValue: Double): ICalcCibsBaseInput;
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

end.

