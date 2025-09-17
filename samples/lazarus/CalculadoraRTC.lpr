program CalculadoraRTC;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, SysUtils, DateUtils, uPrincipal
  { you can add units after this };

{$R *.res}
var
  HeapTraceFile: String;

begin
  HeapTraceFile := ExtractFilePath(ParamStr(0))+ 'heaptrclog.trc' ;
  if FileExists(HeapTraceFile) then
  begin
    RenameFile( HeapTraceFile,  IntToStr(DateTimeToUnix(Now))+'-'+ HeapTraceFile );
    DeleteFile(HeapTraceFile);
  end;
  {$IFDEF DEBUGDJ}
    SetHeapTraceOutput( HeapTraceFile );
    GlobalSkipIfNoLeaks := True;
    quicktrace := false;
    HaltOnNotReleased := True;
    printleakedblock := True;
  {$ENDIF}

  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormCalcDemo, FormCalcDemo);
  Application.Run;
end.

