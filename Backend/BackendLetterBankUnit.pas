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
    I: Integer;
Begin
    Letters := Nil;
    Letters := TDictionary<Char, Integer>.Create();
    For I := 1 To CountLetters Do
    Begin
        RandomLetter := #0;
        If Alphabet.Count > 0 Then
        Begin
            Repeat
                Randomize;
                RandomLetter := Chr(Random(Alphabet.Count) + Ord('a'));
            Until Alphabet[RandomLetter] > 0;
            Alphabet[RandomLetter] := Alphabet[RandomLetter] - 1;
            If Alphabet[RandomLetter] = 0 Then
                Alphabet.Remove(RandomLetter);
            If Not Letters.ContainsKey(RandomLetter) Then
                Letters.Add(RandomLetter, 0);
            Letters[RandomLetter] := Letters[RandomLetter] + 1;
        End;
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
        Readln(SourceFile, CountOfLetters);
        Alphabet := TDictionary<Char, Integer>.Create();
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
