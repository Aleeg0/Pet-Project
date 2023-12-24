Program Project1;

uses
  Vcl.Forms,
  MainMenuUnit in 'MainMenuUnit.pas' {StartForm},
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  AboutTheDevelopersUnit in 'AboutTheDevelopersUnit.pas' {DeveloperForm},
  BackendGameDictionaryUnit in '..\Backend\BackendGameDictionaryUnit.pas',
  BackendGamerUnit in '..\Backend\BackendGamerUnit.pas',
  BackendLetterBankUnit in '..\Backend\BackendLetterBankUnit.pas',
  GameUnit in '..\Other Forms\LastForms\GameUnit.pas' {GameForm},
  FriendsHelpUnit in '..\Other Forms\LastForms\FriendsHelpUnit.pas' {FriendsHelpForm},
  fiftyForFiftyUnit in '..\Other Forms\LastForms\fiftyForFiftyUnit.pas' {FiftyForFiftyForm},
  BackendStartUnit in '..\Backend\BackendStartUnit.pas';

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.CreateForm(TFriendsHelpForm, FriendsHelpForm);
  Application.CreateForm(TFiftyForFiftyForm, FiftyForFiftyForm);
  Application.Run;

End.
