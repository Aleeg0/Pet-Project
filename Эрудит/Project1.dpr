program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {StartForm},
  Unit2 in 'Unit2.pas' {InstructionForm},
  Unit3 in 'Unit3.pas' {DeveloperForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.Run;
end.
