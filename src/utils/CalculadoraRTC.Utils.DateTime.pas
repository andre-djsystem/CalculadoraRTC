unit CalculadoraRTC.Utils.DateTime;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

function DateTimeToISO8601TZ(const ADateTime: TDateTime; const ATZOffsetMinutes: Integer = 0): string;

implementation

function DateTimeToISO8601TZ(const ADateTime: TDateTime; const ATZOffsetMinutes: Integer): string;
var
  LSign: Char;
  LAbsMin: Integer;
  LHours: Integer;
  LMinutes: Integer;
  LTimeText: string;
begin
  LTimeText := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', ADateTime);

  if ATZOffsetMinutes = 0 then
  begin
    Result := LTimeText + 'Z';
    Exit;
  end;

  if ATZOffsetMinutes < 0 then
    LSign := '-'
  else
    LSign := '+';

  LAbsMin := Abs(ATZOffsetMinutes);
  LHours := LAbsMin div 60;
  LMinutes := LAbsMin mod 60;

  Result := Format('%s%s%.2d:%.2d', [LTimeText, LSign, LHours, LMinutes]);
end;

end.
