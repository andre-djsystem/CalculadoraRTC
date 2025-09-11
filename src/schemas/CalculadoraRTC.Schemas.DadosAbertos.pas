unit CalculadoraRTC.Schemas.DadosAbertos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fgl, fpjson,
  CalculadoraRTC.Utils.JSON;

type
  TVersaoInfo = class
  private
    fpAppVersion: string;
    fpDbVersion: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TVersaoInfo; static;

    property AppVersion: string read fpAppVersion write fpAppVersion;
    property DbVersion: string read fpDbVersion write fpDbVersion;
    property Raw: TJSONObject read fpRaw;
  end;

  TUF = class
  private
    fpCodigoUf: Int64;
    fpSigla: string;
    fpNome: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TUF; static;

    property CodigoUf: Int64 read fpCodigoUf write fpCodigoUf;
    property Sigla: string read fpSigla write fpSigla;
    property Nome: string read fpNome write fpNome;
    property Raw: TJSONObject read fpRaw;
  end;

  TUFList = specialize TFPGObjectList<TUF>;

  TMunicipio = class
  private
    fpCodigoMunicipio: Int64;
    fpNome: string;
    fpSiglaUf: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TMunicipio; static;

    property CodigoMunicipio: Int64 read fpCodigoMunicipio write fpCodigoMunicipio;
    property Nome: string read fpNome write fpNome;
    property SiglaUf: string read fpSiglaUf write fpSiglaUf;
    property Raw: TJSONObject read fpRaw;
  end;

  TMunicipioList = specialize TFPGObjectList<TMunicipio>;

  TSituacaoTributaria = class
  private
    fpId: Int64;
    fpCodigo: string;
    fpDescricao: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TSituacaoTributaria; static;

    property Id: Int64 read fpId write fpId;
    property Codigo: string read fpCodigo write fpCodigo;
    property Descricao: string read fpDescricao write fpDescricao;
    property Raw: TJSONObject read fpRaw;
  end;

  TSituacaoTributariaList = specialize TFPGObjectList<TSituacaoTributaria>;

  TNcmInfo = class
  private
    fpCodigo: string;
    fpDescricao: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TNcmInfo; static;

    property Codigo: string read fpCodigo write fpCodigo;
    property Descricao: string read fpDescricao write fpDescricao;
    property Raw: TJSONObject read fpRaw;
  end;

  TNcmInfoList = specialize TFPGObjectList<TNcmInfo>;

  TNbsInfo = class
  private
    fpCodigo: string;
    fpDescricao: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TNbsInfo; static;

    property Codigo: string read fpCodigo write fpCodigo;
    property Descricao: string read fpDescricao write fpDescricao;
    property Raw: TJSONObject read fpRaw;
  end;

  TNbsInfoList = specialize TFPGObjectList<TNbsInfo>;

  TFundamentacaoLegal = class
  private
    fpId: Int64;
    fpDescricao: string;
    fpDispositivoLegal: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TFundamentacaoLegal; static;

    property Id: Int64 read fpId write fpId;
    property Descricao: string read fpDescricao write fpDescricao;
    property DispositivoLegal: string read fpDispositivoLegal write fpDispositivoLegal;
    property Raw: TJSONObject read fpRaw;
  end;

  TFundamentacaoLegalList = specialize TFPGObjectList<TFundamentacaoLegal>;

  TClassificacaoTributaria = class
  private
    fpId: Int64;
    fpCClassTrib: string;
    fpDescricao: string;
    fpTipo: string;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TClassificacaoTributaria; static;

    property Id: Int64 read fpId write fpId;
    property CClassTrib: string read fpCClassTrib write fpCClassTrib;
    property Descricao: string read fpDescricao write fpDescricao;
    property Tipo: string read fpTipo write fpTipo;
    property Raw: TJSONObject read fpRaw;
  end;

  TClassificacaoTributariaList = specialize TFPGObjectList<TClassificacaoTributaria>;

  TAliquotaUniao = class
  private
    fpData: string;
    fpPCBS: Double;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TAliquotaUniao; static;

    property Data: string read fpData write fpData;
    property PCBS: Double read fpPCBS write fpPCBS;
    property Raw: TJSONObject read fpRaw;
  end;

  TAliquotaUF = class
  private
    fpCodigoUf: Int64;
    fpData: string;
    fpPIBSUF: Double;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TAliquotaUF; static;

    property CodigoUf: Int64 read fpCodigoUf write fpCodigoUf;
    property Data: string read fpData write fpData;
    property PIBSUF: Double read fpPIBSUF write fpPIBSUF;
    property Raw: TJSONObject read fpRaw;
  end;

  TAliquotaMunicipio = class
  private
    fpCodigoMunicipio: Int64;
    fpData: string;
    fpPIBSMun: Double;
    fpRaw: TJSONObject;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TAliquotaMunicipio; static;

    property CodigoMunicipio: Int64 read fpCodigoMunicipio write fpCodigoMunicipio;
    property Data: string read fpData write fpData;
    property PIBSMun: Double read fpPIBSMun write fpPIBSMun;
    property Raw: TJSONObject read fpRaw;
  end;

implementation

{ TVersaoInfo }

destructor TVersaoInfo.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TVersaoInfo.FromJSON(AObj: TJSONObject): TVersaoInfo;
begin
  Result := TVersaoInfo.Create;
  if AObj = nil then
    Exit;

  Result.fpAppVersion := AObj.Get('appVersion', AObj.Get('versaoApp', ''));
  Result.fpDbVersion := AObj.Get('dbVersion', AObj.Get('versaoBD', ''));
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TUF }

destructor TUF.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TUF.FromJSON(AObj: TJSONObject): TUF;
begin
  Result := TUF.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigoUf := JSONGetInt64(AObj, 'codigoUf');
  Result.fpSigla := AObj.Get('siglaUf', AObj.Get('sigla', ''));
  Result.fpNome := AObj.Get('nome', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TMunicipio }

destructor TMunicipio.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TMunicipio.FromJSON(AObj: TJSONObject): TMunicipio;
begin
  Result := TMunicipio.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigoMunicipio := JSONGetInt64(AObj, 'codigoMunicipio');
  Result.fpNome := AObj.Get('nome', '');
  Result.fpSiglaUf := AObj.Get('siglaUf', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TSituacaoTributaria }

destructor TSituacaoTributaria.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TSituacaoTributaria.FromJSON(AObj: TJSONObject): TSituacaoTributaria;
begin
  Result := TSituacaoTributaria.Create;
  if AObj = nil then
    Exit;

  Result.fpId := JSONGetInt64(AObj, 'id');
  Result.fpCodigo := AObj.Get('codigo', '');
  Result.fpDescricao := AObj.Get('descricao', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TNcmInfo }

destructor TNcmInfo.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TNcmInfo.FromJSON(AObj: TJSONObject): TNcmInfo;
begin
  Result := TNcmInfo.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigo := AObj.Get('ncm', AObj.Get('codigo', ''));
  Result.fpDescricao := AObj.Get('descricao', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TNbsInfo }

destructor TNbsInfo.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TNbsInfo.FromJSON(AObj: TJSONObject): TNbsInfo;
begin
  Result := TNbsInfo.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigo := AObj.Get('nbs', AObj.Get('codigo', ''));
  Result.fpDescricao := AObj.Get('descricao', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TFundamentacaoLegal }

destructor TFundamentacaoLegal.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TFundamentacaoLegal.FromJSON(AObj: TJSONObject): TFundamentacaoLegal;
begin
  Result := TFundamentacaoLegal.Create;
  if AObj = nil then
    Exit;

  Result.fpId := JSONGetInt64(AObj, 'id');
  Result.fpDescricao := AObj.Get('descricao', '');
  Result.fpDispositivoLegal := AObj.Get('dispositivoLegal', AObj.Get('baseLegal', ''));
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TClassificacaoTributaria }

destructor TClassificacaoTributaria.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TClassificacaoTributaria.FromJSON(AObj: TJSONObject): TClassificacaoTributaria;
begin
  Result := TClassificacaoTributaria.Create;
  if AObj = nil then
    Exit;

  Result.fpId := JSONGetInt64(AObj, 'id');
  Result.fpCClassTrib := AObj.Get('cClassTrib', '');
  Result.fpDescricao := AObj.Get('descricao', '');
  Result.fpTipo := AObj.Get('tipo', '');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TAliquotaUniao }

destructor TAliquotaUniao.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TAliquotaUniao.FromJSON(AObj: TJSONObject): TAliquotaUniao;
begin
  Result := TAliquotaUniao.Create;
  if AObj = nil then
    Exit;

  Result.fpData := AObj.Get('data', '');
  Result.fpPCBS := JSONGetFloat(AObj, 'pCBS');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TAliquotaUF }

destructor TAliquotaUF.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TAliquotaUF.FromJSON(AObj: TJSONObject): TAliquotaUF;
begin
  Result := TAliquotaUF.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigoUf := JSONGetInt64(AObj, 'codigoUf');
  Result.fpData := AObj.Get('data', '');
  Result.fpPIBSUF := JSONGetFloat(AObj, 'pIBSUF');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

{ TAliquotaMunicipio }

destructor TAliquotaMunicipio.Destroy;
begin
  FreeAndNil(fpRaw);
  inherited Destroy;
end;

class function TAliquotaMunicipio.FromJSON(AObj: TJSONObject): TAliquotaMunicipio;
begin
  Result := TAliquotaMunicipio.Create;
  if AObj = nil then
    Exit;

  Result.fpCodigoMunicipio := JSONGetInt64(AObj, 'codigoMunicipio');
  Result.fpData := AObj.Get('data', '');
  Result.fpPIBSMun := JSONGetFloat(AObj, 'pIBSMun');
  Result.fpRaw := TJSONObject(AObj.Clone);
end;

end.
