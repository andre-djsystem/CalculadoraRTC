unit CalculadoraRTC.Core.Types;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TStatusCode = type Integer;

  TISO8601Str = type AnsiString;  
  TURLStr = type AnsiString;
  THeaderName = type AnsiString;
  THeaderVal = type AnsiString;

  TJSONNumberNotation = (
    jnnDefault,  
    jnnPlain
  );

  TLogProc = procedure(const ATitle, AMessage: string) of object;

  TRequestDefaults = record
    BaseUrl: TURLStr;     // sem barra no final
    TimeoutMS: Integer;   // em milissegundos
    UserAgent: AnsiString;
  end;

const
  CHeaderAppVersion: THeaderName = 'X-CALC-APP-VERSION';
  CHeaderDbVersion: THeaderName = 'X-CALC-DB-VERSION';

implementation

end.
