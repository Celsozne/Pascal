program at_2;

var
  a,b: boolean;

begin

  a := true;
  b := false;

  if (a and b) then
    writeln('Line 1 - condition is true')
  else
      writeln('Line 1 - condition is not true');
  if (a or b) then
    writeln('Line 2 - condition is true');

  a := false;
  b := true;

  if(a and b) then
    writeln('Line 3 - condition is true')
  else
    writeln('Line 3 - condition is not true');
  if (a or b) then
    writeln('Line 4 - condition is true');

end.
