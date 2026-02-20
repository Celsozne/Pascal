program Calculadora;
uses Math;

var
  a, b: Int64;
  c_int: Int64;
  c_real: Double;
  option: Integer;

begin
  repeat
    writeln('---------------------------');
    writeln('Qual opcao voce deseja: ');
    writeln('0: sair');
    writeln('1: soma');
    writeln('2: subtracao');
    writeln('3: Multiplicacao');
    writeln('4: Divisao');
    writeln('5: Potencia');
    writeln('6: Raiz');
    write('Opcao: ');
    readln(option);

    if option = 0 then break;

    case (option) of
      1: begin
           writeln('Escreva o valor de A: '); readln(a);
           writeln('Escreva o valor de B: '); readln(b);
           c_int := a + b;
           writeln('O valor da soma e: ', c_int);
         end;

      2: begin
           writeln('Escreva o valor de A: '); readln(a);
           writeln('Escreva o valor de B: '); readln(b);
           c_int := a - b;
           writeln('O valor da subtracao e: ', c_int);
         end;

      3: begin
           writeln('Escreva o valor de A: '); readln(a);
           writeln('Escreva o valor de B: '); readln(b);
           c_int := a * b;
           writeln('O valor da multiplicacao e: ', c_int);
         end;

      4: begin
           writeln('Escreva o valor de A: '); readln(a);
           writeln('Escreva o valor de B (diferente de 0): '); readln(b);
           if b = 0 then
             writeln('Erro: Nao e possivel dividir por zero!')
           else
             begin
               c_int := a / b;
               writeln('O valor da divisao e: ', c_real);
             end;
         end;

      5: begin
           writeln('Escreva o valor de A (base): '); readln(a);
           writeln('Escreva o valor de B (expoente): '); readln(b);
           c_int := IntPower(a, b);
           writeln('O valor final e: ', c_int);
         end;

      6: begin
           writeln('Raiz quadrada de: '); readln(a);
           if a < 0 then
             writeln('Erro: Nao existe raiz real de numero negativo.')
           else
             begin
               c_real := sqrt(a);
               writeln('Valor da raiz e: ', c_real:0:2);
             end;
         end;
    else
      writeln('Opcao invalida!');
    end;

    writeln;
  until option = 0;

  writeln('Programa finalizado.');
end.
