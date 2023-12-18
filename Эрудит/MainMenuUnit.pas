unit MainMenuUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, AboutTheDevelopersUnit, InstructionUnit,
  GameUnit;

type
  TStartForm = class(TForm)
    LanguageComboBox: TComboBox;
    TitleLabel: TLabel;
    TabsMainMenu: TMainMenu;
    InstructionTab: TMenuItem;
    DeveloperTab: TMenuItem;
    PlayersComboBox: TComboBox;
    PlayButton: TButton;
    LanguageLabel: TLabel;
    PlayersLabel: TLabel;
    procedure InstructionTabOnClick(Sender: TObject);
    procedure DeveloperTabOnClick(Sender: TObject);
    procedure PlayButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StartForm: TStartForm;

implementation

{$R *.dfm}


procedure TStartForm.InstructionTabOnClick(Sender: TObject);
Var
    InstructionForm: TInstructionForm;
Begin
    InstructionForm := TInstructionForm.Create(Self);
    //InstructionForm.Icon := MainForm.Icon;
    InstructionForm.ShowModal;
    InstructionForm.Free;
End;

procedure TStartForm.PlayButtonClick(Sender: TObject);
begin
    Application.CreateForm(TGameForm, GameForm);
    GameForm.ShowModal;
    GameForm.Destroy();
end;

procedure TStartForm.DeveloperTabOnClick(Sender: TObject);
Var
    DeveloperForm: TDeveloperForm;
Begin
    DeveloperForm := TDeveloperForm.Create(Self);
    //InstructionForm.Icon := MainForm.Icon;
    DeveloperForm.ShowModal;
    DeveloperForm.Free;
end;

end.
