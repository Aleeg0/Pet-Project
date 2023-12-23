Unit BackendGamerUnit;

Interface

Uses System.Generics.Collections;

Type
    TLetters = TDictionary<Char, Integer>;

    TGamer = Class
    Private
        Status50For50Button: Boolean;
        StatusFriendsHelpButton: Boolean;
        UserLetters: TLetters;
        LastWord: String;
        GamerPoints: Integer;
    Public
        Constructor Create();
        Procedure SetLastGamersWord(LastGamersWord: String);
        Procedure SetLetters(Letters: TLetters);
        Procedure ChangeLetter(ChosenLetter, NewLetter: Char);
        Procedure AddPoints();
        // 0 - не было использована
        // 1 - была использована
        Function WasFrindsHelpButtonStatus(): Boolean;
        Function Was50For50ButtonStatus(): Boolean;
        Function GetCountLetters(): Integer;
        Function GetLastWord(): String;
        Function GetPoints() : Integer;
        Function GetUserLetters(): TLetters;
        // проверяет можно ли составить последнее переданное слов из букв,
        // которые были в БАНКЕ БУКВ пользователя
        Function IsWordCreatable(): Boolean;
    End;

Implementation

{ TGamer }

Procedure TGamer.AddPoints();
Begin
    Inc(GamerPoints, Length(LastWord));
End;

Procedure TGamer.ChangeLetter(ChosenLetter, NewLetter: Char);
Begin
    // удаление буквы которую пользователь убрал
    If UserLetters[ChosenLetter] = 1 Then
        UserLetters.Remove(ChosenLetter)
    Else
        UserLetters[ChosenLetter] := UserLetters[ChosenLetter] - 1;
    // добавление новой
    If UserLetters.ContainsKey(NewLetter) Then
        UserLetters[NewLetter] := UserLetters[NewLetter] + 1
    Else
        UserLetters.Add(NewLetter, 1);
End;

Constructor TGamer.Create;
Begin
    UserLetters := TDictionary<Char, Integer>.Create();
    LastWord := '';
    GamerPoints := 0;
End;

Function TGamer.GetCountLetters: Integer;
Var
    Count: Integer;
    I: Integer;
Begin
    Count := 0;
    For I In UserLetters.Values Do
        Inc(Count, I);
    GetCountLetters := Count;
End;

Function TGamer.GetLastWord(): String;
Begin
    GetLastWord := LastWord;
End;

function TGamer.GetPoints: Integer;
begin
    GetPoints := GamerPoints;
end;

Function TGamer.GetUserLetters: TLetters;
Begin
    GetUserLetters := UserLetters;
End;

Function TGamer.IsWordCreatable(): Boolean;
Var
    Counter, Size, I, J: Integer;
    TempLetter: Char;
    Answer, WrongLetter: Boolean;
Begin
    Answer := True;
    Size := Length(LastWord);
    // считаем сколько раз буква встретилась в слове.
    // А потом смотри, если число появилось больше раз
    // чем может быть (второе значение в словаре), то присваеваем False
    //
    For I := 1 To Size Do
    Begin
        WrongLetter := True;
        Counter := 0;
        TempLetter := LastWord[I];
        If UserLetters.ContainsKey(TempLetter) Then
        Begin
            UserLetters[TempLetter] := UserLetters[TempLetter] - 1;
            If UserLetters[TempLetter] = 0 Then
                UserLetters.Remove(TempLetter);
        End
        Else
            WrongLetter := False;
        If Answer And Not WrongLetter Then
            Answer := False;
        If Not WrongLetter Then
            Dec(GamerPoints);
    End;
    IsWordCreatable := Answer;
End;

Procedure TGamer.SetLastGamersWord(LastGamersWord: String);
Begin
    LastWord := LastGamersWord;
End;

Procedure TGamer.SetLetters(Letters: TLetters);
Var
    Letter: Char;
Begin
    For Letter In Letters.Keys Do
    Begin
        if Not UserLetters.ContainsKey(Letter) then
            UserLetters.Add(Letter, 0);
        UserLetters[Letter] := Letters[Letter];
    End;
End;

Function TGamer.Was50For50ButtonStatus(): Boolean;
Begin
    Was50For50ButtonStatus := Status50For50Button;
End;

Function TGamer.WasFrindsHelpButtonStatus(): Boolean;
Begin
    WasFrindsHelpButtonStatus := StatusFriendsHelpButton;
End;

End.
