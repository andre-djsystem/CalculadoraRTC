unit CalculadoraRTC.Utils.JSON;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser;

type

  TJSONExtFloatNumber = class(TJSONFloatNumber)
  protected
    function GetAsString: TJSONStringType; override;
  end;

function JFloat(const AValue: Double): TJSONFloatNumber;
function GetJSONExt(const AText: string; const AUseUTF8: Boolean = True): TJSONData;

function JSONGetFloat(AObj: TJSONObject; const AKey: string): Double;
function JSONGetInt(AObj: TJSONObject; const AKey: string): Integer;
function JSONGetInt64(AObj: TJSONObject; const AKey: string): Int64;

function SafeGetObj(AParent: TJSONObject; const AName: string): TJSONObject;
function SafeGetArr(AParent: TJSONObject; const AName: string): TJSONArray;

implementation

uses
  CalculadoraRTC.Config;


function GetCfgExportFloatScientific: Boolean;
begin
  Result := False;
  try
    Result := TCalculadoraRTCConfig.ExportFloatScientificNotation;
  except
    // Se Config não estiver disponível, mantém padrão.
  end;
end;

function GetCfgDecimalSeparator: Char;
var
  LSepCfg: string;
begin
  Result := FormatSettings.DecimalSeparator;
  try
    LSepCfg := TCalculadoraRTCConfig.DecimalSeparatorOverride;
    if LSepCfg <> '' then
      Result := LSepCfg[1];
  except
    // Se Config não estiver disponível, mantém padrão.
  end;
end;

function ConvertNode(const AData: TJSONData): TJSONData; forward;

function ConvertObject(const AObj: TJSONObject): TJSONObject;
var
  LI: Integer;
  LName: TJSONStringType;
  LItem: TJSONData;
  LNew: TJSONData;
begin
  Result := TJSONObject.Create;
  if AObj = nil then
    Exit;

  for LI := 0 to AObj.Count - 1 do
  begin
    LName := AObj.Names[LI];
    LItem := AObj.Items[LI];
    LNew := ConvertNode(LItem);
    Result.Add(LName, LNew);
  end;
end;

function ConvertArray(const AArr: TJSONArray): TJSONArray;
var
  LI: Integer;
  LItem: TJSONData;
  LNew: TJSONData;
begin
  Result := TJSONArray.Create;
  if AArr = nil then
    Exit;

  for LI := 0 to AArr.Count - 1 do
  begin
    LItem := AArr.Items[LI];
    LNew := ConvertNode(LItem);
    Result.Add(LNew);
  end;
end;

function ConvertNode(const AData: TJSONData): TJSONData;
begin
  if AData = nil then
  begin
    Result := nil;
    Exit;
  end;

  case AData.JSONType of
    jtObject:
      Result := ConvertObject(TJSONObject(AData));
    jtArray:
      Result := ConvertArray(TJSONArray(AData));
    jtNumber:
      begin
        // Preserva inteiros como inteiros; floats viram TJSONExtFloatNumber
        if AData is TJSONIntegerNumber then
          Result := TJSONIntegerNumber.Create(TJSONIntegerNumber(AData).AsInt64)
        else
          Result := TJSONExtFloatNumber.Create(TJSONNumber(AData).AsFloat);
      end;
  else
    Result := AData.Clone;
  end;
end;

function JFloat(const AValue: Double): TJSONFloatNumber;
begin
  Result := TJSONExtFloatNumber.Create(AValue);
end;

function GetJSONExt(const AText: string; const AUseUTF8: Boolean): TJSONData;
var
  LParsed: TJSONData;
begin
  Result := nil;
  LParsed := nil;
  try
    LParsed := GetJSON(AText, AUseUTF8);
    if LParsed = nil then
      Exit(nil);
    Result := ConvertNode(LParsed);
  finally
    LParsed.Free;
  end;
end;

function JSONGetFloat(AObj: TJSONObject; const AKey: string): Double;
var
  LData: TJSONData;
  LStr: string;
  LFS: TFormatSettings;
begin
  Result := 0.0;
  if AObj = nil then
    Exit;

  LData := AObj.Find(AKey);
  if LData = nil then
    Exit;

  case LData.JSONType of
    jtNumber:
      Result := TJSONNumber(LData).AsFloat;
    jtString:
      begin
        LStr := TJSONString(LData).AsString;
        if LStr = '' then
        begin
          Result := 0.0;
          Exit;
        end;
        LFS := DefaultFormatSettings;
        LFS.DecimalSeparator := ',';
        try
          Result := StrToFloat(LStr);
        except
          LFS.DecimalSeparator := '.';
          Result := StrToFloatDef(LStr, 0.0, LFS);
        end;
      end;
  else
    Result := 0.0;
  end;
end;

function JSONGetInt(AObj: TJSONObject; const AKey: string): Integer;
var
  LData: TJSONData;
  LStr: string;
begin
  Result := 0;
  if AObj = nil then
    Exit;

  LData := AObj.Find(AKey);
  if LData = nil then
    Exit;

  case LData.JSONType of
    jtNumber:
      Result := TJSONNumber(LData).AsInteger;
    jtString:
      begin
        LStr := TJSONString(LData).AsString;
        Result := StrToIntDef(LStr, 0);
      end;
  else
    Result := 0;
  end;
end;

function JSONGetInt64(AObj: TJSONObject; const AKey: string): Int64;
var
  LData: TJSONData;
  LStr: string;
begin
  Result := 0;
  if AObj = nil then
    Exit;

  LData := AObj.Find(AKey);
  if LData = nil then
    Exit;

  case LData.JSONType of
    jtNumber:
      Result := TJSONNumber(LData).AsInt64;
    jtString:
      begin
        LStr := TJSONString(LData).AsString;
        Result := StrToInt64Def(LStr, 0);
      end;
  else
    Result := 0;
  end;
end;

function SafeGetObj(AParent: TJSONObject; const AName: string): TJSONObject;
var
  LData: TJSONData;
begin
  Result := nil;
  if AParent = nil then
    Exit;

  LData := AParent.Find(AName);
  if (LData <> nil) and (LData.JSONType = jtObject) then
    Result := TJSONObject(LData)
  else
    Result := nil;
end;

function SafeGetArr(AParent: TJSONObject; const AName: string): TJSONArray;
var
  LData: TJSONData;
begin
  Result := nil;
  if AParent = nil then
    Exit;

  LData := AParent.Find(AName);
  if (LData <> nil) and (LData.JSONType = jtArray) then
    Result := TJSONArray(LData)
  else
    Result := nil;
end;

function TJSONExtFloatNumber.GetAsString: TJSONStringType;
var
  LFS: TFormatSettings;
begin
  if GetCfgExportFloatScientific then
  begin
    Result := inherited GetAsString;
    Exit;
  end;

  LFS := DefaultFormatSettings;
  LFS.DecimalSeparator := GetCfgDecimalSeparator;

  Result := FloatToStr(GetAsFloat, LFS);

  if (Result <> '') and (Result[1] = ' ') then
    Delete(Result, 1, 1);
end;

end.
