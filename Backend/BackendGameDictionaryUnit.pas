Unit BackendGameDictionaryUnit;

Interface

Uses System.Generics.Collections;

Type
    TPoints = Integer;

    TGameDictionary = Class
    Private
        GameDic: TDictionary<String, TPoints>;
        SourceFileName: String;
        SourceFile: TextFile;
    Public
        Constructor Create(SourceFileName: String);
        Procedure LoadFromFile();
        Procedure AddNewWord(NewWord : String);
        Function isExist(UserWord: String) : Boolean;
        // use Destroy() by default
    End;

Implementation

{ TGameDictionary }

procedure TGameDictionary.AddNewWord(NewWord: String);
begin
    Append(SourceFile);
    try
        Writeln(SourceFile,NewWord);            
    finally
        CloseFile(SourceFile);
    end;

end;

Constructor TGameDictionary.Create(SourceFileName: String);
Begin
    Self.SourceFileName := SourceFileName;
    AssignFile(SourceFile, SourceFileName);
End;

function TGameDictionary.isExist(UserWord: String): Boolean;
begin
    if GameDic.ContainsKey(UserWord) then
       IsExist := True
    else
        IsExist := False;
end;

Procedure TGameDictionary.LoadFromFile;
Var
    Word : String;
Begin
    Try
        ReSet(SourceFile);
        While Not EOF(SourceFile) Do
        Begin
            Readln(SourceFile, Word);
            GameDic.Add(Word,length(Word));
        End; 
    Finally
        CloseFile(SourceFile);
        // in future
    End;
End;

End.
