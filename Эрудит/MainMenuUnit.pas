Unit MainMenuUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus,
    AboutTheDevelopersUnit, InstructionUnit, GameUnit, BackendGamerUnit,
    BackendStartUnit;

Type
    TStartForm = Class(TForm)
        LanguageComboBox: TComboBox;
        TitleLabel: TLabel;
        TabsMainMenu: TMainMenu;
        InstructionTab: TMenuItem;
        DeveloperTab: TMenuItem;
        PlayersComboBox: TComboBox;
        PlayButton: TButton;
        LanguageLabel: TLabel;
        PlayersLabel: TLabel;
        Procedure InstructionTabOnClick(Sender: TObject);
        Procedure DeveloperTabOnClick(Sender: TObject);
        Procedure PlayButtonClick(Sender: TObject);
        Procedure LanguageComboBoxChange(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure PlayersComboBoxChange(Sender: TObject);
    procedure PlayersComboBoxClick(Sender: TObject);
    Private
    Public
    End;

Var
    StartForm: TStartForm;

Implementation

{$R *.dfm}

Procedure TStartForm.FormCreate(Sender: TObject);
Begin
    Start := TStart.Create();
End;

Procedure TStartForm.InstructionTabOnClick(Sender: TObject);
Var
    InstructionForm: TInstructionForm;
Begin
    InstructionForm := TInstructionForm.Create(Self);
    // InstructionForm.Icon := MainForm.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;

Procedure TStartForm.LanguageComboBoxChange(Sender: TObject);
Begin
    If LanguageComboBox.Items[LanguageComboBox.ItemIndex] = 'Русский' Then
        Start.SetLanguage(TLanguage.RUS)
    Else

        Start.SetLanguage(TLanguage.EN);
End;

Procedure TStartForm.PlayButtonClick(Sender: TObject);
Begin
    //StartForm.Visible := False;
    Application.CreateForm(TGameForm, GameForm);
    GameForm.ShowModal;
    GameForm.Destroy();
    StartForm.Visible := True;
End;

Procedure TStartForm.PlayersComboBoxChange(Sender: TObject);
Begin
    Start.SetPlayers(StrToInt(PlayersComboBox.Items
        [PlayersComboBox.ItemIndex]));
End;

procedure TStartForm.PlayersComboBoxClick(Sender: TObject);
begin
    if (PlayersComboBox.Text <> '') And (LanguageComboBox.Text <> '') then
        PlayButton.Enabled := True
    else
        PlayButton.Enabled := False;
end;

Procedure TStartForm.DeveloperTabOnClick(Sender: TObject);
Var
    DeveloperForm: TDeveloperForm;
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    // InstructionForm.Icon := MainForm.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
End;

End.
