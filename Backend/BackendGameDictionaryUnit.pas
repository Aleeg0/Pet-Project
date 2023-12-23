Unit BackendGameDictionaryUnit;

Interface

Uses System.Generics.Collections;

Type
    TPoints = Integer;
    TWordDic = TDictionary<String, TPoints>;
    TGameDictionary = Class
    Private
        GameDic: TWordDic;
        SourceFileName: String;
        SourceFile: TextFile;
    Public
        Constructor Create(SourceFileName: String);
        Procedure LoadDictionaryFromFile();
        Procedure AddNewWord(NewWord : String);
        Function isExist(UserWord: String) : Boolean;
        // use Destroy() by default
        Function ls();
    End;

Implementation

{ TGameDictionary }

procedure TGameDictionary.AddNewWord(NewWord: String);
begin
    Append(SourceFile);
    GameDic.Add(NewWord,Length(NewWord));
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

Procedure TGameDictionary.LoadDictionaryFromFile();
Var
    Word : String;
    Count : Integer;
Begin
    Try
        ReSet(SourceFile);
        Readln(SourceFile, Count);
        GameDic := TDictionary<String,Integer>.Create();
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
