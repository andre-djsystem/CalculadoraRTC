unit CalculadoraRTC.Schemas.ROC.ISel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson,
  CalculadoraRTC.Utils.JSON;

type
  TImpostoSeletivo = class
  private
    fpCSTIS: Integer;
    fpCClassTribIS: string;
    fpVBCIS: Double;
    fpPIS: Double;
    fpPISEspec: Double;
    fpUTrib: string;
    fpQTrib: Double;
    fpVIS: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): TImpostoSeletivo; static;

    property CSTIS: Integer read fpCSTIS write fpCSTIS;
    property cClassTribIS: string read fpCClassTribIS write fpCClassTribIS;
    property vBCIS: Double read fpVBCIS write fpVBCIS;
    property pIS: Double read fpPIS write fpPIS;
    property pISEspec: Double read fpPISEspec write fpPISEspec;
    property uTrib: string read fpUTrib write fpUTrib;
    property qTrib: Double read fpQTrib write fpQTrib;
    property vIS: Double read fpVIS write fpVIS;
    property memoriaCalculo: string read fpMemoriaCalculo write fpMemoriaCalculo;
  end;

  TImpostoSeletivoTotal = class
  private
    fpVIS: Double;
  public
    class function FromJSON(AObj: TJSONObject): TImpostoSeletivoTotal; static;

    property vIS: Double read fpVIS write fpVIS;
  end;

implementation

{ TImpostoSeletivo }

class function TImpostoSeletivo.FromJSON(AObj: TJSONObject): TImpostoSeletivo;
begin
  Result := TImpostoSeletivo.Create;
  if AObj = nil then
    Exit;

  // Alguns backends retornam inteiros como string (ex.: "000") — usar helper robusto
  Result.fpCSTIS := JSONGetInt(AObj, 'CSTIS');
  Result.fpCClassTribIS := AObj.Get('cClassTribIS', '');

  Result.fpVBCIS := JSONGetFloat(AObj, 'vBCIS');
  Result.fpPIS := JSONGetFloat(AObj, 'pIS');
  Result.fpPISEspec := JSONGetFloat(AObj, 'pISEspec');

  Result.fpUTrib := AObj.Get('uTrib', '');
  Result.fpQTrib := JSONGetFloat(AObj, 'qTrib');
  Result.fpVIS := JSONGetFloat(AObj, 'vIS');

  Result.fpMemoriaCalculo := AObj.Get('memoriaCalculo', '');
end;

{ TImpostoSeletivoTotal }

class function TImpostoSeletivoTotal.FromJSON(AObj: TJSONObject): TImpostoSeletivoTotal;
begin
  Result := TImpostoSeletivoTotal.Create;
  if AObj = nil then
    Exit;

  Result.fpVIS := JSONGetFloat(AObj, 'vIS');
end;

end.
