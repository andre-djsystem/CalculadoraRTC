unit CalculadoraRTC.Schemas.ROC.ISel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  CalculadoraRTC.Utils.JSON;

type
  { Saída do grupo "IS" no ROC (Regime Geral) }
  IROCImpostoSeletivo = interface
    ['{E1A2B3C4-D5E6-47F8-9A0B-1C2D3E4F5A6B}']
    // getters (nomes fiéis ao Swagger)
    function CSTIS: Integer;
    function CClassTribIS: string;
    function VBCIS: Double;
    function PIS: Double;
    function PISEspec: Double;
    function UTrib: string;
    function QTrib: Double;
    function VIS: Double;
    function MemoriaCalculo: string;

    // utilitário
    function ToJSON: TJSONObject;
  end;

  { Implementação }
  TROCImpostoSeletivo = class(TInterfacedObject, IROCImpostoSeletivo)
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
    // Fábrica a partir do JSON da API
    class function FromJSON(AObj: TJSONObject): IROCImpostoSeletivo; static;

    // IROCImpostoSeletivo
    function CSTIS: Integer;
    function CClassTribIS: string;
    function VBCIS: Double;
    function PIS: Double;
    function PISEspec: Double;
    function UTrib: string;
    function QTrib: Double;
    function VIS: Double;
    function MemoriaCalculo: string;

    function ToJSON: TJSONObject;
  end;

implementation

{ TROCImpostoSeletivo }

class function TROCImpostoSeletivo.FromJSON(AObj: TJSONObject): IROCImpostoSeletivo;
var
  LInst: TROCImpostoSeletivo;
begin
  LInst := TROCImpostoSeletivo.Create;

  if AObj <> nil then
  begin
    // Campos podem vir como número ou string — usamos helpers robustos
    LInst.fpCSTIS         := JSONGetInt(AObj, 'CSTIS');
    LInst.fpCClassTribIS  := JSONGetString(AObj, 'cClassTribIS', '');
    LInst.fpVBCIS         := JSONGetFloat(AObj, 'vBCIS');
    LInst.fpPIS           := JSONGetFloat(AObj, 'pIS');
    LInst.fpPISEspec      := JSONGetFloat(AObj, 'pISEspec');
    LInst.fpUTrib         := JSONGetString(AObj, 'uTrib', '');
    LInst.fpQTrib         := JSONGetFloat(AObj, 'qTrib');
    LInst.fpVIS           := JSONGetFloat(AObj, 'vIS');
    LInst.fpMemoriaCalculo:= JSONGetString(AObj, 'memoriaCalculo', '');
  end;

  Result := LInst;
end;

function TROCImpostoSeletivo.CSTIS: Integer;
begin
  Result := fpCSTIS;
end;

function TROCImpostoSeletivo.CClassTribIS: string;
begin
  Result := fpCClassTribIS;
end;

function TROCImpostoSeletivo.VBCIS: Double;
begin
  Result := fpVBCIS;
end;

function TROCImpostoSeletivo.PIS: Double;
begin
  Result := fpPIS;
end;

function TROCImpostoSeletivo.PISEspec: Double;
begin
  Result := fpPISEspec;
end;

function TROCImpostoSeletivo.UTrib: string;
begin
  Result := fpUTrib;
end;

function TROCImpostoSeletivo.QTrib: Double;
begin
  Result := fpQTrib;
end;

function TROCImpostoSeletivo.VIS: Double;
begin
  Result := fpVIS;
end;

function TROCImpostoSeletivo.MemoriaCalculo: string;
begin
  Result := fpMemoriaCalculo;
end;

function TROCImpostoSeletivo.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('CSTIS', fpCSTIS);
  Result.Add('cClassTribIS', fpCClassTribIS);
  Result.Add('vBCIS', JFloat(fpVBCIS));
  Result.Add('pIS', JFloat(fpPIS));
  Result.Add('pISEspec', JFloat(fpPISEspec));
  Result.Add('uTrib', fpUTrib);
  Result.Add('qTrib', JFloat(fpQTrib));
  Result.Add('vIS', JFloat(fpVIS));
  Result.Add('memoriaCalculo', fpMemoriaCalculo);
end;

end.

