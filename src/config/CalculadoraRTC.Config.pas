unit CalculadoraRTC.Config;

{$mode objfpc}{$H+}

interface

type
  TCalculadoraRTCConfig = class sealed
  strict private
    class var FBaseUrl: string;
    class var FTimeoutMS: Integer;
    class var FUserAgent: string;

    class var FExportFloatScientificNotation: Boolean;
    class var FDecimalSeparatorOverride: string;

  public
    class procedure ResetDefaults;

    class property BaseUrl: string read FBaseUrl write FBaseUrl;
    class property TimeoutMS: Integer read FTimeoutMS write FTimeoutMS;
    class property UserAgent: string read FUserAgent write FUserAgent;

    class property ExportFloatScientificNotation: Boolean
      read FExportFloatScientificNotation write FExportFloatScientificNotation;

    class property DecimalSeparatorOverride: string
      read FDecimalSeparatorOverride write FDecimalSeparatorOverride;
  end;

implementation

{ TCalculadoraRTCConfig }

class procedure TCalculadoraRTCConfig.ResetDefaults;
begin
  FBaseUrl := 'https://piloto-cbs.tributos.gov.br/servico/calculadora-consumo/api';
  FTimeoutMS := 30000;
  FUserAgent := 'CalculadoraRTC/DJSystem';

  FExportFloatScientificNotation := False;
  FDecimalSeparatorOverride := '';
end;

initialization
  TCalculadoraRTCConfig.ResetDefaults;

end.
