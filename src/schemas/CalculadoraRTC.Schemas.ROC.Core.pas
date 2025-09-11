unit CalculadoraRTC.Schemas.ROC.Core;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fgl,
  fpjson,
  CalculadoraRTC.Utils.JSON,
  CalculadoraRTC.Schemas.ROC.ISel,
  CalculadoraRTC.Schemas.ROC.IBSCBS;

type
  TTributos = class
  private
    fpIS: TImpostoSeletivo;
    fpIBSCBS: TIBSCBS;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TTributos; static;

    property ISel: TImpostoSeletivo read fpIS write fpIS;
    property IBSCBS: TIBSCBS read fpIBSCBS write fpIBSCBS;
  end;

  TObjeto = class
  private
    fpnObj: Integer;
    fptribCalc: TTributos;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TObjeto; static;

    property nObj: Integer read fpnObj write fpnObj;
    property tribCalc: TTributos read fptribCalc write fptribCalc;
  end;

  TObjetos = specialize TFPGObjectList<TObjeto>;

  TTributosTotais = class
  private
    fpISTot: TImpostoSeletivoTotal;
    fpIBSCBSTot: TIBSCBSTotal;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TTributosTotais; static;

    property ISTot: TImpostoSeletivoTotal read fpISTot write fpISTot;
    property IBSCBSTot: TIBSCBSTotal read fpIBSCBSTot write fpIBSCBSTot;
  end;

  TValoresTotais = class
  private
    fptribCalc: TTributosTotais;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TValoresTotais; static;

    property tribCalc: TTributosTotais read fptribCalc write fptribCalc;
  end;

  TROC = class
  private
    fpObjetos: TObjetos;
    fptotal: TValoresTotais;
  public
    constructor Create;
    destructor Destroy; override;
    class function FromJSON(AJson: TJSONData): TROC; static;

    property objetos: TObjetos read fpObjetos;
    property total: TValoresTotais read fptotal write fptotal;
  end;

implementation

{ TTributos }

destructor TTributos.Destroy;
begin
  FreeAndNil(fpIS);
  FreeAndNil(fpIBSCBS);
  inherited Destroy;
end;

class function TTributos.FromJSON(AObj: TJSONObject): TTributos;
var
  LObj: TJSONObject;
begin
  Result := TTributos.Create;
  if AObj = nil then
    Exit;

  LObj := SafeGetObj(AObj, 'IS');
  if LObj <> nil then
    Result.fpIS := TImpostoSeletivo.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'IBSCBS');
  if LObj <> nil then
    Result.fpIBSCBS := TIBSCBS.FromJSON(LObj);
end;

{ TObjeto }

destructor TObjeto.Destroy;
begin
  FreeAndNil(fptribCalc);
  inherited Destroy;
end;

class function TObjeto.FromJSON(AObj: TJSONObject): TObjeto;
var
  LObj: TJSONObject;
begin
  Result := TObjeto.Create;
  if AObj = nil then
    Exit;

  Result.fpnObj := JSONGetInt(AObj, 'nObj');

  LObj := SafeGetObj(AObj, 'tribCalc');
  if LObj <> nil then
    Result.fptribCalc := TTributos.FromJSON(LObj);
end;

{ TTributosTotais }

destructor TTributosTotais.Destroy;
begin
  FreeAndNil(fpISTot);
  FreeAndNil(fpIBSCBSTot);
  inherited Destroy;
end;

class function TTributosTotais.FromJSON(AObj: TJSONObject): TTributosTotais;
var
  LObj: TJSONObject;
begin
  Result := TTributosTotais.Create;
  if AObj = nil then
    Exit;

  LObj := SafeGetObj(AObj, 'ISTot');
  if LObj <> nil then
    Result.fpISTot := TImpostoSeletivoTotal.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'IBSCBSTot');
  if LObj <> nil then
    Result.fpIBSCBSTot := TIBSCBSTotal.FromJSON(LObj);
end;

{ TValoresTotais }

destructor TValoresTotais.Destroy;
begin
  FreeAndNil(fptribCalc);
  inherited Destroy;
end;

class function TValoresTotais.FromJSON(AObj: TJSONObject): TValoresTotais;
var
  LObj: TJSONObject;
begin
  Result := TValoresTotais.Create;
  if AObj = nil then
    Exit;

  LObj := SafeGetObj(AObj, 'tribCalc');
  if LObj <> nil then
    Result.fptribCalc := TTributosTotais.FromJSON(LObj);
end;

{ TROC }

constructor TROC.Create;
begin
  inherited Create;
  fpObjetos := TObjetos.Create(True);
end;

destructor TROC.Destroy;
begin
  FreeAndNil(fpObjetos);
  FreeAndNil(fptotal);
  inherited Destroy;
end;

class function TROC.FromJSON(AJson: TJSONData): TROC;
var
  LRoot: TJSONObject;
  LArr: TJSONArray;
  I: Integer;
  LItemObj: TJSONObject;
  LItem: TObjeto;
  LTot: TJSONObject;
begin
  Result := TROC.Create;
  if (AJson = nil) or (AJson.JSONType <> jtObject) then
    Exit;

  LRoot := TJSONObject(AJson);

  LArr := SafeGetArr(LRoot, 'objetos');
  if LArr <> nil then
  begin
    for I := 0 to LArr.Count - 1 do
    begin
      LItemObj := LArr.Objects[I];
      LItem := TObjeto.FromJSON(LItemObj);
      Result.fpObjetos.Add(LItem);
    end;
  end;

  LTot := SafeGetObj(LRoot, 'total');
  if LTot <> nil then
    Result.fptotal := TValoresTotais.FromJSON(LTot);
end;

end.
