program type_data;

const
  const_1 = 3.14;
  const_2 = 'teste const_2';
  A = 1;
  B = 100;

type
  color = (Blue, Black, Yellow, White);

  range_type_2 = A..B;
  range_type_3 = Blue..White;

var
  number_1: Integer;
  number_2: Cardinal;
  number_3: ShortInt;
  number_4: SmallInt;
  number_5: Int64;

  P: Byte;
  w: Word;
  lw: LongWord;

begin
  number_1 := Low(Integer);
  number_2 := High(Cardinal);
  number_3 := Low(ShortInt);
  number_4 := Low(SmallInt);
  number_5 := High(Int64);

  P := High(Byte);
  w := High(Word);
  lw := High(LongWord);

  writeln(number_1);
  writeln(number_2);
  writeln(number_3);
  writeln(number_4);
  writeln(number_5);

  writeln('Tudo compilou e rodou certinho!');
end.
