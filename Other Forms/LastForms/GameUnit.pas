Unit GameUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
    FriendsHelpUnit, FiftyForFiftyUnit,
    BackendGameDictionaryUnit, BackendLetterBankUnit, BackendGamerUnit,
    BackendStartUnit;

Const
    COUNT_LETTERS: Integer = 10;

Type
    TGameForm = Class(TForm)
        Label1: TLabel;
        Label2: TLabel;
        LettersLabel: TLabel;
        Label4: TLabel;
        WordEdit: TEdit;
        Label5: TLabel;
        AcceptWordButton: TBitBtn;
        FriendsHelpButton: TBitBtn;
        FiftyForFiftyButton: TBitBtn;
        Label3: TLabel;
        NextPlayer: TButton;
        Label6: TLabel;
        PointsLabel: TLabel;
        Procedure FriendsHelpButtonClick(Sender: TObject);
        Procedure FiftyForFiftyButtonClick(Sender: TObject);
        Procedure FormCreate(Sender: TObject);
        Procedure AcceptWordButtonClick(Sender: TObject);
        Procedure NextPlayerClick(Sender: TObject);
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Private
        ChosenLanguage: TLanguage;
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

Procedure TGameForm.AcceptWordButtonClick(Sender: TObject);
Var
    CurGamer: TGamer;
    Answer: Integer;
    IsExist: Boolean;
    FirstStr, SecondStr: String;
Begin
    CurGamer := Gamers[CurPlayer - 1];
    If WordEdit.Text <> '' Then
    Begin
        // ход(не пробел) был сделан значит пользователь еще в игре
        CurGamer.SetExitStatus(False);
        // обработка слова
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
                    IsExist := True;
                End;
            End
            Else
                IsExist := True;
        End;
        If IsExist Then
        Begin
            Label3.Caption := 'Слово засчитано!';
            If CurPlayer = 1 Then
            Begin
                FirstStr := Gamers[CountPlayers - 1].GetLastWord();
                SecondStr := Gamers[CurPlayer - 1].GetLastWord();
                If (Length(FirstStr) > 0) And (Length(SecondStr) > 0) And
                    (SecondStr[1] = FirstStr[Length(FirstStr)]) Then
                Begin
                    CurGamer.AddPoints();
                    Label3.Caption := Label3.Caption + ' Вы получили 2x бонус!';
                End;
            End
            Else
            Begin
                FirstStr := Gamers[CurPlayer - 2].GetLastWord();
                SecondStr := Gamers[CurPlayer - 1].GetLastWord();
                If (Length(FirstStr) > 0) And (Length(SecondStr) > 0) And
                    (SecondStr[1] = FirstStr[Length(FirstStr)]) Then
                Begin
                    CurGamer.AddPoints();
                    Label3.Caption := Label3.Caption + ' Вы получили 2x бонус!';
                End;
            End;
            CurGamer.AddPoints();
            CurGamer.DeleteLetters();
            // добовление недостающих букв
            If CurGamer.GetCountLetters() < COUNT_LETTERS Then
            Begin
                CurGamer.SetLetters
                    (LettersBank.GiveLetters(COUNT_LETTERS -
                    CurGamer.GetCountLetters()));
            End;
        End
        Else
        Begin
            Label3.Caption := 'Слово не засчитано!';
            CurGamer.SubPoints();
        End;
    End
    Else
    Begin
        Label3.Caption := 'Вы пропустили ход';
        CurGamer.SetExitStatus(True);
    End;
    AcceptWordButton.Enabled := False;
    FiftyForFiftyButton.Enabled := False;
    FriendsHelpButton.Enabled := False;
    WordEdit.Enabled := False;
    NextPlayer.Enabled := True;
End;

Procedure TGameForm.FriendsHelpButtonClick(Sender: TObject);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
    TempPlayers, CountMissing: Integer;
Begin
    Application.CreateForm(TFriendsHelpForm, FriendsHelpForm);
    FriendsHelpForm.FormCreate(Self, Gamers, CurPlayer);
    Try
        FriendsHelpForm.ShowModal;
    Finally
        FreeAndNil(FriendsHelpForm);
    End;
    If Gamers[CurPlayer - 1].GetFrindsHelpButtonStatus() Then
    Begin
        FriendsHelpButton.Enabled := False;
        // перерисовка букв
        TempLetters := Gamers[CurPlayer - 1].GetUserLetters();
        LettersLabel.Caption := '';
        For Letter In TempLetters.Keys Do
        Begin
            CountLetters := TempLetters[Letter];
            For I := 1 To CountLetters Do
                LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
        End;
    End;
End;

Procedure TGameForm.FiftyForFiftyButtonClick(Sender: TObject);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
Begin
    Application.CreateForm(TFiftyForFiftyForm, FiftyForFiftyForm);
    FiftyForFiftyForm.FormCreate(Self, Gamers[CurPlayer - 1], Lettersbank);
    Try
        FiftyForFiftyForm.ShowModal;
    Finally
        FreeAndNil(FiftyForFiftyForm);
    End;

    If Gamers[CurPlayer - 1].Get50For50ButtonStatus() Then
    Begin
        FiftyForFiftyButton.Enabled := False;
        // перерисовка букв
        TempLetters := Gamers[CurPlayer - 1].GetUserLetters();
        LettersLabel.Caption := '';
        For Letter In TempLetters.Keys Do
        Begin
            CountLetters := TempLetters[Letter];
            For I := 1 To CountLetters Do
                LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
        End;
    End;

End;

Procedure TGameForm.FormClose(Sender: TObject; Var Action: TCloseAction);
Var
    I: Integer;
Begin
    Lettersbank.Destroy();
    GameDictionary.Destroy();
    For I := 1 To CountPlayers Do
        Gamers[I - 1].Destroy();
    Gamers := Nil;
End;

Procedure TGameForm.FormCreate(Sender: TObject);
Var
    I, CountLetters: Integer;
    TempLetters: TLetters;
    Letter: Char;
Begin
    // загрузка языкового пакета
    ChosenLanguage := Start.GetLanguage();
    If ChosenLanguage = TLanguage.EN Then
    Begin
        Lettersbank := TLetterBank.Create('LettersEn.txt', TLanguage.EN);
        GameDictionary := TGameDictionary.Create('DictionaryEn.txt',
            TLanguage.EN);
    End
    Else
    Begin
        Lettersbank := TLetterBank.Create('LettersRus.txt', TLanguage.RUS);
        GameDictionary := TGameDictionary.Create('DictionaryRus.txt',
            TLanguage.RUS);
    End;
    Lettersbank.LoadDictionaryFromFile();
    GameDictionary.LoadDictionaryFromFile();
    // определение количество игроков
    CountPlayers := Start.GetPlayers();
    // создание игроков
    SetLength(Gamers, CountPlayers);
    For I := 1 To CountPlayers Do
    Begin
        Gamers[I - 1] := TGamer.Create();
        Gamers[I - 1].SetLetters(LettersBank.GiveLetters(COUNT_LETTERS));
    End;
    // первый пошел
    CountOfRounds := 1;
    CurPlayer := 1;
    PointsLabel.Caption := PointsLabel.Caption + ' ' +
        IntToStr(Gamers[CurPlayer - 1].GetPoints());
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
    CurGamer: TGamer;
    IsEndOfGame: Boolean;
Begin
    AcceptWordButton.Enabled := True;
    Label3.Caption := '';
    WordEdit.Text := '';
    // тип конец игры
    IsEndOfGame := True;
    For I := 1 To CountPlayers Do
        If Not Gamers[I - 1].GetExitStatus() Then
            IsEndOfGame := False;
    If IsEndOfGame Then
    Begin
        WinnerIndex := 1;
        WinnerPoints := Gamers[0].GetPoints();
        For I := 2 To CountPlayers Do
        Begin
            If Gamers[I - 1].GetPoints() > WinnerPoints Then
            Begin
                WinnerPoints := Gamers[I - 1].GetPoints();
                WinnerIndex := I;
            End;
        End;
        Label3.Caption := 'Победил игрок №' + IntToStr(WinnerIndex) + ',набрав '
            + IntToStr(WinnerPoints) + ' очков';
        AcceptWordButton.Enabled := False;
        NextPlayer.Enabled := False;
        FiftyForFiftyButton.Enabled := False;
        FriendsHelpButton.Enabled := False;
    End
    Else
    Begin
        // переход к некст игроку
        Inc(CurPlayer);
        // перестройка интерфейса
        If CurPlayer > CountPlayers Then
        Begin
            CurPlayer := 1;
            Inc(CountOfRounds);
            Label6.Caption := 'Раунд' + IntToStr(CountOfRounds);
        End;
        CurGamer := Gamers[CurPlayer - 1];
        Label1.Caption := 'Игрок ' + IntToStr(CurPlayer) + ' ваш ход.';
        // показываем поинты игрока
        PointsLabel.Caption := 'Ваши Очки: ' + IntToStr(CurGamer.GetPoints());
        // показываем буквы
        TempLetters := CurGamer.GetUserLetters();
        LettersLabel.Caption := '';
        For Letter In TempLetters.Keys Do
        Begin
            CountLetters := TempLetters[Letter];
            For I := 1 To CountLetters Do
                LettersLabel.Caption := LettersLabel.Caption + Letter + ' ';
        End;
        // проверка кнопочек
        FiftyForFiftyButton.Enabled := Not CurGamer.Get50For50ButtonStatus();
        FriendsHelpButton.Enabled := Not CurGamer.GetFrindsHelpButtonStatus();
        // конец перестройки интерфейса
        //
        NextPlayer.Enabled := False;
        WordEdit.Enabled := True;
    End;
End;

End.
