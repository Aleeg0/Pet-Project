Unit BackendLetterBankUnit;

Interface

Uses System.Generics.Collections, BackendGamerUnit;

Type
    TLetterBank = Class
    Private
        Alphabet : TLetters;
        SourceFileName: String;
        SourceFile: TextFile;
    Public
        Constructor Create(SourceFileName: String);
        Procedure LoadDictionaryFromFile();
        Function GiveLetters(CountLetters : Integer) : TLetters;
    End;

Implementation

{ TLetterBank }

constructor TLetterBank.Create(SourceFileName: String);
begin
    Self.SourceFileName := SourceFileName;
    AssignFile(SourceFile,SourceFileName);
end;

function TLetterBank.GiveLetters(CountLetters: Integer): TLetters;
begin
    // TODO
end;

procedure TLetterBank.LoadDictionaryFromFile();
Var
    letter : Char;
    Count: Integer;
begin
    Try
        Reset(SourceFile);
        Read(SourceFile, letter);
        Readln(SourceFile, Count);
        Alphabet.Add(Letter,count);
    Finally
        CloseFile(SourceFile);
    End;
end;

End.
