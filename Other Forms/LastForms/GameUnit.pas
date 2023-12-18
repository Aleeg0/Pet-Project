Unit GameUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
    FriendsHelpUnit, FiftyForFiftyUnit,
    BackendGameDictionaryUnit, BackendLetterBankUnit, BackendGamerUnit;

Const
    COUNT_LETTERS: Integer = 10;

Type
    TGamers = Array Of TGamer;

    TGameForm = Class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        LettersLabel: TLabel;
        Label4: TLabel;
        WordEdit: TEdit;
        Label5: TLabel;
        BitBtn1: TBitBtn;
        BitBtn2: TBitBtn;
        BitBtn3: TBitBtn;
        Label3: TLabel;
        NextPlayer: TButton;
        Procedure BitBtn2Click(Sender: TObject);
        Procedure BitBtn3Click(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure BitBtn1Click(Sender: TObject);
        Procedure WordEditChange(Sender: TObject);
        Procedure NextPlayerClick(Sender: TObject);
    Private
        CurPlayer: Integer;
        CountPlayers: Integer;
        Gamers: TGamers;
        Lettersbank: TLetterBank;
        GameDictionary: TGameDictionary;
    Public

    End;

Var
    GameForm: TGameForm;

Implementation

{$R *.dfm}

Procedure TGameForm.BitBtn1Click(Sender: TObject);
Var
    CurGamer: TGamer;
    Answer: Integer;
    IsExist: Boolean;
Begin
    CurGamer := Gamers[CurPlayer - 1];
    CurGamer.SetLastGamersWord(WordEdit.Text);
    IsExist := False;
    If CurGamer.IsWordCreatable() Then
    Begin
        If Not GameDictionary.IsExist(WordEdit.Text) Then
        Begin
            If MessageBox(GameForm.Handle,
                'Словарь не нашел такого слова. Игроки такое слово существует?',
                'Слово не найденно!', MB_YESNO) = ID_YES Then
            Begin
                GameDictionary.AddNewWord(WordEdit.Text);
                CurGamer.AddPoints();
                IsExist := True;
            End;
        End
        Else
            IsExist := True;
    End;
    If IsExist Then
    Begin
        Label3.Caption := 'Слово засчитано!';
    End
    Else
        Label3.Caption := 'Слово не засчитано!';
End;

Procedure TGameForm.BitBtn2Click(Sender: TObject);
Begin
    FriendsHelpForm.ShowModal;
End;

Procedure TGameForm.BitBtn3Click(Sender: TObject);
Begin
    FiftyForFiftyForm.ShowModal;
End;

Procedure TGameForm.FormCreate(Sender: TObject);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
Begin
    // загрузка файлов создание обьектов
    Lettersbank := TLetterBank.Create('LettersEn.txt');
    GameDictionary := TGameDictionary.Create('DictionaryEn.txt');
    Lettersbank.LoadDictionaryFromFile();
    GameDictionary.LoadDictionaryFromFile();
    CountPlayers := 2;
    SetLength(Gamers, CountPlayers);
    For I := 1 To CountPlayers Do
    Begin
        Gamers[I - 1] := TGamer.Create();
        Gamers[I - 1].SetLetters(LettersBank.GiveLetters(10));
    End;
    // первый пошел
    CurPlayer := 1;
    Label1.Caption := 'Игрок ' + IntToStr(CurPlayer) + ' ваш ход.';
    TempLetters := Gamers[CurPlayer - 1].GetUserLetters();
    LettersLabel.Caption := '';
    For Letter In TempLetters.Keys Do
    Begin
        CountLetters := TempLetters[Letter];
        For I := 1 To CountLetters Do
            LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
    End;

End;

Procedure TGameForm.NextPlayerClick(Sender: TObject);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
    CountMissing : Integer;
Begin
    Label3.Caption := '';
    WordEdit.Text := '';
    Inc(CurPlayer);
    if CurPlayer > CountPlayers then
        CurPlayer := 1;
    Label1.Caption := 'Игрок ' + IntToStr(CurPlayer) + ' ваш ход.';
    // добовление не достоющих букв
    CountMissing := 10 - Gamers[CurPlayer - 1].GetCountLetters();
    if CountMissing > 0 then
    Begin
        Gamers[I - 1].SetLetters(LettersBank.GiveLetters(CountMissing));
    End;
    TempLetters := Gamers[CurPlayer - 1].GetUserLetters();
    LettersLabel.Caption := '';
    For Letter In TempLetters.Keys Do
    Begin
        CountLetters := TempLetters[Letter];
        For I := 1 To CountLetters Do
            LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
    End;
End;

Procedure TGameForm.WordEditChange(Sender: TObject);
Begin
    Label3.Caption := '';
End;

End.
