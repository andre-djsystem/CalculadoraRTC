unit CalculadoraRTC.Schemas.ROC.Core;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, fgl,
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Schemas.ROC.ISel,
  CalculadoraRTC.Schemas.ROC.IBSCBS;

type
  IROCTributos = interface
    ['{F1F7D6CF-5D0B-4F68-9E8A-7A0D0B2A7B7F}']
    function IS_: IROCImpostoSeletivo;  // campo "IS" no Swagger
    function IBSCBS: IROCIBSCBS;        // campo "IBSCBS" no Swagger
    function ToJSON: TJSONObject;
  end;

  IROCObjeto = interface
    ['{2B2E5C43-AE7A-4B18-8F2F-30E9E2D9D061}']
    function NObj: Integer;                // nObj
    function TribCalc: IROCTributos;       // tribCalc
    function ToJSON: TJSONObject;
  end;

  // gIBSUF (totais)
  IROCTotalIBSUF = interface
    ['{C01C64C0-3B3D-4B07-98B1-2656267E0C17}']
    function VDif: Double;         // vDif
    function VDevTrib: Double;     // vDevTrib
    function VIBSUF: Double;       // vIBSUF
    function ToJSON: TJSONObject;
  end;

  // gIBSMun (totais)
  IROCTotalIBSMun = interface
    ['{5B68B6F4-08B4-4F7E-9D55-1D679B1C7D61}']
    function VDif: Double;         // vDif
    function VDevTrib: Double;     // vDevTrib
    function VIBSMun: Double;      // vIBSMun
    function ToJSON: TJSONObject;
  end;

  // gIBS (totais)
  IROCTotalIBS = interface
    ['{5E70B599-19B5-4B37-8C3B-24465B918E3D}']
    function GIBSUF: IROCTotalIBSUF;  // gIBSUF
    function GIBSMun: IROCTotalIBSMun;// gIBSMun
    function VIBS: Double;            // vIBS
    function VCredPres: Double;       // vCredPres
    function VCredPresCondSus: Double;// vCredPresCondSus
    function ToJSON: TJSONObject;
  end;

  // gCBS (totais)
  IROCTotalCBS = interface
    ['{3A5F4C79-79E2-4AF9-8B69-73CF6F08B7EB}']
    function VDif: Double;             // vDif
    function VDevTrib: Double;         // vDevTrib
    function VCBS: Double;             // vCBS
    function VCredPres: Double;        // vCredPres
    function VCredPresCondSus: Double; // vCredPresCondSus
    function ToJSON: TJSONObject;
  end;

  // IBSCBSTot
  IROCTotalIBSCBS = interface
    ['{1B3F3E37-0C4A-4D91-AD0E-23C7F08D4F8E}']
    function VBCIBSCBS: Double;    // vBCIBSCBS
    function GIBS: IROCTotalIBS;   // gIBS
    function GCBS: IROCTotalCBS;   // gCBS
    function ToJSON: TJSONObject;
  end;

  // ISTot
  IROCTotalIS = interface
    ['{0D8B0E2A-F52F-4E9E-9B99-0F2BB6A62E7C}']
    function VIS: Double;          // vIS
    function ToJSON: TJSONObject;
  end;

  // total.tribCalc
  IROCTributosTotais = interface
    ['{B6D7B37E-56A7-4C67-8A89-10A2E0F7C1B4}']
    function ISTot: IROCTotalIS;          // ISTot
    function IBSCBSTot: IROCTotalIBSCBS;  // IBSCBSTot
    function ToJSON: TJSONObject;
  end;

  // total
  IROCValoresTotais = interface
    ['{E5CF8E4A-5CBB-4F39-BF5D-6B6E763B93E8}']
    function TribCalc: IROCTributosTotais; // tribCalc
    function ToJSON: TJSONObject;
  end;

  IROC = interface
    ['{1D1BC5F3-ACF4-4E33-8E15-2360D270B8ED}']
    function ObjetosCount: Integer;
    function Objeto(const AIndex: Integer): IROCObjeto;
    function Total: IROCValoresTotais;
    function ToJSON: TJSONObject;
  end;

  generic TInterfacedList<T> = class(specialize TFPGInterfacedObjectList<T>)
  end;

  TROCTributos = class(TInterfacedObject, IROCTributos)
  private
    fpIS: IROCImpostoSeletivo;
    fpIBSCBS: IROCIBSCBS;
  public
    class function FromJSON(AObj: TJSONObject): IROCTributos; static;

    function IS_: IROCImpostoSeletivo;
    function IBSCBS: IROCIBSCBS;
    function ToJSON: TJSONObject;
  end;

  TROCObjeto = class(TInterfacedObject, IROCObjeto)
  private
    fpNObj: Integer;
    fpTribCalc: IROCTributos;
  public
    class function FromJSON(AObj: TJSONObject): IROCObjeto; static;

    function NObj: Integer;
    function TribCalc: IROCTributos;
    function ToJSON: TJSONObject;
  end;

  TROCTotalIBSUF = class(TInterfacedObject, IROCTotalIBSUF)
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVIBSUF: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalIBSUF; static;

    function VDif: Double;
    function VDevTrib: Double;
    function VIBSUF: Double;
    function ToJSON: TJSONObject;
  end;

  TROCTotalIBSMun = class(TInterfacedObject, IROCTotalIBSMun)
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVIBSMun: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalIBSMun; static;

    function VDif: Double;
    function VDevTrib: Double;
    function VIBSMun: Double;
    function ToJSON: TJSONObject;
  end;

  TROCTotalIBS = class(TInterfacedObject, IROCTotalIBS)
  private
    fpGIBSUF: IROCTotalIBSUF;
    fpGIBSMun: IROCTotalIBSMun;
    fpVIBS: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalIBS; static;

    function GIBSUF: IROCTotalIBSUF;
    function GIBSMun: IROCTotalIBSMun;
    function VIBS: Double;
    function VCredPres: Double;
    function VCredPresCondSus: Double;
    function ToJSON: TJSONObject;
  end;

  TROCTotalCBS = class(TInterfacedObject, IROCTotalCBS)
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVCBS: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalCBS; static;

    function VDif: Double;
    function VDevTrib: Double;
    function VCBS: Double;
    function VCredPres: Double;
    function VCredPresCondSus: Double;
    function ToJSON: TJSONObject;
  end;

  TROCTotalIBSCBS = class(TInterfacedObject, IROCTotalIBSCBS)
  private
    fpVBCIBSCBS: Double;
    fpGIBS: IROCTotalIBS;
    fpGCBS: IROCTotalCBS;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalIBSCBS; static;

    function VBCIBSCBS: Double;
    function GIBS: IROCTotalIBS;
    function GCBS: IROCTotalCBS;
    function ToJSON: TJSONObject;
  end;

  TROCTotalIS = class(TInterfacedObject, IROCTotalIS)
  private
    fpVIS: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTotalIS; static;

    function VIS: Double;
    function ToJSON: TJSONObject;
  end;

  TROCTributosTotais = class(TInterfacedObject, IROCTributosTotais)
  private
    fpISTot: IROCTotalIS;
    fpIBSCBSTot: IROCTotalIBSCBS;
  public
    class function FromJSON(AObj: TJSONObject): IROCTributosTotais; static;

    function ISTot: IROCTotalIS;
    function IBSCBSTot: IROCTotalIBSCBS;
    function ToJSON: TJSONObject;
  end;

  TROCValoresTotais = class(TInterfacedObject, IROCValoresTotais)
  private
    fpTribCalc: IROCTributosTotais;
  public
    class function FromJSON(AObj: TJSONObject): IROCValoresTotais; static;

    function TribCalc: IROCTributosTotais;
    function ToJSON: TJSONObject;
  end;

  TROC = class(TInterfacedObject, IROC)
  private
    type
      TIObjList = specialize TInterfacedList<IROCObjeto>;
  private
    fpObjetos: TIObjList;
    fpTotal: IROCValoresTotais;
  public
    constructor Create;
    destructor Destroy; override;

    class function FromJSON(AJson: TJSONData): IROC; static;

    function ObjetosCount: Integer;
    function Objeto(const AIndex: Integer): IROCObjeto;
    function Total: IROCValoresTotais;
    function ToJSON: TJSONObject;
  end;

implementation

class function TROCTributos.FromJSON(AObj: TJSONObject): IROCTributos;
var
  LInst: TROCTributos;
  LSub: TJSONObject = nil;
begin
  LInst := TROCTributos.Create;

  if AObj <> nil then
  begin
    LSub := SafeGetObj(AObj, 'IS');
    if LSub <> nil then
      LInst.fpIS := TROCImpostoSeletivo.FromJSON(LSub);

    LSub := SafeGetObj(AObj, 'IBSCBS');
    if LSub <> nil then
      LInst.fpIBSCBS := TROCIBSCBSGroup.FromJSON(LSub);
  end;

  Result := LInst;
end;

function TROCTributos.IS_: IROCImpostoSeletivo;
begin
  Result := fpIS;
end;

function TROCTributos.IBSCBS: IROCIBSCBS;
begin
  Result := fpIBSCBS;
end;

function TROCTributos.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if fpIS <> nil then
    Result.Add('IS', fpIS.ToJSON);
  if fpIBSCBS <> nil then
    Result.Add('IBSCBS', fpIBSCBS.ToJSON);
end;

class function TROCObjeto.FromJSON(AObj: TJSONObject): IROCObjeto;
var
  LInst: TROCObjeto;
  LSub: TJSONObject = nil;
begin
  LInst := TROCObjeto.Create;

  if AObj <> nil then
  begin
    LInst.fpNObj := JSONGetInt(AObj, 'nObj');

    LSub := SafeGetObj(AObj, 'tribCalc');
    if LSub <> nil then
      LInst.fpTribCalc := TROCTributos.FromJSON(LSub);
  end;

  Result := LInst;
end;

function TROCObjeto.NObj: Integer;
begin
  Result := fpNObj;
end;

function TROCObjeto.TribCalc: IROCTributos;
begin
  Result := fpTribCalc;
end;

function TROCObjeto.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('nObj', fpNObj);
  if fpTribCalc <> nil then
    Result.Add('tribCalc', fpTribCalc.ToJSON);
end;

class function TROCTotalIBSUF.FromJSON(AObj: TJSONObject): IROCTotalIBSUF;
var
  LInst: TROCTotalIBSUF;
begin
  LInst := TROCTotalIBSUF.Create;

  if AObj <> nil then
  begin
    LInst.fpVDif     := JSONGetFloat(AObj, 'vDif');
    LInst.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
    LInst.fpVIBSUF   := JSONGetFloat(AObj, 'vIBSUF');
  end;

  Result := LInst;
end;

function TROCTotalIBSUF.VDif: Double;
begin
  Result := fpVDif;
end;

function TROCTotalIBSUF.VDevTrib: Double;
begin
  Result := fpVDevTrib;
end;

function TROCTotalIBSUF.VIBSUF: Double;
begin
  Result := fpVIBSUF;
end;

function TROCTotalIBSUF.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vDif', JFloat(fpVDif));
  Result.Add('vDevTrib', JFloat(fpVDevTrib));
  Result.Add('vIBSUF', JFloat(fpVIBSUF));
end;

class function TROCTotalIBSMun.FromJSON(AObj: TJSONObject): IROCTotalIBSMun;
var
  LInst: TROCTotalIBSMun;
begin
  LInst := TROCTotalIBSMun.Create;

  if AObj <> nil then
  begin
    LInst.fpVDif     := JSONGetFloat(AObj, 'vDif');
    LInst.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
    LInst.fpVIBSMun  := JSONGetFloat(AObj, 'vIBSMun');
  end;

  Result := LInst;
end;

function TROCTotalIBSMun.VDif: Double;
begin
  Result := fpVDif;
end;

function TROCTotalIBSMun.VDevTrib: Double;
begin
  Result := fpVDevTrib;
end;

function TROCTotalIBSMun.VIBSMun: Double;
begin
  Result := fpVIBSMun;
end;

function TROCTotalIBSMun.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vDif', JFloat(fpVDif));
  Result.Add('vDevTrib', JFloat(fpVDevTrib));
  Result.Add('vIBSMun', JFloat(fpVIBSMun));
end;

class function TROCTotalIBS.FromJSON(AObj: TJSONObject): IROCTotalIBS;
var
  LInst: TROCTotalIBS;
  LSub: TJSONObject = nil;
begin
  LInst := TROCTotalIBS.Create;

  if AObj <> nil then
  begin
    LSub := SafeGetObj(AObj, 'gIBSUF');
    if LSub <> nil then
      LInst.fpGIBSUF := TROCTotalIBSUF.FromJSON(LSub);

    LSub := SafeGetObj(AObj, 'gIBSMun');
    if LSub <> nil then
      LInst.fpGIBSMun := TROCTotalIBSMun.FromJSON(LSub);

    LInst.fpVIBS              := JSONGetFloat(AObj, 'vIBS');
    LInst.fpVCredPres         := JSONGetFloat(AObj, 'vCredPres');
    LInst.fpVCredPresCondSus  := JSONGetFloat(AObj, 'vCredPresCondSus');
  end;

  Result := LInst;
end;

function TROCTotalIBS.GIBSUF: IROCTotalIBSUF;
begin
  Result := fpGIBSUF;
end;

function TROCTotalIBS.GIBSMun: IROCTotalIBSMun;
begin
  Result := fpGIBSMun;
end;

function TROCTotalIBS.VIBS: Double;
begin
  Result := fpVIBS;
end;

function TROCTotalIBS.VCredPres: Double;
begin
  Result := fpVCredPres;
end;

function TROCTotalIBS.VCredPresCondSus: Double;
begin
  Result := fpVCredPresCondSus;
end;

function TROCTotalIBS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if fpGIBSUF <> nil then
    Result.Add('gIBSUF', fpGIBSUF.ToJSON);
  if fpGIBSMun <> nil then
    Result.Add('gIBSMun', fpGIBSMun.ToJSON);
  Result.Add('vIBS', JFloat(fpVIBS));
  Result.Add('vCredPres', JFloat(fpVCredPres));
  Result.Add('vCredPresCondSus', JFloat(fpVCredPresCondSus));
end;

class function TROCTotalCBS.FromJSON(AObj: TJSONObject): IROCTotalCBS;
var
  LInst: TROCTotalCBS;
begin
  LInst := TROCTotalCBS.Create;

  if AObj <> nil then
  begin
    LInst.fpVDif              := JSONGetFloat(AObj, 'vDif');
    LInst.fpVDevTrib          := JSONGetFloat(AObj, 'vDevTrib');
    LInst.fpVCBS              := JSONGetFloat(AObj, 'vCBS');
    LInst.fpVCredPres         := JSONGetFloat(AObj, 'vCredPres');
    LInst.fpVCredPresCondSus  := JSONGetFloat(AObj, 'vCredPresCondSus');
  end;

  Result := LInst;
end;

function TROCTotalCBS.VDif: Double;
begin
  Result := fpVDif;
end;

function TROCTotalCBS.VDevTrib: Double;
begin
  Result := fpVDevTrib;
end;

function TROCTotalCBS.VCBS: Double;
begin
  Result := fpVCBS;
end;

function TROCTotalCBS.VCredPres: Double;
begin
  Result := fpVCredPres;
end;

function TROCTotalCBS.VCredPresCondSus: Double;
begin
  Result := fpVCredPresCondSus;
end;

function TROCTotalCBS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vDif', JFloat(fpVDif));
  Result.Add('vDevTrib', JFloat(fpVDevTrib));
  Result.Add('vCBS', JFloat(fpVCBS));
  Result.Add('vCredPres', JFloat(fpVCredPres));
  Result.Add('vCredPresCondSus', JFloat(fpVCredPresCondSus));
end;

class function TROCTotalIBSCBS.FromJSON(AObj: TJSONObject): IROCTotalIBSCBS;
var
  LInst: TROCTotalIBSCBS;
  LSub: TJSONObject = nil;
begin
  LInst := TROCTotalIBSCBS.Create;

  if AObj <> nil then
  begin
    LInst.fpVBCIBSCBS := JSONGetFloat(AObj, 'vBCIBSCBS');

    LSub := SafeGetObj(AObj, 'gIBS');
    if LSub <> nil then
      LInst.fpGIBS := TROCTotalIBS.FromJSON(LSub);

    LSub := SafeGetObj(AObj, 'gCBS');
    if LSub <> nil then
      LInst.fpGCBS := TROCTotalCBS.FromJSON(LSub);
  end;

  Result := LInst;
end;

function TROCTotalIBSCBS.VBCIBSCBS: Double;
begin
  Result := fpVBCIBSCBS;
end;

function TROCTotalIBSCBS.GIBS: IROCTotalIBS;
begin
  Result := fpGIBS;
end;

function TROCTotalIBSCBS.GCBS: IROCTotalCBS;
begin
  Result := fpGCBS;
end;

function TROCTotalIBSCBS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vBCIBSCBS', JFloat(fpVBCIBSCBS));
  if fpGIBS <> nil then
    Result.Add('gIBS', fpGIBS.ToJSON);
  if fpGCBS <> nil then
    Result.Add('gCBS', fpGCBS.ToJSON);
end;

class function TROCTotalIS.FromJSON(AObj: TJSONObject): IROCTotalIS;
var
  LInst: TROCTotalIS;
begin
  LInst := TROCTotalIS.Create;

  if AObj <> nil then
  begin
    LInst.fpVIS := JSONGetFloat(AObj, 'vIS');
  end;

  Result := LInst;
end;

function TROCTotalIS.VIS: Double;
begin
  Result := fpVIS;
end;

function TROCTotalIS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vIS', JFloat(fpVIS));
end;

class function TROCTributosTotais.FromJSON(AObj: TJSONObject): IROCTributosTotais;
var
  LInst: TROCTributosTotais;
  LSub: TJSONObject = nil;
begin
  LInst := TROCTributosTotais.Create;

  if AObj <> nil then
  begin
    LSub := SafeGetObj(AObj, 'ISTot');
    if LSub <> nil then
      LInst.fpISTot := TROCTotalIS.FromJSON(LSub);

    LSub := SafeGetObj(AObj, 'IBSCBSTot');
    if LSub <> nil then
      LInst.fpIBSCBSTot := TROCTotalIBSCBS.FromJSON(LSub);
  end;

  Result := LInst;
end;

function TROCTributosTotais.ISTot: IROCTotalIS;
begin
  Result := fpISTot;
end;

function TROCTributosTotais.IBSCBSTot: IROCTotalIBSCBS;
begin
  Result := fpIBSCBSTot;
end;

function TROCTributosTotais.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if fpISTot <> nil then
    Result.Add('ISTot', fpISTot.ToJSON);
  if fpIBSCBSTot <> nil then
    Result.Add('IBSCBSTot', fpIBSCBSTot.ToJSON);
end;

class function TROCValoresTotais.FromJSON(AObj: TJSONObject): IROCValoresTotais;
var
  LInst: TROCValoresTotais;
  LSub: TJSONObject = nil;
begin
  LInst := TROCValoresTotais.Create;

  if AObj <> nil then
  begin
    LSub := SafeGetObj(AObj, 'tribCalc');
    if LSub <> nil then
      LInst.fpTribCalc := TROCTributosTotais.FromJSON(LSub);
  end;

  Result := LInst;
end;

function TROCValoresTotais.TribCalc: IROCTributosTotais;
begin
  Result := fpTribCalc;
end;

function TROCValoresTotais.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  if fpTribCalc <> nil then
    Result.Add('tribCalc', fpTribCalc.ToJSON);
end;

constructor TROC.Create;
begin
  inherited Create;
  fpObjetos := TIObjList.Create;
end;

destructor TROC.Destroy;
begin
  fpObjetos.Free;
  inherited Destroy;
end;

class function TROC.FromJSON(AJson: TJSONData): IROC;
var
  LSelf: TROC;
  LObj: TJSONObject = nil;
  LArr: TJSONArray;
  I: Integer;
  LItem: TJSONObject = nil;
  LObjeto: IROCObjeto;
  LTot: TJSONObject = nil;
begin
  LSelf := TROC.Create;

  if (AJson <> nil) and (AJson.JSONType = jtObject) then
  begin
    LObj := TJSONObject(AJson);

    // objetos[]
    LArr := SafeGetArr(LObj, 'objetos');
    if LArr <> nil then
    begin
      for I := 0 to LArr.Count - 1 do
      begin
        LItem := LArr.Objects[I];
        LObjeto := TROCObjeto.FromJSON(LItem);
        if LObjeto <> nil then
          LSelf.fpObjetos.Add(LObjeto);
      end;
    end;

    // total
    LTot := SafeGetObj(LObj, 'total');
    if LTot <> nil then
      LSelf.fpTotal := TROCValoresTotais.FromJSON(LTot);
  end;

  Result := LSelf;
end;

function TROC.ObjetosCount: Integer;
begin
  Result := fpObjetos.Count;
end;

function TROC.Objeto(const AIndex: Integer): IROCObjeto;
begin
  if (AIndex >= 0) and (AIndex < fpObjetos.Count) then
    Result := fpObjetos[AIndex]
  else
    Result := nil;
end;

function TROC.Total: IROCValoresTotais;
begin
  Result := fpTotal;
end;

function TROC.ToJSON: TJSONObject;
var
  LArr: TJSONArray;
  I: Integer;
begin
  Result := TJSONObject.Create;

  // objetos
  LArr := TJSONArray.Create;
  for I := 0 to fpObjetos.Count - 1 do
    if fpObjetos[I] <> nil then
      LArr.Add(fpObjetos[I].ToJSON);
  Result.Add('objetos', LArr);

  // total
  if fpTotal <> nil then
    Result.Add('total', fpTotal.ToJSON);
end;

end.

