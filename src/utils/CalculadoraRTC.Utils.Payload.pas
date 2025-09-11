unit CalculadoraRTC.Utils.Payload;

{$mode objfpc}{$H+}

interface

uses
  fpjson, SysUtils;

procedure NormalizeISBasePayload(AJson: TJSONObject);
procedure NormalizeCibsBasePayload(AJson: TJSONObject);

implementation

procedure EnsureField(AJson: TJSONObject; const AName: string);
begin
  if (AJson = nil) or (AName = '') then
    Exit;

  if AJson.IndexOfName(AName) < 0 then
    AJson.Add(AName, 0.0);
end;

procedure NormalizeISBasePayload(AJson: TJSONObject);
begin
  if AJson = nil then
    Exit;

  EnsureField(AJson, 'valorIntegralCobrado');
  EnsureField(AJson, 'ajusteValorOperacao');
  EnsureField(AJson, 'juros');
  EnsureField(AJson, 'multas');
  EnsureField(AJson, 'acrescimos');
  EnsureField(AJson, 'encargos');
  EnsureField(AJson, 'descontosCondicionais');
  EnsureField(AJson, 'fretePorDentro');
  EnsureField(AJson, 'outrosTributos');
  EnsureField(AJson, 'demaisImportancias');
  EnsureField(AJson, 'icms');
  EnsureField(AJson, 'iss');
  EnsureField(AJson, 'pis');
  EnsureField(AJson, 'cofins');
  EnsureField(AJson, 'bonificacao');
  EnsureField(AJson, 'devolucaoVendas');
end;

procedure NormalizeCibsBasePayload(AJson: TJSONObject);
begin
  if AJson = nil then
    Exit;

  EnsureField(AJson, 'valorFornecimento');
  EnsureField(AJson, 'ajusteValorOperacao');
  EnsureField(AJson, 'juros');
  EnsureField(AJson, 'multas');
  EnsureField(AJson, 'acrescimos');
  EnsureField(AJson, 'encargos');
  EnsureField(AJson, 'descontosCondicionais');
  EnsureField(AJson, 'fretePorDentro');
  EnsureField(AJson, 'outrosTributos');
  EnsureField(AJson, 'impostoSeletivo');
  EnsureField(AJson, 'demaisImportancias');
  EnsureField(AJson, 'icms');
  EnsureField(AJson, 'iss');
  EnsureField(AJson, 'pis');
  EnsureField(AJson, 'cofins');
end;

end.
