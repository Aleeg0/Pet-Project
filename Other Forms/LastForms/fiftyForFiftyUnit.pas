Unit fiftyForFiftyUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
    BackendLetterBankUnit, BackendGamerUnit;

Const
    COUNT_LETTERS: Integer = 10;

Type

    TFiftyForFiftyForm = Class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Edit1: TEdit;
        BitBtn1: TBitBtn;
        Procedure FormCreate(Sender: TObject; Var Gamer: TGamer;
            Var Bank: TLetterBank);
        Procedure Edit1Change(Sender: TObject);
        Procedure Edit1KeyPress(Sender: TObject; Var Key: Char);
        Procedure BitBtn1Click(Sender: TObject);
    Private
        CurGamer: TGamer;
        Bank: TLetterBank;
        IsBonusUsed: Boolean;
    Public
        Function Is50For50Used(): Boolean;
    End;

Const
    Alphabet = ['a' .. 'z'];

Var
    FiftyForFiftyForm: TFiftyForFiftyForm;

Implementation

{$R *.dfm}

Procedure TFiftyForFiftyForm.BitBtn1Click(Sender: TObject);
Var
    TempLetters: TLetters;
    Letter, TempLetter: Char;
    I, CountMissing: Integer;
Begin
    TempLetters := CurGamer.GetUserLetters();
    CurGamer.SetLastGamersWord(Edit1.Text);
    If CurGamer.IsWordCreatable() Then
    Begin
        CurGamer.Use50For50Button();
        CurGamer.DeleteLetters();
        CurGamer.SetLastGamersWord('');
        CurGamer.SetLetters(Self.Bank.GiveLetters(COUNT_LETTERS - CurGamer.GetCountLetters()));
    End
    Else
        MessageBox
            (FiftyForFiftyForm.Handle, 'ќй-еееей, кажетс€ одной из букв которые вы хотите помен€ть нет в вашем наборе',
            'ќшибочка', MB_ICONEXCLAMATION);

End;

Procedure TFiftyForFiftyForm.Edit1Change(Sender: TObject);
Begin
    If Length(Edit1.Text) = 5 Then
        BitBtn1.Enabled := True
    Else
        BitBtn1.Enabled := False;
End;

Procedure TFiftyForFiftyForm.Edit1KeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(CharInSet(Key, Alphabet)) And Not(Key = #8) Then
        Key := #0;
End;

Procedure TFiftyForFiftyForm.FormCreate(Sender: TObject; Var Gamer: TGamer;
    Var Bank: TLetterBank);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
Begin
    IsBonusUsed := False;
    Self.Bank := Bank;
    Self.CurGamer := Gamer;
    TempLetters := CurGamer.GetUserLetters();
    Label2.Caption := '';
    For Letter In TempLetters.Keys Do
    Begin
        CountLetters := TempLetters[Letter];
        For I := 1 To CountLetters Do
            Label2.Caption := Label2.Caption + Letter + ' ';
    End;
End;

Function TFiftyForFiftyForm.Is50For50Used: Boolean;
Begin
    Is50For50Used := IsBonusUsed;
End;

End.
