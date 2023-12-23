unit FriendsHelpUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.Buttons;

type
  TFriendsHelpForm = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    StringGrid2: TStringGrid;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FriendsHelpForm: TFriendsHelpForm;

implementation

{$R *.dfm}

procedure TFriendsHelpForm.FormCreate(Sender: TObject);
begin
    StringGrid1.Cells[0,0] := '№ игрока';
    StringGrid1.Cells[1,0] := 'Набор букв';
    StringGrid1.Cells[2,0] := 'Очки';

    StringGrid2.Cells[0,0] := '№ игрока';
    StringGrid2.Cells[1,0] := 'Набор букв';
    StringGrid2.Cells[2,0] := 'Очки';
end;

end.
