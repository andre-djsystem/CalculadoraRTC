unit CalculadoraRTC.Schemas.ROC.IBSCBS;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpjson,
  CalculadoraRTC.Utils.JSON;

type
  IROCDiferimento = interface
    ['{8C1F6F65-7D4A-4B75-9A3C-2B8B0C4E0D11}']
    function PDif: Double; // pDif
    function VDif: Double; // vDif
    function ToJSON: TJSONObject;
  end;

  IROCDevolucaoTributos = interface
    ['{6E0D4B5B-386C-4F0E-9D8E-AD5D7B3A0F20}']
    function VDevTrib: Double; // vDevTrib
    function ToJSON: TJSONObject;
  end;

  IROCReducaoAliquota = interface
    ['{C6F794D3-1C71-4C1E-88E5-DF31C9D57F05}']
    function PRedAliq: Double;  // pRedAliq
    function PAliqEfet: Double; // pAliqEfet
    function ToJSON: TJSONObject;
  end;

  IROCCreditoPresumido = interface
    ['{0A6A64D0-2F68-4A8B-8B31-4C6B0E8E20C3}']
    function CCredPres: Integer;       // cCredPres
    function PCredPres: Double;        // pCredPres
    function VCredPres: Double;        // vCredPres
    function VCredPresCondSus: Double; // vCredPresCondSus
    function ToJSON: TJSONObject;
  end;

  IROCCreditoPresumidoIBSZFM = interface
    ['{8E9941F7-8750-494D-9111-069AD0E9E8B9}']
    function TpCredPresIBSZFM: Integer; // tpCredPresIBSZFM
    function VCredPresIBSZFM: Double;   // vCredPresIBSZFM
    function ToJSON: TJSONObject;
  end;

  IROCTransferenciaCredito = interface
    ['{F5AA7F1F-5C4D-4F9E-A8E4-5B0D7B7AE2F2}']
    function VIBS: Double; // vIBS
    function VCBS: Double; // vCBS
    function ToJSON: TJSONObject;
  end;

  IROCTributacaoCompraGovernamental = interface
    ['{0B7C0D1A-8B9A-4B2A-8CFF-1D4A4F7E3193}']
    function PAliqIBSUF: Double;   // pAliqIBSUF
    function VTribIBSUF: Double;   // vTribIBSUF
    function PAliqIBSMun: Double;  // pAliqIBSMun
    function VTribIBSMun: Double;  // vTribIBSMun
    function PAliqCBS: Double;     // pAliqCBS
    function VTribCBS: Double;     // vTribCBS
    function ToJSON: TJSONObject;
  end;

  IROCIBSUF = interface
    ['{E2B5F8A1-9F02-4C34-9B26-9B0C5E22C4E1}']
    function PIBSUF: Double;                         // pIBSUF
    function GDif: IROCDiferimento;                  // gDif
    function GDevTrib: IROCDevolucaoTributos;        // gDevTrib
    function GRed: IROCReducaoAliquota;              // gRed
    function VIBSUF: Double;                         // vIBSUF
    function MemoriaCalculo: string;                 // memoriaCalculo
    function ToJSON: TJSONObject;
  end;

  IROCIBSMun = interface
    ['{B6F4B0CF-57A5-4F5C-A6F1-59C63C99A1D8}']
    function PIBSMun: Double;                        // pIBSMun
    function GDif: IROCDiferimento;                  // gDif
    function GDevTrib: IROCDevolucaoTributos;        // gDevTrib
    function GRed: IROCReducaoAliquota;              // gRed
    function VIBSMun: Double;                        // vIBSMun
    function MemoriaCalculo: string;                 // memoriaCalculo
    function ToJSON: TJSONObject;
  end;

  IROCCBS = interface
    ['{3D8C5A2D-7F2E-4AA5-8B9C-4B7E0E5AA25E}']
    function PCBS: Double;                           // pCBS
    function GDif: IROCDiferimento;                  // gDif
    function GDevTrib: IROCDevolucaoTributos;        // gDevTrib
    function GRed: IROCReducaoAliquota;              // gRed
    function VCBS: Double;                           // vCBS
    function MemoriaCalculo: string;                 // memoriaCalculo
    function ToJSON: TJSONObject;
  end;

  IROCGrupoIBSCBS = interface
    ['{4A6F8A1B-4E10-4C5F-8A3F-EE0F2B9D62E6}']
    function VBC: Double;                                     // vBC
    function GIBSUF: IROCIBSUF;                               // gIBSUF
    function GIBSMun: IROCIBSMun;                             // gIBSMun
    function GCBS: IROCCBS;                                   // gCBS
    function GIBSCredPres: IROCCreditoPresumido;              // gIBSCredPres
    function GCBSCredPres: IROCCreditoPresumido;              // gCBSCredPres
    function GTribCompraGov: IROCTributacaoCompraGovernamental;// gTribCompraGov
    function ToJSON: TJSONObject;
  end;

  IROCMonofasia = interface
    ['{8F5D6D28-24D0-4D7B-87D6-24C38C6A2A77}']
    function QBCMono: Double;        // qBCMono
    function AdRemIBS: Double;       // adRemIBS
    function AdRemCBS: Double;       // adRemCBS
    function VIBSMono: Double;       // vIBSMono
    function VCBSMono: Double;       // vCBSMono
    function VIBSMonoDif: Double;    // vIBSMonoDif
    function VCBSMonoDif: Double;    // vCBSMonoDif
    function VTotIBSMonoItem: Double;// vTotIBSMonoItem
    function VTotCBSMonoItem: Double;// vTotCBSMonoItem
    function ToJSON: TJSONObject;
  end;

  IROCIBSCBS = interface
    ['{3C8B7E61-EB0A-4B6A-8D5A-1A31C3F3E66B}']
    function CST: Integer;                              // CST (pode vir "000" em string na API; convertemos)
    function CClassTrib: string;                        // cClassTrib
    function GIBSCBS: IROCGrupoIBSCBS;                  // gIBSCBS
    function GIBSCBSMono: IROCMonofasia;                // gIBSCBSMono
    function GTransfCred: IROCTransferenciaCredito;     // gTransfCred
    function GCredPresIBSZFM: IROCCreditoPresumidoIBSZFM;// gCredPresIBSZFM
    function ToJSON: TJSONObject;
  end;

  TROC_Diferimento = class(TInterfacedObject, IROCDiferimento)
  private
    fpPDif: Double;
    fpVDif: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCDiferimento; static;
    function PDif: Double;
    function VDif: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_DevTrib = class(TInterfacedObject, IROCDevolucaoTributos)
  private
    fpVDevTrib: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCDevolucaoTributos; static;
    function VDevTrib: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_ReducaoAliq = class(TInterfacedObject, IROCReducaoAliquota)
  private
    fpPRedAliq: Double;
    fpPAliqEfet: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCReducaoAliquota; static;
    function PRedAliq: Double;
    function PAliqEfet: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_CredPres = class(TInterfacedObject, IROCCreditoPresumido)
  private
    fpCCredPres: Integer;
    fpPCredPres: Double;
    fpVCredPres: Double;
    fpVCredPresCondSus: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCCreditoPresumido; static;
    function CCredPres: Integer;
    function PCredPres: Double;
    function VCredPres: Double;
    function VCredPresCondSus: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_CredPresIBSZFM = class(TInterfacedObject, IROCCreditoPresumidoIBSZFM)
  private
    fpTpCredPresIBSZFM: Integer;
    fpVCredPresIBSZFM: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCCreditoPresumidoIBSZFM; static;
    function TpCredPresIBSZFM: Integer;
    function VCredPresIBSZFM: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_TransfCred = class(TInterfacedObject, IROCTransferenciaCredito)
  private
    fpVIBS: Double;
    fpVCBS: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTransferenciaCredito; static;
    function VIBS: Double;
    function VCBS: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_TribCompraGov = class(TInterfacedObject, IROCTributacaoCompraGovernamental)
  private
    fpPAliqIBSUF: Double;
    fpVTribIBSUF: Double;
    fpPAliqIBSMun: Double;
    fpVTribIBSMun: Double;
    fpPAliqCBS: Double;
    fpVTribCBS: Double;
  public
    class function FromJSON(AObj: TJSONObject): IROCTributacaoCompraGovernamental; static;
    function PAliqIBSUF: Double;
    function VTribIBSUF: Double;
    function PAliqIBSMun: Double;
    function VTribIBSMun: Double;
    function PAliqCBS: Double;
    function VTribCBS: Double;
    function ToJSON: TJSONObject;
  end;

  TROC_IBSUF = class(TInterfacedObject, IROCIBSUF)
  private
    fpPIBSUF: Double;
    fpGDif: IROCDiferimento;
    fpGDevTrib: IROCDevolucaoTributos;
    fpGRed: IROCReducaoAliquota;
    fpVIBSUF: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): IROCIBSUF; static;
    function PIBSUF: Double;
    function GDif: IROCDiferimento;
    function GDevTrib: IROCDevolucaoTributos;
    function GRed: IROCReducaoAliquota;
    function VIBSUF: Double;
    function MemoriaCalculo: string;
    function ToJSON: TJSONObject;
  end;

  TROC_IBSMun = class(TInterfacedObject, IROCIBSMun)
  private
    fpPIBSMun: Double;
    fpGDif: IROCDiferimento;
    fpGDevTrib: IROCDevolucaoTributos;
    fpGRed: IROCReducaoAliquota;
    fpVIBSMun: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): IROCIBSMun; static;
    function PIBSMun: Double;
    function GDif: IROCDiferimento;
    function GDevTrib: IROCDevolucaoTributos;
    function GRed: IROCReducaoAliquota;
    function VIBSMun: Double;
    function MemoriaCalculo: string;
    function ToJSON: TJSONObject;
  end;

  TROC_CBS = class(TInterfacedObject, IROCCBS)
  private
    fpPCBS: Double;
    fpGDif: IROCDiferimento;
    fpGDevTrib: IROCDevolucaoTributos;
    fpGRed: IROCReducaoAliquota;
    fpVCBS: Double;
    fpMemoriaCalculo: string;
  public
    class function FromJSON(AObj: TJSONObject): IROCCBS; static;
    function PCBS: Double;
    function GDif: IROCDiferimento;
    function GDevTrib: IROCDevolucaoTributos;
    function GRed: IROCReducaoAliquota;
    function VCBS: Double;
    function MemoriaCalculo: string;
    function ToJSON: TJSONObject;
  end;

  TROC_GrupoIBSCBS = class(TInterfacedObject, IROCGrupoIBSCBS)
  private
    fpVBC: Double;
    fpGIBSUF: IROCIBSUF;
    fpGIBSMun: IROCIBSMun;
    fpGCBS: IROCCBS;
    fpGIBSCredPres: IROCCreditoPresumido;
    fpGCBSCredPres: IROCCreditoPresumido;
    fpGTribCompraGov: IROCTributacaoCompraGovernamental;
  public
    class function FromJSON(AObj: TJSONObject): IROCGrupoIBSCBS; static;
    function VBC: Double;
    function GIBSUF: IROCIBSUF;
    function GIBSMun: IROCIBSMun;
    function GCBS: IROCCBS;
    function GIBSCredPres: IROCCreditoPresumido;
    function GCBSCredPres: IROCCreditoPresumido;
    function GTribCompraGov: IROCTributacaoCompraGovernamental;
    function ToJSON: TJSONObject;
  end;

  TROC_Monofasia = class(TInterfacedObject, IROCMonofasia)
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
    class function FromJSON(AObj: TJSONObject): IROCMonofasia; static;
    function QBCMono: Double;
    function AdRemIBS: Double;
    function AdRemCBS: Double;
    function VIBSMono: Double;
    function VCBSMono: Double;
    function VIBSMonoDif: Double;
    function VCBSMonoDif: Double;
    function VTotIBSMonoItem: Double;
    function VTotCBSMonoItem: Double;
    function ToJSON: TJSONObject;
  end;

  TROCIBSCBSGroup = class(TInterfacedObject, IROCIBSCBS)
  private
    fpCST: Integer;
    fpCClassTrib: string;
    fpGIBSCBS: IROCGrupoIBSCBS;
    fpGIBSCBSMono: IROCMonofasia;
    fpGTransfCred: IROCTransferenciaCredito;
    fpGCredPresIBSZFM: IROCCreditoPresumidoIBSZFM;
  public
    class function FromJSON(AObj: TJSONObject): IROCIBSCBS; static;
    function CST: Integer;
    function CClassTrib: string;
    function GIBSCBS: IROCGrupoIBSCBS;
    function GIBSCBSMono: IROCMonofasia;
    function GTransfCred: IROCTransferenciaCredito;
    function GCredPresIBSZFM: IROCCreditoPresumidoIBSZFM;
    function ToJSON: TJSONObject;
  end;

implementation

class function TROC_Diferimento.FromJSON(AObj: TJSONObject): IROCDiferimento;
var
  L: TROC_Diferimento;
begin
  L := TROC_Diferimento.Create;
  if AObj <> nil then
  begin
    L.fpPDif := JSONGetFloat(AObj, 'pDif');
    L.fpVDif := JSONGetFloat(AObj, 'vDif');
  end;
  Result := L;
end;

function TROC_Diferimento.PDif: Double; begin Result := fpPDif; end;
function TROC_Diferimento.VDif: Double; begin Result := fpVDif; end;

function TROC_Diferimento.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pDif', JFloat(fpPDif));
  Result.Add('vDif', JFloat(fpVDif));
end;

class function TROC_DevTrib.FromJSON(AObj: TJSONObject): IROCDevolucaoTributos;
var
  L: TROC_DevTrib;
begin
  L := TROC_DevTrib.Create;
  if AObj <> nil then
    L.fpVDevTrib := JSONGetFloat(AObj, 'vDevTrib');
  Result := L;
end;

function TROC_DevTrib.VDevTrib: Double; begin Result := fpVDevTrib; end;

function TROC_DevTrib.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vDevTrib', JFloat(fpVDevTrib));
end;

class function TROC_ReducaoAliq.FromJSON(AObj: TJSONObject): IROCReducaoAliquota;
var
  L: TROC_ReducaoAliq;
begin
  L := TROC_ReducaoAliq.Create;
  if AObj <> nil then
  begin
    L.fpPRedAliq := JSONGetFloat(AObj, 'pRedAliq');
    L.fpPAliqEfet := JSONGetFloat(AObj, 'pAliqEfet');
  end;
  Result := L;
end;

function TROC_ReducaoAliq.PRedAliq: Double;
begin
  Result := fpPRedAliq;
end;

function TROC_ReducaoAliq.PAliqEfet: Double;
begin
  Result := fpPAliqEfet;
end;

function TROC_ReducaoAliq.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pRedAliq', JFloat(fpPRedAliq));
  Result.Add('pAliqEfet', JFloat(fpPAliqEfet));
end;

class function TROC_CredPres.FromJSON(AObj: TJSONObject): IROCCreditoPresumido;
var
  L: TROC_CredPres;
begin
  L := TROC_CredPres.Create;
  if AObj <> nil then
  begin
    L.fpCCredPres := JSONGetInt(AObj, 'cCredPres');
    L.fpPCredPres := JSONGetFloat(AObj, 'pCredPres');
    L.fpVCredPres := JSONGetFloat(AObj, 'vCredPres');
    L.fpVCredPresCondSus := JSONGetFloat(AObj, 'vCredPresCondSus');
  end;
  Result := L;
end;

function TROC_CredPres.CCredPres: Integer;
begin
  Result := fpCCredPres;
end;

function TROC_CredPres.PCredPres: Double;
begin
  Result := fpPCredPres;
end;

function TROC_CredPres.VCredPres: Double;
begin
  Result := fpVCredPres;
end;

function TROC_CredPres.VCredPresCondSus: Double;
begin
  Result := fpVCredPresCondSus;
end;

function TROC_CredPres.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('cCredPres', fpCCredPres);
  Result.Add('pCredPres', JFloat(fpPCredPres));
  Result.Add('vCredPres', JFloat(fpVCredPres));
  Result.Add('vCredPresCondSus', JFloat(fpVCredPresCondSus));
end;

class function TROC_CredPresIBSZFM.FromJSON(AObj: TJSONObject): IROCCreditoPresumidoIBSZFM;
var
  L: TROC_CredPresIBSZFM;
begin
  L := TROC_CredPresIBSZFM.Create;
  if AObj <> nil then
  begin
    L.fpTpCredPresIBSZFM := JSONGetInt(AObj, 'tpCredPresIBSZFM');
    L.fpVCredPresIBSZFM  := JSONGetFloat(AObj, 'vCredPresIBSZFM');
  end;
  Result := L;
end;

function TROC_CredPresIBSZFM.TpCredPresIBSZFM: Integer; begin Result := fpTpCredPresIBSZFM; end;
function TROC_CredPresIBSZFM.VCredPresIBSZFM: Double;   begin Result := fpVCredPresIBSZFM; end;

function TROC_CredPresIBSZFM.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('tpCredPresIBSZFM', fpTpCredPresIBSZFM);
  Result.Add('vCredPresIBSZFM', JFloat(fpVCredPresIBSZFM));
end;

class function TROC_TransfCred.FromJSON(AObj: TJSONObject): IROCTransferenciaCredito;
var
  L: TROC_TransfCred;
begin
  L := TROC_TransfCred.Create;
  if AObj <> nil then
  begin
    L.fpVIBS := JSONGetFloat(AObj, 'vIBS');
    L.fpVCBS := JSONGetFloat(AObj, 'vCBS');
  end;
  Result := L;
end;

function TROC_TransfCred.VIBS: Double;
begin
  Result := fpVIBS;
end;

function TROC_TransfCred.VCBS: Double;
begin
  Result := fpVCBS;
end;

function TROC_TransfCred.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vIBS', JFloat(fpVIBS));
  Result.Add('vCBS', JFloat(fpVCBS));
end;

class function TROC_TribCompraGov.FromJSON(AObj: TJSONObject): IROCTributacaoCompraGovernamental;
var
  L: TROC_TribCompraGov;
begin
  L := TROC_TribCompraGov.Create;
  if AObj <> nil then
  begin
    L.fpPAliqIBSUF := JSONGetFloat(AObj, 'pAliqIBSUF');
    L.fpVTribIBSUF := JSONGetFloat(AObj, 'vTribIBSUF');
    L.fpPAliqIBSMun := JSONGetFloat(AObj, 'pAliqIBSMun');
    L.fpVTribIBSMun := JSONGetFloat(AObj, 'vTribIBSMun');
    L.fpPAliqCBS := JSONGetFloat(AObj, 'pAliqCBS');
    L.fpVTribCBS := JSONGetFloat(AObj, 'vTribCBS');
  end;
  Result := L;
end;

function TROC_TribCompraGov.PAliqIBSUF: Double;
begin
  Result := fpPAliqIBSUF;
end;

function TROC_TribCompraGov.VTribIBSUF: Double;
begin
  Result := fpVTribIBSUF;
end;

function TROC_TribCompraGov.PAliqIBSMun: Double;
begin
  Result := fpPAliqIBSMun;
end;

function TROC_TribCompraGov.VTribIBSMun: Double;
begin
  Result := fpVTribIBSMun;
end;

function TROC_TribCompraGov.PAliqCBS: Double;
begin
  Result := fpPAliqCBS;
end;

function TROC_TribCompraGov.VTribCBS: Double;
begin
  Result := fpVTribCBS;
end;

function TROC_TribCompraGov.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pAliqIBSUF', JFloat(fpPAliqIBSUF));
  Result.Add('vTribIBSUF', JFloat(fpVTribIBSUF));
  Result.Add('pAliqIBSMun', JFloat(fpPAliqIBSMun));
  Result.Add('vTribIBSMun', JFloat(fpVTribIBSMun));
  Result.Add('pAliqCBS', JFloat(fpPAliqCBS));
  Result.Add('vTribCBS', JFloat(fpVTribCBS));
end;

class function TROC_IBSUF.FromJSON(AObj: TJSONObject): IROCIBSUF;
var
  L: TROC_IBSUF;
  S: TJSONObject;
begin
  L := TROC_IBSUF.Create;
  if AObj <> nil then
  begin
    L.fpPIBSUF := JSONGetFloat(AObj, 'pIBSUF');
    S := SafeGetObj(AObj, 'gDif');
    if S <> nil then
      L.fpGDif := TROC_Diferimento.FromJSON(S);
    S := SafeGetObj(AObj, 'gDevTrib');
    if S <> nil then
      L.fpGDevTrib := TROC_DevTrib.FromJSON(S);
    S := SafeGetObj(AObj, 'gRed');
    if S <> nil then
      L.fpGRed := TROC_ReducaoAliq.FromJSON(S);
    L.fpVIBSUF := JSONGetFloat(AObj, 'vIBSUF');
    L.fpMemoriaCalculo := JSONGetString(AObj, 'memoriaCalculo', '');
  end;
  Result := L;
end;

function TROC_IBSUF.PIBSUF: Double;
begin
  Result := fpPIBSUF;
end;

function TROC_IBSUF.GDif: IROCDiferimento;
begin
  Result := fpGDif;
end;

function TROC_IBSUF.GDevTrib: IROCDevolucaoTributos;
begin
  Result := fpGDevTrib;
end;

function TROC_IBSUF.GRed: IROCReducaoAliquota;
begin
  Result := fpGRed;
end;

function TROC_IBSUF.VIBSUF: Double;
begin
  Result := fpVIBSUF;
end;

function TROC_IBSUF.MemoriaCalculo: string;
begin
  Result := fpMemoriaCalculo;
end;

function TROC_IBSUF.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pIBSUF', JFloat(fpPIBSUF));
  if fpGDif <> nil then
    Result.Add('gDif', fpGDif.ToJSON);
  if fpGDevTrib <> nil then
    Result.Add('gDevTrib', fpGDevTrib.ToJSON);
  if fpGRed <> nil then
    Result.Add('gRed', fpGRed.ToJSON);
  Result.Add('vIBSUF', JFloat(fpVIBSUF));
  Result.Add('memoriaCalculo', fpMemoriaCalculo);
end;

class function TROC_IBSMun.FromJSON(AObj: TJSONObject): IROCIBSMun;
var
  L: TROC_IBSMun;
  S: TJSONObject;
begin
  L := TROC_IBSMun.Create;
  if AObj <> nil then
  begin
    L.fpPIBSMun := JSONGetFloat(AObj, 'pIBSMun');
    S := SafeGetObj(AObj, 'gDif');
    if S <> nil then
    L.fpGDif := TROC_Diferimento.FromJSON(S);
      S := SafeGetObj(AObj, 'gDevTrib');
    if S <> nil then
    L.fpGDevTrib := TROC_DevTrib.FromJSON(S);
      S := SafeGetObj(AObj, 'gRed');
    if S <> nil then
      L.fpGRed := TROC_ReducaoAliq.FromJSON(S);
    L.fpVIBSMun := JSONGetFloat(AObj, 'vIBSMun');
    L.fpMemoriaCalculo := JSONGetString(AObj, 'memoriaCalculo', '');
  end;
  Result := L;
end;

function TROC_IBSMun.PIBSMun: Double;
begin
  Result := fpPIBSMun;
end;

function TROC_IBSMun.GDif: IROCDiferimento;
begin
  Result := fpGDif;
end;

function TROC_IBSMun.GDevTrib: IROCDevolucaoTributos;
begin
  Result := fpGDevTrib;
end;

function TROC_IBSMun.GRed: IROCReducaoAliquota;
begin
  Result := fpGRed;
end;

function TROC_IBSMun.VIBSMun: Double;
begin
  Result := fpVIBSMun;
end;

function TROC_IBSMun.MemoriaCalculo: string;
begin
  Result := fpMemoriaCalculo;
end;

function TROC_IBSMun.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pIBSMun', JFloat(fpPIBSMun));
  if fpGDif <> nil then
    Result.Add('gDif', fpGDif.ToJSON);
  if fpGDevTrib <> nil then
    Result.Add('gDevTrib', fpGDevTrib.ToJSON);
  if fpGRed <> nil then
    Result.Add('gRed', fpGRed.ToJSON);
  Result.Add('vIBSMun', JFloat(fpVIBSMun));
  Result.Add('memoriaCalculo', fpMemoriaCalculo);
end;

class function TROC_CBS.FromJSON(AObj: TJSONObject): IROCCBS;
var
  L: TROC_CBS;
  S: TJSONObject;
begin
  L := TROC_CBS.Create;
  if AObj <> nil then
  begin
    L.fpPCBS := JSONGetFloat(AObj, 'pCBS');
    S := SafeGetObj(AObj, 'gDif');
    if S <> nil then
      L.fpGDif := TROC_Diferimento.FromJSON(S);
    S := SafeGetObj(AObj, 'gDevTrib');
    if S <> nil then
      L.fpGDevTrib := TROC_DevTrib.FromJSON(S);
    S := SafeGetObj(AObj, 'gRed');
    if S <> nil then
      L.fpGRed := TROC_ReducaoAliq.FromJSON(S);
    L.fpVCBS := JSONGetFloat(AObj, 'vCBS');
    L.fpMemoriaCalculo := JSONGetString(AObj, 'memoriaCalculo', '');
  end;
  Result := L;
end;

function TROC_CBS.PCBS: Double;
begin
  Result := fpPCBS;
end;

function TROC_CBS.GDif: IROCDiferimento;
begin
  Result := fpGDif;
end;

function TROC_CBS.GDevTrib: IROCDevolucaoTributos;
begin
  Result := fpGDevTrib;
end;

function TROC_CBS.GRed: IROCReducaoAliquota;
begin
  Result := fpGRed;
end;

function TROC_CBS.VCBS: Double;
begin
  Result := fpVCBS;
end;

function TROC_CBS.MemoriaCalculo: string;
begin
  Result := fpMemoriaCalculo;
end;

function TROC_CBS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('pCBS', JFloat(fpPCBS));
  if fpGDif <> nil then
    Result.Add('gDif', fpGDif.ToJSON);
  if fpGDevTrib <> nil then
    Result.Add('gDevTrib', fpGDevTrib.ToJSON);
  if fpGRed <> nil then
    Result.Add('gRed', fpGRed.ToJSON);
  Result.Add('vCBS', JFloat(fpVCBS));
  Result.Add('memoriaCalculo', fpMemoriaCalculo);
end;

class function TROC_GrupoIBSCBS.FromJSON(AObj: TJSONObject): IROCGrupoIBSCBS;
var
  L: TROC_GrupoIBSCBS;
  S: TJSONObject;
begin
  L := TROC_GrupoIBSCBS.Create;
  if AObj <> nil then
  begin
    L.fpVBC := JSONGetFloat(AObj, 'vBC');

    S := SafeGetObj(AObj, 'gIBSUF');
    if S <> nil then
      L.fpGIBSUF := TROC_IBSUF.FromJSON(S);

    S := SafeGetObj(AObj, 'gIBSMun');
    if S <> nil then
      L.fpGIBSMun := TROC_IBSMun.FromJSON(S);

    S := SafeGetObj(AObj, 'gCBS');
    if S <> nil then
      L.fpGCBS := TROC_CBS.FromJSON(S);

    S := SafeGetObj(AObj, 'gIBSCredPres');
    if S <> nil then
      L.fpGIBSCredPres := TROC_CredPres.FromJSON(S);

    S := SafeGetObj(AObj, 'gCBSCredPres');
    if S <> nil then
      L.fpGCBSCredPres := TROC_CredPres.FromJSON(S);

    S := SafeGetObj(AObj, 'gTribCompraGov');
    if S <> nil then
      L.fpGTribCompraGov := TROC_TribCompraGov.FromJSON(S);
  end;
  Result := L;
end;

function TROC_GrupoIBSCBS.VBC: Double;
begin
  Result := fpVBC;
end;

function TROC_GrupoIBSCBS.GIBSUF: IROCIBSUF;
begin
  Result := fpGIBSUF;
end;

function TROC_GrupoIBSCBS.GIBSMun: IROCIBSMun;
begin
  Result := fpGIBSMun;
end;

function TROC_GrupoIBSCBS.GCBS: IROCCBS;
begin
  Result := fpGCBS;
end;

function TROC_GrupoIBSCBS.GIBSCredPres: IROCCreditoPresumido;
begin
  Result := fpGIBSCredPres;
end;

function TROC_GrupoIBSCBS.GCBSCredPres: IROCCreditoPresumido;
begin
  Result := fpGCBSCredPres;
end;

function TROC_GrupoIBSCBS.GTribCompraGov: IROCTributacaoCompraGovernamental;
begin
  Result := fpGTribCompraGov;
end;

function TROC_GrupoIBSCBS.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('vBC', JFloat(fpVBC));
  if fpGIBSUF <> nil then
    Result.Add('gIBSUF', fpGIBSUF.ToJSON);
  if fpGIBSMun <> nil then
    Result.Add('gIBSMun', fpGIBSMun.ToJSON);
  if fpGCBS <> nil then
    Result.Add('gCBS', fpGCBS.ToJSON);
  if fpGIBSCredPres <> nil then
    Result.Add('gIBSCredPres', fpGIBSCredPres.ToJSON);
  if fpGCBSCredPres <> nil then
    Result.Add('gCBSCredPres', fpGCBSCredPres.ToJSON);
  if fpGTribCompraGov <> nil then
    Result.Add('gTribCompraGov', fpGTribCompraGov.ToJSON);
end;

class function TROC_Monofasia.FromJSON(AObj: TJSONObject): IROCMonofasia;
var
  L: TROC_Monofasia;
begin
  L := TROC_Monofasia.Create;
  if AObj <> nil then
  begin
    L.fpQBCMono := JSONGetFloat(AObj, 'qBCMono');
    L.fpAdRemIBS := JSONGetFloat(AObj, 'adRemIBS');
    L.fpAdRemCBS := JSONGetFloat(AObj, 'adRemCBS');
    L.fpVIBSMono := JSONGetFloat(AObj, 'vIBSMono');
    L.fpVCBSMono := JSONGetFloat(AObj, 'vCBSMono');
    L.fpVIBSMonoDif := JSONGetFloat(AObj, 'vIBSMonoDif');
    L.fpVCBSMonoDif := JSONGetFloat(AObj, 'vCBSMonoDif');
    L.fpVTotIBSMonoItem := JSONGetFloat(AObj, 'vTotIBSMonoItem');
    L.fpVTotCBSMonoItem := JSONGetFloat(AObj, 'vTotCBSMonoItem');
  end;
  Result := L;
end;

function TROC_Monofasia.QBCMono: Double;
begin
  Result := fpQBCMono;
end;

function TROC_Monofasia.AdRemIBS: Double;
begin
  Result := fpAdRemIBS;
end;

function TROC_Monofasia.AdRemCBS: Double;
begin
  Result := fpAdRemCBS;
end;

function TROC_Monofasia.VIBSMono: Double;
begin
  Result := fpVIBSMono;
end;

function TROC_Monofasia.VCBSMono: Double;
begin
  Result := fpVCBSMono;
end;

function TROC_Monofasia.VIBSMonoDif: Double;
begin
  Result := fpVIBSMonoDif;
end;

function TROC_Monofasia.VCBSMonoDif: Double;
begin
  Result := fpVCBSMonoDif;
end;

function TROC_Monofasia.VTotIBSMonoItem: Double;
begin
  Result := fpVTotIBSMonoItem;
end;

function TROC_Monofasia.VTotCBSMonoItem: Double;
begin
  Result := fpVTotCBSMonoItem;
end;

function TROC_Monofasia.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('qBCMono', JFloat(fpQBCMono));
  Result.Add('adRemIBS', JFloat(fpAdRemIBS));
  Result.Add('adRemCBS', JFloat(fpAdRemCBS));
  Result.Add('vIBSMono', JFloat(fpVIBSMono));
  Result.Add('vCBSMono', JFloat(fpVCBSMono));
  Result.Add('vIBSMonoDif', JFloat(fpVIBSMonoDif));
  Result.Add('vCBSMonoDif', JFloat(fpVCBSMonoDif));
  Result.Add('vTotIBSMonoItem', JFloat(fpVTotIBSMonoItem));
  Result.Add('vTotCBSMonoItem', JFloat(fpVTotCBSMonoItem));
end;

class function TROCIBSCBSGroup.FromJSON(AObj: TJSONObject): IROCIBSCBS;
var
  L: TROCIBSCBSGroup;
  S: TJSONObject;
begin
  L := TROCIBSCBSGroup.Create;
  if AObj <> nil then
  begin
    // CST pode vir "000" -> convertemos com JSONGetInt (já lida com string/número)
    L.fpCST := JSONGetInt(AObj, 'CST');
    L.fpCClassTrib := JSONGetString(AObj, 'cClassTrib', '');

    S := SafeGetObj(AObj, 'gIBSCBS');
    if S <> nil then
      L.fpGIBSCBS := TROC_GrupoIBSCBS.FromJSON(S);

    S := SafeGetObj(AObj, 'gIBSCBSMono');
    if S <> nil then
      L.fpGIBSCBSMono := TROC_Monofasia.FromJSON(S);

    S := SafeGetObj(AObj, 'gTransfCred');
    if S <> nil then
      L.fpGTransfCred := TROC_TransfCred.FromJSON(S);

    S := SafeGetObj(AObj, 'gCredPresIBSZFM');
    if S <> nil then
      L.fpGCredPresIBSZFM := TROC_CredPresIBSZFM.FromJSON(S);
  end;
  Result := L;
end;

function TROCIBSCBSGroup.CST: Integer;
begin
  Result := fpCST;
end;

function TROCIBSCBSGroup.CClassTrib: string;
begin
  Result := fpCClassTrib;
end;

function TROCIBSCBSGroup.GIBSCBS: IROCGrupoIBSCBS;
begin
  Result := fpGIBSCBS;
end;

function TROCIBSCBSGroup.GIBSCBSMono: IROCMonofasia;
begin
  Result := fpGIBSCBSMono;
end;

function TROCIBSCBSGroup.GTransfCred: IROCTransferenciaCredito;
begin
  Result := fpGTransfCred;
end;

function TROCIBSCBSGroup.GCredPresIBSZFM: IROCCreditoPresumidoIBSZFM;
begin
  Result := fpGCredPresIBSZFM;
end;

function TROCIBSCBSGroup.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.Add('CST', fpCST);
  Result.Add('cClassTrib', fpCClassTrib);
  if fpGIBSCBS <> nil then
    Result.Add('gIBSCBS', fpGIBSCBS.ToJSON);
  if fpGIBSCBSMono <> nil then
    Result.Add('gIBSCBSMono', fpGIBSCBSMono.ToJSON);
  if fpGTransfCred <> nil then
    Result.Add('gTransfCred', fpGTransfCred.ToJSON);
  if fpGCredPresIBSZFM <> nil then
    Result.Add('gCredPresIBSZFM', fpGCredPresIBSZFM.ToJSON);
end;

end.

