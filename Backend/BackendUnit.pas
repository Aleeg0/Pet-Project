Unit BackendUnit;

Interface

Uses System.Generics.Collections; // add dictionary

Type
    TLetters = TDictionary<Char,Integer>;

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
        Procedure SetLastGamersWord(LastGamersWord : String);
        Procedure Take10Letters();
        Function IsWordCreatable(): Boolean;
    End;

    TLetterBank = Class
    Private

    End;

    TEmpty = record end;
    TGameDictionary = class
        private
        TGameDic : TDictionary<String, TEmpty>;
        FileName : String;
        public
        constructor Create();
    end;

Implementation

{ TGamer }

Function TGamer.GetLastWord(): String;
Begin
    GetLastWord := LastWord;
End;

Function TGamer.IsWordCreatable(): Boolean;
var
    Counter, Size,I,J: Integer;
    Key, TempLetter : Char;
Begin
    IsWordCreatable := True;
    Size := Length(LastWord);
    // считаем сколько раз буква встретилась в слове.
    // А потом смотри, если число появилось больше раз
    // чем может быть (второе значение в словаре), то присваеваем False
    //
    for I := 1 to size do
    Begin
        Counter := 0;
        TempLetter := LastWord[I];
        for J := 1 to Size do
            if (TempLetter = lastWord[J]) then
                Inc(Counter);
        for key in UserLetters.keys do
            if key = TempLetter then
                if UserLetters[key] >= counter then
                    IsWordCreatable := False
                else
                    break;
        if Not IsWordCreatable then
            break;
    End;
End;

procedure TGamer.SetLastGamersWord(LastGamersWord : String);
begin
    LastWord := LastGamersWord;
end;

procedure TGamer.Take10Letters;
begin
    // TODO:
end;

Function TGamer.Was50For50ButtonStatus(): Boolean;
Begin
    Was50For50ButtonStatus := Status50For50Button;
End;

Function TGamer.WasFrindsHelpButtonStatus(): Boolean;
Begin
    WasFrindsHelpButtonStatus := StatusFriendsHelpButton;
End;

{ TGameDictionary }

constructor TGameDictionary.Create;
begin

end;

End.
