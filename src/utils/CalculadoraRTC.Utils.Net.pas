unit CalculadoraRTC.Utils.Net;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, fpjson;

function BuildUrl(const BaseUrl, Path: string): string;

function EnsureLeadingSlash(const S: string): string;
function EnsureNoTrailingSlash(const S: string): string;

function AppendQueryParam(const Url, Name, Value: string): string;

function UrlEncode(const S: string): string;

function IsHttpSuccess(const Status: Integer): Boolean;

procedure CaptureVersionHeaders(AHeaders: TStrings; out AppVersion, DbVersion: string);

function ParseJsonExt(const Text: string): TJSONData;

implementation

uses
  FPHTTPClient,             { EncodeURLElement }
  CalculadoraRTC.Utils.JSON;

function EnsureLeadingSlash(const S: string): string;
begin
  if S = '' then
    Exit('/');

  if S[1] = '/' then
    Result := S
  else
    Result := '/' + S;
end;

function EnsureNoTrailingSlash(const S: string): string;
begin
  Result := S;
  if Result = '' then
    Exit;

  if Result[Length(Result)] = '/' then
    Delete(Result, Length(Result), 1);
end;

function BuildUrl(const BaseUrl, Path: string): string;
var
  LBase: string;
  LPath: string;
begin
  LBase := EnsureNoTrailingSlash(BaseUrl);
  if Path = '' then
  begin
    Result := LBase;
    Exit;
  end;

  LPath := Path;
  if (Length(LPath) > 0) and (LPath[1] <> '/') then
    LPath := '/' + LPath;

  Result := LBase + LPath;
end;

function UrlEncode(const S: string): string;
begin
  Result := EncodeURLElement(S);
end;

function AppendQueryParam(const Url, Name, Value: string): string;
var
  Sep: Char;
begin
  if Pos('?', Url) > 0 then
    Sep := '&'
  else
    Sep := '?';

  Result := Url + Sep + UrlEncode(Name) + '=' + UrlEncode(Value);
end;

function IsHttpSuccess(const Status: Integer): Boolean;
begin
  Result := (Status >= 200) and (Status < 300);
end;

procedure CaptureVersionHeaders(AHeaders: TStrings; out AppVersion, DbVersion: string);
begin
  AppVersion := '';
  DbVersion := '';

  if AHeaders = nil then
    Exit;

  AppVersion := AHeaders.Values['X-CALC-APP-VERSION'];
  DbVersion := AHeaders.Values['X-CALC-DB-VERSION'];
end;

function ParseJsonExt(const Text: string): TJSONData;
begin
  if Trim(Text) = '' then
    Exit(nil);

  Result := GetJSONExt(Text, True);
end;

end.
