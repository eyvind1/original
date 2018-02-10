unit edo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, Dialogs;

type
  TEdo=class
  Lxn : TStringList;
  Lyn : TStringList;
  Lyn2 : TstringList;
  MetodoType: Integer;
  private
  public
    constructor create;
    destructor Destroy; override;
    function f(valor:real;s:string):real;
    function euler(ecuacion:string;varx:real;vary:real;h:real):real;
    function heun(ecuacion:string;varx:real;vary:real;h:real):real;
    function f(x : Real;y : Real;s: String):Real;
    function ejecutarEdo(ecuacion:string; varx,vary,h:real): Double;
  end;

const
    F_New = 0;
    F_S = 1;

implementation
var
  check: boolean;

constructor TEdo.create()   ;
begin
  Lxn:= TStringList.Create;
  Lyn:= TStringList.Create;
  Lyn2:= TStringList.Create;
end;

destructor TEdo.Destroy;
   begin

     Lxn.Destroy;
     Lyn.Destroy;
     Lyn2.Destroy;

   end;

function TEdo.f(valor:real;s:string):real;
var MiParse: TParseMath;
   begin
     MiParse:= TParseMath.create();
     MiParse.AddVariable('x',valor);
     MiParse.Expression:= s;
     check:=false;
     try
       result:=MiParse.Evaluate();
     except
       begin
       ShowMessage('La funcion no es continua en el punto '+FloatToStr(valor));
       check:=true;
       end;
     end;

     MiParse.destroy;

end;

function TEdo.f(x : Real;y : Real;s: String):Real;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.AddVariable('y',y);
  MiParse.Expression:= s;
  check:=false;
  try
    result:=MiParse.Evaluate();
  except
    begin
    ShowMessage('Nose puede calcular '+FloatToStr(x)+FloatToStr(y));
    check:=true;
    end;
  end;

  MiParse.destroy;
end;

function TEdo.ejecutarEdo(ecuacion:string; varx,vary,h:real): Double;
begin
     case MetodoType of
       F_New: Result:= euler(ecuacion,varx,vary,h) ;
       F_S: Result:= heun(ecuacion,varx,vary,h);
     end;
end;


function TEdo.euler(ecuacion:string;varx:real;vary:real;h:real):real;
var xn,yn,acum :real;
var i :integer;
begin
   xn:=varx;
   yn:=vary;

   Lxn.Clear;
   Lyn.Clear;
   Lxn.Add('');
   Lyn.Add('');
   Lxn.Add(FloatToStr( xn ));
   Lyn.Add(FloatToStr( yn ));
   for i:=0 to 5 do begin
     acum:= yn+(h*f(xn,yn,ecuacion));
     yn:=acum ;
     xn:= xn+h;
     Lxn.Add(FloatToStr( xn ));
     Lyn.Add(FloatToStr( yn ));
   end;
   Result:= yn;
end;

function TEdo.heun(ecuacion:string;varx:real;vary:real;h:real):real;
var xn,yn,yn2,acum :real;
var i :integer;
begin
   xn:=varx;
   yn:=vary;
   yn2:=vary;
   Lxn.Clear;
   Lyn.Clear;
   Lyn2.Clear;
   Lxn.Add('');
   Lyn.Add('');
   Lyn.Add('');
   Lxn.Add(FloatToStr( xn ));
   Lyn.Add(FloatToStr( yn ));
   Lyn2.Add(FloatToStr( yn2 ));
   for i:=0 to 5 do begin
     yn2:=yn+(h*f(xn,yn,ecuacion));
     acum:=yn+(h*1/2*(f(xn,yn,ecuacion)+f(xn+h,yn2,ecuacion)));
     xn:=xn+h;
     yn:=acum;
     Lxn.Add(FloatToStr( xn ));
     Lyn.Add(FloatToStr( yn ));
     Lyn2.Add(FloatToStr( yn2 ));
   end;
   Result:= yn;

end;

end.

