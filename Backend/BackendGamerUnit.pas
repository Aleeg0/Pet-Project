Unit BackendGamerUnit;

Interface

Uses System.Generics.Collections; // add dictionary

Type
    TLetters = TDictionary<Char, Integer>;
    TGamer = Class
    Private
        Status50For50Button: Boolean;
        StatusFriendsHelpButton: Boolean;
        UserLetters: TLetters;
        LastWord: String;

    Public
        Procedure SetLastGamersWord(LastGamersWord: String);
        Procedure Take10LettersFromBank();
        Procedure ChangeLetter(chosenLetter, newLetter :Char);
        // 0 - не было использована
        // 1 - была использована
        Function WasFrindsHelpButtonStatus(): Boolean;
        Function Was50For50ButtonStatus(): Boolean;
        Function GetLastWord(): String;
        Function GetUserLetters() : TLetters;
        // проверяет можно ли составить последнее переданное слов из букв,
        // которые были в БАНКЕ БУКВ пользователя
        Function IsWordCreatable(): Boolean;
    End;

Implementation

{ TGamer }

procedure TGamer.ChangeLetter(chosenLetter, newLetter: Char);
begin
    // удаление буквы которую пользователь убрал
    if UserLetters[chosenLetter] = 1 then
        UserLetters.Remove(chosenLetter)
    else
       UserLetters[chosenLetter] := UserLetters[chosenLetter] - 1;
    // добавление новой
    if UserLetters.ContainsKey(newLetter) then
        UserLetters[newLetter] := UserLetters[newLetter] + 1
    else
        UserLetters.Add(newLetter,1);
end;

Function TGamer.GetLastWord(): String;
Begin
    GetLastWord := LastWord;
End;

function TGamer.GetUserLetters: TLetters;
begin
    GetUserLetters := UserLetters;
end;

Function TGamer.IsWordCreatable(): Boolean;
Var
    Counter, Size, I, J: Integer;
    TempLetter: Char;
Begin
    IsWordCreatable := True;
    Size := Length(LastWord);
    // считаем сколько раз буква встретилась в слове.
    // А потом смотри, если число появилось больше раз
    // чем может быть (второе значение в словаре), то присваеваем False
    //
    For I := 1 To Size Do
    Begin
        Counter := 0;
        TempLetter := LastWord[I];
        If UserLetters.ContainsKey(TempLetter) Then
        Begin
            For J := 1 To Size Do
                If (TempLetter = LastWord[J]) Then
                    Inc(Counter);
            If UserLetters[TempLetter] < Counter Then
                IsWordCreatable := False;
        End
        Else
            IsWordCreatable := False;
        If Not IsWordCreatable Then
            Break;
    End;
End;

Procedure TGamer.SetLastGamersWord(LastGamersWord: String);
Begin
    LastWord := LastGamersWord;
End;

Procedure TGamer.Take10LettersFromBank();
Begin
    // TODO:
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
