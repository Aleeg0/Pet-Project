program MainProject;

uses
  Vcl.Forms,
  BackendUnit in 'BackendUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
