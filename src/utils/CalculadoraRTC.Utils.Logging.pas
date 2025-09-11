unit CalculadoraRTC.Utils.Logging;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, fpjson,
  CalculadoraRTC.Utils.JSON;

type
  TLogSink = procedure(const S: string) of object;

  ICalcLogger = interface
    ['{E65062B8-8B5E-4D7B-8F01-4C6C2C6A5F7E}']
    procedure SetSink(ASink: TLogSink);
    procedure LogSection(const ATitle: string);
    procedure LogText(const AText: string);
    procedure LogJSON(const ATitle: string; AData: TJSONData);
  end;

  TCalcLogger = class(TInterfacedObject, ICalcLogger)
  private
    fpSink: TLogSink;
    procedure Emit(const S: string);
  public
    constructor Create(ASink: TLogSink = nil);
    procedure SetSink(ASink: TLogSink);
    procedure LogSection(const ATitle: string);
    procedure LogText(const AText: string);
    procedure LogJSON(const ATitle: string; AData: TJSONData);
  end;

implementation

{ TCalcLogger }

constructor TCalcLogger.Create(ASink: TLogSink);
begin
  inherited Create;
  fpSink := ASink;
end;

procedure TCalcLogger.SetSink(ASink: TLogSink);
begin
  fpSink := ASink;
end;

procedure TCalcLogger.Emit(const S: string);
begin
  if Assigned(fpSink) then
    fpSink(S);
end;

procedure TCalcLogger.LogSection(const ATitle: string);
begin
  Emit('==== ' + ATitle + ' ====');
end;

procedure TCalcLogger.LogText(const AText: string);
begin
  Emit(AText);
end;

procedure TCalcLogger.LogJSON(const ATitle: string; AData: TJSONData);
var
  LOut: string;
begin
  LogSection(ATitle);
  if Assigned(AData) then
    LOut := AData.FormatJSON()
  else
    LOut := '(sem conteúdo)';
  Emit(LOut);
  Emit('');
end;

end.
