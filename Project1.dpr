Program Project1;

uses
  Vcl.Forms,
  MainMenuUnit in 'MainMenuUnit.pas' {StartForm},
  InstructionUnit in 'InstructionUnit.pas' {InstructionForm},
  AboutTheDevelopersUnit in 'AboutTheDevelopersUnit.pas' {DeveloperForm},
  Vcl.Themes,
  Vcl.Styles,
  GameDictionaryUnit in 'Backend\GameDictionaryUnit.pas',
  GamerUnit in 'Backend\GamerUnit.pas',
  LetterBankUnit in 'Backend\LetterBankUnit.pas',
  StartUnit in 'Backend\StartUnit.pas',
  ExitUnit in 'FormUiKit\ExitUnit.pas' {ExitForm},
  fiftyForFiftyUnit in 'FormUiKit\fiftyForFiftyUnit.pas' {FiftyForFiftyForm},
  FriendsHelpUnit in 'FormUiKit\FriendsHelpUnit.pas' {FriendsHelpForm},
  GamerPoints in 'FormUiKit\GamerPoints.pas' {PointsListForm},
  GameUnit in 'FormUiKit\GameUnit.pas' {GameForm},
  QuitUnit in 'FormUiKit\QuitUnit.pas' {QuitForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    TStyleManager.TrySetStyle('Tablet Dark');
    Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TInstructionForm, InstructionForm);
  Application.CreateForm(TDeveloperForm, DeveloperForm);
  Application.CreateForm(TExitForm, ExitForm);
  Application.CreateForm(TFiftyForFiftyForm, FiftyForFiftyForm);
  Application.CreateForm(TFriendsHelpForm, FriendsHelpForm);
  Application.CreateForm(TPointsListForm, PointsListForm);
  Application.CreateForm(TGameForm, GameForm);
  Application.CreateForm(TQuitForm, QuitForm);
  Application.Run;

End.
