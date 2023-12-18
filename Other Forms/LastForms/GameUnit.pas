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
        Label6: TLabel;
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
        CountOfRounds: Integer;
        CountEndGamers: Integer;
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
    FirstStr,SecondStr : String;
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
        if CurPlayer = 1 then
        Begin
            FirstStr := Gamers[CountPlayers - 1].GetLastWord();
            SecondStr := Gamers[CurPlayer - 1].GetLastWord();
            if SecondStr[1] = FirstStr[Length(FirstStr)] then
            Begin
                Gamers[CurPlayer - 1].AddPoints();
                Label3.Caption := Label3.Caption + ' Вы получили 2x бонус!';
            End;
            Gamers[CurPlayer - 1].AddPoints();
        End
        else
        Begin
            FirstStr := Gamers[CurPlayer - 2].GetLastWord();
            SecondStr := Gamers[CurPlayer - 1].GetLastWord();
            if SecondStr[1] = FirstStr[Length(FirstStr)] then
            Begin
                Gamers[CurPlayer - 1].AddPoints();
                Label3.Caption := Label3.Caption + ' Вы получили 2x бонус!';
            End;
            Gamers[CurPlayer - 1].AddPoints();
        End;
    End
    Else
        Label3.Caption := 'Слово не засчитано!';
    NextPlayer.Enabled := True;
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
    CountOfRounds := 1;
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
    CountMissing: Integer;
    WinnerIndex: Integer;
    WinnerPoints: Integer;
Begin
    Label3.Caption := '';
    WordEdit.Text := '';
    Inc(CurPlayer);
    If CurPlayer > CountPlayers Then
    Begin
        CurPlayer := 1;
        Inc(CountOfRounds);
        Label6.Caption := 'Раунд' + IntToStr(CountOfRounds);
    End;
    Label1.Caption := 'Игрок ' + IntToStr(CurPlayer) + ' ваш ход.';
    // добовление не достоющих букв
    CountMissing := 10 - Gamers[CurPlayer - 1].GetCountLetters();
    If CountMissing > 0 Then
    Begin
        Gamers[CurPlayer - 1].SetLetters(LettersBank.GiveLetters(CountMissing));
    End;
    TempLetters := Gamers[CurPlayer - 1].GetUserLetters();
    LettersLabel.Caption := '';
    For Letter In TempLetters.Keys Do
    Begin
        CountLetters := TempLetters[Letter];
        For I := 1 To CountLetters Do
            LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
    End;
    NextPlayer.Enabled := False;
    If TempLetters.Count = 0 Then
    Begin
        Inc(CountEndGamers);
        If CountEndGamers = CountPlayers Then
        Begin
            WinnerIndex := 1;
            WinnerPoints := Gamers[0].GetPoints();
            For I := 2 To CountPlayers Do
            Begin
                if Gamers[I-1].GetPoints() > WinnerPoints  Then
                Begin
                    WinnerPoints := Gamers[I-1].GetPoints();
                    WinnerIndex := I;
                End;
            End;
            Label3.Caption := 'Победил игрок №' + IntToStr(WinnerIndex) + ',набрав ' + IntToStr(WinnerPoints) + #46;
        End
        Else
        Begin
            Label3.Caption := 'У вас закончились буквы!';
            NextPlayer.Enabled := True;
        End;
    End;
End;

Procedure TGameForm.WordEditChange(Sender: TObject);
Begin
    BitBtn1.Enabled := Not String.IsNullOrEmpty(WordEdit.Text);
End;

End.
