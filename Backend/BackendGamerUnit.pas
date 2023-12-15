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
        // 0 - не было использована
        // 1 - была использована
        Function WasFrindsHelpButtonStatus(): Boolean;
        Function Was50For50ButtonStatus(): Boolean;
        Function GetLastWord(): String;
        Procedure SetLastGamersWord(LastGamersWord: String);
        Procedure Take10LettersFromBank();
        Function IsWordCreatable(): Boolean;
    End;

    TLetterBank = Class
    Private

    End;

    TEmpty = Record
    End;



Implementation

{ TGamer }

Function TGamer.GetLastWord(): String;
Begin
    GetLastWord := LastWord;
End;

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
