Program Project1;

Uses
    Vcl.Forms,
    MainMenuUnit In 'MainMenuUnit.pas' {StartForm} ,
    InstructionUnit In 'InstructionUnit.pas' {InstructionForm} ,
    AboutTheDevelopersUnit In 'AboutTheDevelopersUnit.pas' {DeveloperForm} ,
    BackendGameDictionaryUnit In '..\Backend\BackendGameDictionaryUnit.pas',
    BackendGamerUnit In '..\Backend\BackendGamerUnit.pas',
    BackendLetterBankUnit In '..\Backend\BackendLetterBankUnit.pas',
    GameUnit In '..\Other Forms\LastForms\GameUnit.pas' {GameForm} ,
    FriendsHelpUnit
        In '..\Other Forms\LastForms\FriendsHelpUnit.pas' {FriendsHelpForm} ,
    FiftyForFiftyUnit
        In '..\Other Forms\LastForms\fiftyForFiftyUnit.pas' {FiftyForFiftyForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    //Application.CreateForm(TGameForm, GameForm);
    Application.CreateForm(TStartForm, StartForm);
    Application.CreateForm(TInstructionForm, InstructionForm);
    Application.CreateForm(TDeveloperForm, DeveloperForm);
    Application.CreateForm(TFriendsHelpForm, FriendsHelpForm);
    Application.CreateForm(TFiftyForFiftyForm, FiftyForFiftyForm);
    Application.Run;

End.
