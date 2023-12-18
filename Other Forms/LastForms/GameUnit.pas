unit GameUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TGameForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GameForm: TGameForm;

implementation

{$R *.dfm}

uses FriendsHelpUnit,fiftyForFiftyUnit;

procedure TGameForm.BitBtn2Click(Sender: TObject);
begin
    FriendsHelpForm.ShowModal;
end;

procedure TGameForm.BitBtn3Click(Sender: TObject);
begin
    FiftyForFiftyForm.ShowModal;
end;

end.
