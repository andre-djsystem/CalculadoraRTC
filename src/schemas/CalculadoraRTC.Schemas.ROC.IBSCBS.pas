unit CalculadoraRTC.Schemas.ROC.IBSCBS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  fpjson,
  CalculadoraRTC.Utils.JSON;

type
  TDiferimento = class
  private
    fpPDif: Double;
    fpVDif: Double;
  public
    class function FromJSON(AObj: TJSONObject): TDiferimento; static;

    property pDif: Double read fpPDif write fpPDif;
    property vDif: Double read fpVDif write fpVDif;
  end;

  TDevolucaoTributos = class
  private
    fpVDevTrib: Double;
  public
    class function FromJSON(AObj: TJSONObject): TDevolucaoTributos; static;

    property vDevTrib: Double read fpVDevTrib write fpVDevTrib;
  end;

  TReducaoAliquota = class
  private
    fpPRedAliq: Double;
    fpPAliqEfet: Double;
  public
    class function FromJSON(AObj: TJSONObject): TReducaoAliquota; static;

    property pRedAliq: Double read fpPRedAliq write fpPRedAliq;
    property pAliqEfet: Double read fpPAliqEfet write fpPAliqEfet;
  end;

  TCreditoPresumido = class
  private
    fpCCredPres: Integer;
    fpPCredPres: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    class function FromJSON(AObj: TJSONObject): TCreditoPresumido; static;

    property cCredPres: Integer read fpCCredPres write fpCCredPres;
    property pCredPres: Double read fpPCredPres write fpPCredPres;
    property vCredPres: Double read fpVCredPres write fpVCredPres;
    property vCredPresCondSus: Double read fpVCredPresCondSus write fpVCredPresCondSus;
  end;

  TCreditoPresumidoIBSZFM = class
  private
    fpTpCredPresIBSZFM: Integer;
    fpVCredPresIBSZFM: Double;
  public
    class function FromJSON(AObj: TJSONObject): TCreditoPresumidoIBSZFM; static;

    property tpCredPresIBSZFM: Integer read fpTpCredPresIBSZFM write fpTpCredPresIBSZFM;
    property vCredPresIBSZFM: Double read fpVCredPresIBSZFM write fpVCredPresIBSZFM;
  end;

  TTransferenciaCredito = class
  private
    fpVIBS: Double;
    fpVCBS: Double;
  public
    class function FromJSON(AObj: TJSONObject): TTransferenciaCredito; static;

    property vIBS: Double read fpVIBS write fpVIBS;
    property vCBS: Double read fpVCBS write fpVCBS;
  end;

  TTributacaoCompraGovernamental = class
  private
    fpPAliqIBSUF: Double;
    fpVTribIBSUF: Double;
    fpPAliqIBSMun: Double;
    fpVTribIBSMun: Double;
    fpPAliqCBS: Double;
    fpVTribCBS: Double;
  public
    class function FromJSON(AObj: TJSONObject): TTributacaoCompraGovernamental; static;

    property pAliqIBSUF: Double read fpPAliqIBSUF write fpPAliqIBSUF;
    property vTribIBSUF: Double read fpVTribIBSUF write fpVTribIBSUF;
    property pAliqIBSMun: Double read fpPAliqIBSMun write fpPAliqIBSMun;
    property vTribIBSMun: Double read fpVTribIBSMun write fpVTribIBSMun;
    property pAliqCBS: Double read fpPAliqCBS write fpPAliqCBS;
    property vTribCBS: Double read fpVTribCBS write fpVTribCBS;
  end;

  TIBSUF = class
  private
    fpPIBSUF: Double;
    fpgDif: TDiferimento;
    fpgDevTrib: TDevolucaoTributos;
    fpgRed: TReducaoAliquota;
    fpVIBSUF: Double;
    fpMemoriaCalculo: string;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TIBSUF; static;

    property pIBSUF: Double read fpPIBSUF write fpPIBSUF;
    property gDif: TDiferimento read fpgDif write fpgDif;
    property gDevTrib: TDevolucaoTributos read fpgDevTrib write fpgDevTrib;
    property gRed: TReducaoAliquota read fpgRed write fpgRed;
    property vIBSUF: Double read fpVIBSUF write fpVIBSUF;
    property memoriaCalculo: string read fpMemoriaCalculo write fpMemoriaCalculo;
  end;

  TIBSMun = class
  private
    fpPIBSMun: Double;
    fpgDif: TDiferimento;
    fpgDevTrib: TDevolucaoTributos;
    fpgRed: TReducaoAliquota;
    fpVIBSMun: Double;
    fpMemoriaCalculo: string;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TIBSMun; static;

    property pIBSMun: Double read fpPIBSMun write fpPIBSMun;
    property gDif: TDiferimento read fpgDif write fpgDif;
    property gDevTrib: TDevolucaoTributos read fpgDevTrib write fpgDevTrib;
    property gRed: TReducaoAliquota read fpgRed write fpgRed;
    property vIBSMun: Double read fpVIBSMun write fpVIBSMun;
    property memoriaCalculo: string read fpMemoriaCalculo write fpMemoriaCalculo;
  end;

  TCBS = class
  private
    fpPCBS: Double;
    fpgDif: TDiferimento;
    fpgDevTrib: TDevolucaoTributos;
    fpgRed: TReducaoAliquota;
    fpVCBS: Double;
    fpMemoriaCalculo: string;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TCBS; static;

    property pCBS: Double read fpPCBS write fpPCBS;
    property gDif: TDiferimento read fpgDif write fpgDif;
    property gDevTrib: TDevolucaoTributos read fpgDevTrib write fpgDevTrib;
    property gRed: TReducaoAliquota read fpgRed write fpgRed;
    property vCBS: Double read fpVCBS write fpVCBS;
    property memoriaCalculo: string read fpMemoriaCalculo write fpMemoriaCalculo;
  end;

  {------------------------------------------------------------------------------
    Grupo com base e subgrupos (ITEM)
   ------------------------------------------------------------------------------}
  TGrupoIBSCBS = class
  private
    fpVBC: Double;
    fpgIBSUF: TIBSUF;
    fpgIBSMun: TIBSMun;
    fpgCBS: TCBS;
    fpgIBSCredPres: TCreditoPresumido;
    fpgCBSCredPres: TCreditoPresumido;
    fpgTribCompraGov: TTributacaoCompraGovernamental;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TGrupoIBSCBS; static;

    property vBC: Double read fpVBC write fpVBC;
    property gIBSUF: TIBSUF read fpgIBSUF write fpgIBSUF;
    property gIBSMun: TIBSMun read fpgIBSMun write fpgIBSMun;
    property gCBS: TCBS read fpgCBS write fpgCBS;
    property gIBSCredPres: TCreditoPresumido read fpgIBSCredPres write fpgIBSCredPres;
    property gCBSCredPres: TCreditoPresumido read fpgCBSCredPres write fpgCBSCredPres;
    property gTribCompraGov: TTributacaoCompraGovernamental read fpgTribCompraGov write fpgTribCompraGov;
  end;

  TMonofasia = class
  private
    fpQBCMono: Double;
    fpAdRemIBS: Double;
    fpAdRemCBS: Double;
    fpVIBSMono: Double;
    fpVCBSMono: Double;
    fpVIBSMonoDif: Double;
    fpVCBSMonoDif: Double;
    fpVTotIBSMonoItem: Double;
    fpVTotCBSMonoItem: Double;
  public
    class function FromJSON(AObj: TJSONObject): TMonofasia; static;

    property qBCMono: Double read fpQBCMono write fpQBCMono;
    property adRemIBS: Double read fpAdRemIBS write fpAdRemIBS;
    property adRemCBS: Double read fpAdRemCBS write fpAdRemCBS;
    property vIBSMono: Double read fpVIBSMono write fpVIBSMono;
    property vCBSMono: Double read fpVCBSMono write fpVCBSMono;
    property vIBSMonoDif: Double read fpVIBSMonoDif write fpVIBSMonoDif;
    property vCBSMonoDif: Double read fpVCBSMonoDif write fpVCBSMonoDif;
    property vTotIBSMonoItem: Double read fpVTotIBSMonoItem write fpVTotIBSMonoItem;
    property vTotCBSMonoItem: Double read fpVTotCBSMonoItem write fpVTotCBSMonoItem;
  end;

  TIBSCBS = class
  private
    fpCST: Integer;
    fpcClassTrib: string;
    fpgIBSCBS: TGrupoIBSCBS;
    fpgIBSCBSMono: TMonofasia;
    fpgTransfCred: TTransferenciaCredito;
    fpgCredPresIBSZFM: TCreditoPresumidoIBSZFM;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TIBSCBS; static;

    property CST: Integer read fpCST write fpCST;
    property cClassTrib: string read fpcClassTrib write fpcClassTrib;
    property gIBSCBS: TGrupoIBSCBS read fpgIBSCBS write fpgIBSCBS;
    property gIBSCBSMono: TMonofasia read fpgIBSCBSMono write fpgIBSCBSMono;
    property gTransfCred: TTransferenciaCredito read fpgTransfCred write fpgTransfCred;
    property gCredPresIBSZFM: TCreditoPresumidoIBSZFM read fpgCredPresIBSZFM write fpgCredPresIBSZFM;
  end;

  {------------------------------------------------------------------------------
    Totais
   ------------------------------------------------------------------------------}
  TIBSUFTotal = class
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVIBSUF: Double;
  public
    class function FromJSON(AObj: TJSONObject): TIBSUFTotal; static;

    property vDif: Double read fpVDif write fpVDif;
    property vDevTrib: Double read fpVDevTrib write fpVDevTrib;
    property vIBSUF: Double read fpVIBSUF write fpVIBSUF;
  end;

  TIBSMunTotal = class
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVIBSMun: Double;
  public
    class function FromJSON(AObj: TJSONObject): TIBSMunTotal; static;

    property vDif: Double read fpVDif write fpVDif;
    property vDevTrib: Double read fpVDevTrib write fpVDevTrib;
    property vIBSMun: Double read fpVIBSMun write fpVIBSMun;
  end;

  TIBSTotal = class
  private
    fpgIBSUF: TIBSUFTotal;
    fpgIBSMun: TIBSMunTotal;
    fpVIBS: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TIBSTotal; static;

    property gIBSUF: TIBSUFTotal read fpgIBSUF write fpgIBSUF;
    property gIBSMun: TIBSMunTotal read fpgIBSMun write fpgIBSMun;
    property vIBS: Double read fpVIBS write fpVIBS;
    property vCredPres: Double read fpVCredPres write fpVCredPres;
    property vCredPresCondSus: Double read fpVCredPresCondSus write fpVCredPresCondSus;
  end;

  TCBSTotal = class
  private
    fpVDif: Double;
    fpVDevTrib: Double;
    fpVCBS: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    class function FromJSON(AObj: TJSONObject): TCBSTotal; static;

    property vDif: Double read fpVDif write fpVDif;
    property vDevTrib: Double read fpVDevTrib write fpVDevTrib;
    property vCBS: Double read fpVCBS write fpVCBS;
    property vCredPres: Double read fpVCredPres write fpVCredPres;
    property vCredPresCondSus: Double read fpVCredPresCondSus write fpVCredPresCondSus;
  end;

  TIBSCBSTotal = class
  private
    fpVBCIBSCBS: Double;
    fpgIBS: TIBSTotal;
    fpgCBS: TCBSTotal;
  public
    destructor Destroy; override;
    class function FromJSON(AObj: TJSONObject): TIBSCBSTotal; static;

    property vBCIBSCBS: Double read fpVBCIBSCBS write fpVBCIBSCBS;
    property gIBS: TIBSTotal read fpgIBS write fpgIBS;
    property gCBS: TCBSTotal read fpgCBS write fpgCBS;
  end;

implementation

{ TDiferimento }

class function TDiferimento.FromJSON(AObj: TJSONObject): TDiferimento;
begin
  Result := TDiferimento.Create;
  if AObj = nil then
    Exit;

  Result.fpPDif := JSONGetFloat(AObj, 'pDif');
  Result.fpVDif := JSONGetFloat(AObj, 'vDif');
end;

{ TDevolucaoTributos }

class function TDevolucaoTributos.FromJSON(AObj: TJSONObject): TDevolucaoTributos;
begin
  Result := TDevolucaoTributos.Create;
  if AObj = nil then
    Exit;

  Result.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
end;

{ TReducaoAliquota }

class function TReducaoAliquota.FromJSON(AObj: TJSONObject): TReducaoAliquota;
begin
  Result := TReducaoAliquota.Create;
  if AObj = nil then
    Exit;

  Result.fpPRedAliq := JSONGetFloat(AObj, 'pRedAliq');
  Result.fpPAliqEfet := JSONGetFloat(AObj, 'pAliqEfet');
end;

{ TCreditoPresumido }

class function TCreditoPresumido.FromJSON(AObj: TJSONObject): TCreditoPresumido;
begin
  Result := TCreditoPresumido.Create;
  if AObj = nil then
    Exit;

  Result.fpCCredPres := JSONGetInt(AObj, 'cCredPres');
  Result.fpPCredPres := JSONGetFloat(AObj, 'pCredPres');
  Result.fpVCredPres := JSONGetFloat(AObj, 'vCredPres');
  Result.fpVCredPresCondSus := JSONGetFloat(AObj, 'vCredPresCondSus');
end;

{ TCreditoPresumidoIBSZFM }

class function TCreditoPresumidoIBSZFM.FromJSON(AObj: TJSONObject): TCreditoPresumidoIBSZFM;
begin
  Result := TCreditoPresumidoIBSZFM.Create;
  if AObj = nil then
    Exit;

  Result.fpTpCredPresIBSZFM := JSONGetInt(AObj, 'tpCredPresIBSZFM');
  Result.fpVCredPresIBSZFM := JSONGetFloat(AObj, 'vCredPresIBSZFM');
end;

{ TTransferenciaCredito }

class function TTransferenciaCredito.FromJSON(AObj: TJSONObject): TTransferenciaCredito;
begin
  Result := TTransferenciaCredito.Create;
  if AObj = nil then
    Exit;

  Result.fpVIBS := JSONGetFloat(AObj, 'vIBS');
  Result.fpVCBS := JSONGetFloat(AObj, 'vCBS');
end;

{ TTributacaoCompraGovernamental }

class function TTributacaoCompraGovernamental.FromJSON(AObj: TJSONObject): TTributacaoCompraGovernamental;
begin
  Result := TTributacaoCompraGovernamental.Create;
  if AObj = nil then
    Exit;

  Result.fpPAliqIBSUF := JSONGetFloat(AObj, 'pAliqIBSUF');
  Result.fpVTribIBSUF := JSONGetFloat(AObj, 'vTribIBSUF');
  Result.fpPAliqIBSMun := JSONGetFloat(AObj, 'pAliqIBSMun');
  Result.fpVTribIBSMun := JSONGetFloat(AObj, 'vTribIBSMun');
  Result.fpPAliqCBS := JSONGetFloat(AObj, 'pAliqCBS');
  Result.fpVTribCBS := JSONGetFloat(AObj, 'vTribCBS');
end;

{ TIBSUF }

destructor TIBSUF.Destroy;
begin
  FreeAndNil(fpgDif);
  FreeAndNil(fpgDevTrib);
  FreeAndNil(fpgRed);
  inherited Destroy;
end;

class function TIBSUF.FromJSON(AObj: TJSONObject): TIBSUF;
var
  LObj: TJSONObject;
begin
  Result := TIBSUF.Create;
  if AObj = nil then
    Exit;

  Result.fpPIBSUF := JSONGetFloat(AObj, 'pIBSUF');
  Result.fpVIBSUF := JSONGetFloat(AObj, 'vIBSUF');
  Result.fpMemoriaCalculo := AObj.Get('memoriaCalculo', '');

  LObj := SafeGetObj(AObj, 'gDif');
  if LObj <> nil then
    Result.fpgDif := TDiferimento.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gDevTrib');
  if LObj <> nil then
    Result.fpgDevTrib := TDevolucaoTributos.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gRed');
  if LObj <> nil then
    Result.fpgRed := TReducaoAliquota.FromJSON(LObj);
end;

{ TIBSMun }

destructor TIBSMun.Destroy;
begin
  FreeAndNil(fpgDif);
  FreeAndNil(fpgDevTrib);
  FreeAndNil(fpgRed);
  inherited Destroy;
end;

class function TIBSMun.FromJSON(AObj: TJSONObject): TIBSMun;
var
  LObj: TJSONObject;
begin
  Result := TIBSMun.Create;
  if AObj = nil then
    Exit;

  Result.fpPIBSMun := JSONGetFloat(AObj, 'pIBSMun');
  Result.fpVIBSMun := JSONGetFloat(AObj, 'vIBSMun');
  Result.fpMemoriaCalculo := AObj.Get('memoriaCalculo', '');

  LObj := SafeGetObj(AObj, 'gDif');
  if LObj <> nil then
    Result.fpgDif := TDiferimento.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gDevTrib');
  if LObj <> nil then
    Result.fpgDevTrib := TDevolucaoTributos.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gRed');
  if LObj <> nil then
    Result.fpgRed := TReducaoAliquota.FromJSON(LObj);
end;

{ TCBS }

destructor TCBS.Destroy;
begin
  FreeAndNil(fpgDif);
  FreeAndNil(fpgDevTrib);
  FreeAndNil(fpgRed);
  inherited Destroy;
end;

class function TCBS.FromJSON(AObj: TJSONObject): TCBS;
var
  LObj: TJSONObject;
begin
  Result := TCBS.Create;
  if AObj = nil then
    Exit;

  Result.fpPCBS := JSONGetFloat(AObj, 'pCBS');
  Result.fpVCBS := JSONGetFloat(AObj, 'vCBS');
  Result.fpMemoriaCalculo := AObj.Get('memoriaCalculo', '');

  LObj := SafeGetObj(AObj, 'gDif');
  if LObj <> nil then
    Result.fpgDif := TDiferimento.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gDevTrib');
  if LObj <> nil then
    Result.fpgDevTrib := TDevolucaoTributos.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gRed');
  if LObj <> nil then
    Result.fpgRed := TReducaoAliquota.FromJSON(LObj);
end;

{ TGrupoIBSCBS }

destructor TGrupoIBSCBS.Destroy;
begin
  FreeAndNil(fpgIBSUF);
  FreeAndNil(fpgIBSMun);
  FreeAndNil(fpgCBS);
  FreeAndNil(fpgIBSCredPres);
  FreeAndNil(fpgCBSCredPres);
  FreeAndNil(fpgTribCompraGov);
  inherited Destroy;
end;

class function TGrupoIBSCBS.FromJSON(AObj: TJSONObject): TGrupoIBSCBS;
var
  LObj: TJSONObject;
begin
  Result := TGrupoIBSCBS.Create;
  if AObj = nil then
    Exit;

  Result.fpVBC := JSONGetFloat(AObj, 'vBC');

  LObj := SafeGetObj(AObj, 'gIBSUF');
  if LObj <> nil then
    Result.fpgIBSUF := TIBSUF.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gIBSMun');
  if LObj <> nil then
    Result.fpgIBSMun := TIBSMun.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gCBS');
  if LObj <> nil then
    Result.fpgCBS := TCBS.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gIBSCredPres');
  if LObj <> nil then
    Result.fpgIBSCredPres := TCreditoPresumido.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gCBSCredPres');
  if LObj <> nil then
    Result.fpgCBSCredPres := TCreditoPresumido.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gTribCompraGov');
  if LObj <> nil then
    Result.fpgTribCompraGov := TTributacaoCompraGovernamental.FromJSON(LObj);
end;

{ TMonofasia }

class function TMonofasia.FromJSON(AObj: TJSONObject): TMonofasia;
begin
  Result := TMonofasia.Create;
  if AObj = nil then
    Exit;

  Result.fpQBCMono := JSONGetFloat(AObj, 'qBCMono');
  Result.fpAdRemIBS := JSONGetFloat(AObj, 'adRemIBS');
  Result.fpAdRemCBS := JSONGetFloat(AObj, 'adRemCBS');
  Result.fpVIBSMono := JSONGetFloat(AObj, 'vIBSMono');
  Result.fpVCBSMono := JSONGetFloat(AObj, 'vCBSMono');
  Result.fpVIBSMonoDif := JSONGetFloat(AObj, 'vIBSMonoDif');
  Result.fpVCBSMonoDif := JSONGetFloat(AObj, 'vCBSMonoDif');
  Result.fpVTotIBSMonoItem := JSONGetFloat(AObj, 'vTotIBSMonoItem');
  Result.fpVTotCBSMonoItem := JSONGetFloat(AObj, 'vTotCBSMonoItem');
end;

{ TIBSCBS }

destructor TIBSCBS.Destroy;
begin
  FreeAndNil(fpgIBSCBS);
  FreeAndNil(fpgIBSCBSMono);
  FreeAndNil(fpgTransfCred);
  FreeAndNil(fpgCredPresIBSZFM);
  inherited Destroy;
end;

class function TIBSCBS.FromJSON(AObj: TJSONObject): TIBSCBS;
var
  LObj: TJSONObject;
begin
  Result := TIBSCBS.Create;
  if AObj = nil then
    Exit;

  // A API pode retornar "CST": "000" (string). Usar JSONGetInt para fallback.
  Result.fpCST := JSONGetInt(AObj, 'CST');
  Result.fpcClassTrib := AObj.Get('cClassTrib', '');

  LObj := SafeGetObj(AObj, 'gIBSCBS');
  if LObj <> nil then
    Result.fpgIBSCBS := TGrupoIBSCBS.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gIBSCBSMono');
  if LObj <> nil then
    Result.fpgIBSCBSMono := TMonofasia.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gTransfCred');
  if LObj <> nil then
    Result.fpgTransfCred := TTransferenciaCredito.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gCredPresIBSZFM');
  if LObj <> nil then
    Result.fpgCredPresIBSZFM := TCreditoPresumidoIBSZFM.FromJSON(LObj);
end;

{ TIBSUFTotal }

class function TIBSUFTotal.FromJSON(AObj: TJSONObject): TIBSUFTotal;
begin
  Result := TIBSUFTotal.Create;
  if AObj = nil then
    Exit;

  Result.fpVDif := JSONGetFloat(AObj, 'vDif');
  Result.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
  Result.fpVIBSUF := JSONGetFloat(AObj, 'vIBSUF');
end;

{ TIBSMunTotal }

class function TIBSMunTotal.FromJSON(AObj: TJSONObject): TIBSMunTotal;
begin
  Result := TIBSMunTotal.Create;
  if AObj = nil then
    Exit;

  Result.fpVDif := JSONGetFloat(AObj, 'vDif');
  Result.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
  Result.fpVIBSMun := JSONGetFloat(AObj, 'vIBSMun');
end;

{ TIBSTotal }

destructor TIBSTotal.Destroy;
begin
  FreeAndNil(fpgIBSUF);
  FreeAndNil(fpgIBSMun);
  inherited Destroy;
end;

class function TIBSTotal.FromJSON(AObj: TJSONObject): TIBSTotal;
var
  LObj: TJSONObject;
begin
  Result := TIBSTotal.Create;
  if AObj = nil then
    Exit;

  LObj := SafeGetObj(AObj, 'gIBSUF');
  if LObj <> nil then
    Result.fpgIBSUF := TIBSUFTotal.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gIBSMun');
  if LObj <> nil then
    Result.fpgIBSMun := TIBSMunTotal.FromJSON(LObj);

  Result.fpVIBS := JSONGetFloat(AObj, 'vIBS');
  Result.fpVCredPres := JSONGetFloat(AObj, 'vCredPres');
  Result.fpVCredPresCondSus := JSONGetFloat(AObj, 'vCredPresCondSus');
end;

{ TCBSTotal }

class function TCBSTotal.FromJSON(AObj: TJSONObject): TCBSTotal;
begin
  Result := TCBSTotal.Create;
  if AObj = nil then
    Exit;

  Result.fpVDif := JSONGetFloat(AObj, 'vDif');
  Result.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
  Result.fpVCBS := JSONGetFloat(AObj, 'vCBS');
  Result.fpVCredPres := JSONGetFloat(AObj, 'vCredPres');
  Result.fpVCredPresCondSus := JSONGetFloat(AObj, 'vCredPresCondSus');
end;

{ TIBSCBSTotal }

destructor TIBSCBSTotal.Destroy;
begin
  FreeAndNil(fpgIBS);
  FreeAndNil(fpgCBS);
  inherited Destroy;
end;

class function TIBSCBSTotal.FromJSON(AObj: TJSONObject): TIBSCBSTotal;
var
  LObj: TJSONObject;
begin
  Result := TIBSCBSTotal.Create;
  if AObj = nil then
    Exit;

  Result.fpVBCIBSCBS := JSONGetFloat(AObj, 'vBCIBSCBS');

  LObj := SafeGetObj(AObj, 'gIBS');
  if LObj <> nil then
    Result.fpgIBS := TIBSTotal.FromJSON(LObj);

  LObj := SafeGetObj(AObj, 'gCBS');
  if LObj <> nil then
    Result.fpgCBS := TCBSTotal.FromJSON(LObj);
end;

end.
