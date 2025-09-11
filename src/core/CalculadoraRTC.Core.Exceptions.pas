unit CalculadoraRTC.Core.Exceptions;

{$mode objfpc}{$H+}

interface

uses
  SysUtils;

type
  ECalculadoraRTC = class(Exception);

  ECalculadoraRTCHTTP = class(ECalculadoraRTC)
  private
    FStatusCode: Integer;
    FDetail: string;
  public
    constructor Create(const AStatusCode: Integer; const ADetail: string); reintroduce;

    property StatusCode: Integer read FStatusCode;
    property Detail: string read FDetail;
  end;

  ECalculadoraRTCJSON = class(ECalculadoraRTC);

implementation

{ ECalculadoraRTCHTTP }

constructor ECalculadoraRTCHTTP.Create(const AStatusCode: Integer; const ADetail: string);
begin
  FStatusCode := AStatusCode;
  FDetail := ADetail;
  inherited CreateFmt('HTTP %d: %s', [AStatusCode, ADetail]);
end;

end.
