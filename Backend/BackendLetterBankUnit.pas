Unit BackendLetterBankUnit;

Interface

Uses System.Generics.Collections, BackendGamerUnit, System.SysUtils;

Type
    TLetterBank = Class
    Private
        Alphabet: TLetters;
        SourceFileName: String;
        SourceFile: TextFile;
    Public
        Constructor Create(SourceFileName: String);
        Procedure LoadDictionaryFromFile();
        Function GiveLetters(CountLetters: Integer): TLetters;
    End;

Implementation

{ TLetterBank }

Constructor TLetterBank.Create(SourceFileName: String);
Begin
    Self.SourceFileName := SourceFileName;
    AssignFile(SourceFile, SourceFileName);
End;

Function TLetterBank.GiveLetters(CountLetters: Integer): TLetters;
Var
    Letters: TLetters;
    RandomLetter: Char;
    I, J: Integer;
Begin
    For J := 1 To CountLetters Do
    Begin
        RandomLetter := #0;
        Repeat
            Randomize;
            RandomLetter := Chr(Random(Alphabet.Count + Ord('a')));
        Until Alphabet[RandomLetter] > 0;
        Alphabet[RandomLetter] := Alphabet[RandomLetter] - 1;
        If Not Letters.ContainsKey(RandomLetter) Then
            Letters.Add(RandomLetter, 0);
        Letters[RandomLetter] := Letters[RandomLetter] + 1;
    End;
    GiveLetters := Letters;
End;

Procedure TLetterBank.LoadDictionaryFromFile();
Var
    Letter: Char;
    Count: Integer;
    I: Integer;
    CountOfLetters: Integer;
Begin

    Try
        Reset(SourceFile);
        Read(SourceFile, CountOfLetters);
        For I := 1 To CountOfLetters Do
        Begin
            Read(SourceFile, Letter);
            Readln(SourceFile, Count);
            Alphabet.Add(Letter, Count);
        End;
    Finally
        CloseFile(SourceFile);
    End;
End;

End.
