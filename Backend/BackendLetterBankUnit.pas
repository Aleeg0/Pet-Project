Unit BackendLetterBankUnit;

Interface

Uses System.Generics.Collections, BackendGamerUnit, System.SysUtils,
    BackendStartUnit;

Type
    TLetterBank = Class
    Private
        Alphabet: TLetters;
        SourceFileName: String;
        SourceFile: TextFile;
        Language: TLanguage;
    Public
        Constructor Create(SourceFileName: String; Language: TLanguage);
        Procedure LoadDictionaryFromFile();
        Function GiveLetters(CountLetters: Integer): TLetters;
    End;

Implementation

{ TLetterBank }

Constructor TLetterBank.Create(SourceFileName: String; Language: TLanguage);
Begin
    Self.SourceFileName := SourceFileName;
    Self.Language := Language;
    If Language = TLanguage.EN Then
        AssignFile(SourceFile, SourceFileName)
    Else
        AssignFile(SourceFile, SourceFileName, CP_UTF8);
End;

Function TLetterBank.GiveLetters(CountLetters: Integer): TLetters;
Const
    VOWEL_LETTERS_EN: Set Of Char = ['a', 'e', 'i', 'o', 'u'];
    VOWEL_LETTERS_RUS: Array Of Char = ['а', 'о', 'у', 'ы', 'э', 'я', 'ю', 'ё',
        'и', 'е'];
Var
    // сами буквы
    Letters: TLetters;
    // для рандома
    RandomIndex: Integer;
    RandomLetter: Char;
    VowelCount: Integer;
    // для циклов
    Letter: Char; // для английских букв
    I,J: Integer;
    // для проверок
    DoubleLetterCounter: Integer;
    Counter: Integer;
    LetterFound: Boolean;
    IsVowel: Boolean;
    // для русского языка
Begin
    Letters := Nil;
    Letters := TDictionary<Char, Integer>.Create();
    DoubleLetterCounter := 0;
    VowelCount := 0;
    If Language = TLanguage.En Then
    Begin
        For I := 1 To CountLetters Do
        Begin
            RandomLetter := #0;
            If Alphabet.Count > 0 Then
            Begin
                LetterFound := False;
                Repeat
                    Randomize;
                    RandomIndex := Random(Alphabet.Count);
                    Counter := 0;
                    // тут происходит генерация буквы
                    For Letter In Alphabet.Keys Do
                    Begin
                        If (RandomIndex = Counter) Then
                        Begin
                            RandomLetter := Letter;
                            Break;
                        End;
                        Inc(Counter);
                    End;
                    // А тут мы смотрим чтобы буквы не повторялись больше 2 раз
                    // если больше половины букв выпали 2 раза
                    //
                    If Alphabet.ContainsKey(RandomLetter) Then
                    Begin
                        If (Language = TLanguage.EN) And
                            (RandomLetter In VOWEL_LETTERS_EN) Then
                        Begin
                            If (Letters.ContainsKey(RandomLetter)) And
                                (Letters[RandomLetter] = 1) And
                                (DoubleLetterCounter < 2) Then
                            Begin
                                Inc(DoubleLetterCounter);
                                LetterFound := True;
                                Inc(VowelCount);
                            End
                            Else If Not Letters.ContainsKey(RandomLetter) Then
                            Begin
                                LetterFound := True;
                                Inc(VowelCount);
                            End;
                        End
                        Else If (VowelCount > (CountLetters Div 2 - 1)) Then
                        Begin
                            If (Letters.ContainsKey(RandomLetter)) And
                                (Letters[RandomLetter] = 1) And
                                (DoubleLetterCounter < 2) Then
                            Begin
                                Inc(DoubleLetterCounter);
                                LetterFound := True;
                            End
                            Else If Not Letters.ContainsKey(RandomLetter) Then
                                LetterFound := True;
                        End;
                    End;
                Until LetterFound;
                Alphabet[RandomLetter] := Alphabet[RandomLetter] - 1;
                If Alphabet[RandomLetter] = 0 Then
                    Alphabet.Remove(RandomLetter);
                If Not Letters.ContainsKey(RandomLetter) Then
                    Letters.Add(RandomLetter, 0);
                Letters[RandomLetter] := Letters[RandomLetter] + 1;
            End;
        End;
    End
    Else
    Begin
        For I := 1 To CountLetters Do
        Begin
            RandomLetter := #0;
            If Alphabet.Count > 0 Then
            Begin
                LetterFound := False;
                Repeat
                    Randomize;
                    RandomIndex := Random(Alphabet.Count);
                    Counter := 0;
                    // тут происходит генерация буквы
                    For Letter In Alphabet.Keys Do
                    Begin
                        If (RandomIndex = Counter) Then
                        Begin
                            RandomLetter := Letter;
                            Break;
                        End;
                        Inc(Counter);
                    End;
                    // А тут мы смотрим чтобы буквы не повторялись больше 2 раз
                    // если больше половины букв выпали 2 раза
                    //
                    If Alphabet.ContainsKey(RandomLetter) Then
                    Begin
                     IsVowel := False;
                        For J := 0 To 9 Do
                        Begin
                            if RandomLetter = VOWEL_LETTERS_RUS[J] then
                            Begin
                                IsVowel := True;
                                Break;
                            End;
                        End;
                        If IsVowel Then
                        Begin
                            If (Letters.ContainsKey(RandomLetter)) And
                                (Letters[RandomLetter] = 1) And
                                (DoubleLetterCounter < 2) Then
                            Begin
                                Inc(DoubleLetterCounter);
                                LetterFound := True;
                                Inc(VowelCount);
                            End
                            Else If Not Letters.ContainsKey(RandomLetter) Then
                            Begin
                                LetterFound := True;
                                Inc(VowelCount);
                            End;
                        End
                        Else If (VowelCount >= (CountLetters Div 2 - 1)) Then
                        Begin
                            If (Letters.ContainsKey(RandomLetter)) And
                                (Letters[RandomLetter] = 1) And
                                (DoubleLetterCounter < 2) Then
                            Begin
                                Inc(DoubleLetterCounter);
                                LetterFound := True;
                            End
                            Else If Not Letters.ContainsKey(RandomLetter) Then
                                LetterFound := True;
                        End;
                    End;
                Until LetterFound;
                Alphabet[RandomLetter] := Alphabet[RandomLetter] - 1;
                If Alphabet[RandomLetter] = 0 Then
                    Alphabet.Remove(RandomLetter);
                If Not Letters.ContainsKey(RandomLetter) Then
                    Letters.Add(RandomLetter, 0);
                Letters[RandomLetter] := Letters[RandomLetter] + 1;
            End;
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
