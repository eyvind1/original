unit edo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ParseMath, Dialogs, Math;

type
  TEdo=class
  Lxn : TStringList;
  Lyn : TStringList;
  Lyn2: TstringList;
  Lk1 : TStringList;
  Lk2 : TStringList;
  Lk3 : TStringList;
  Lk4 : TStringList;
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
    function runge_kutta4(ecuacion:string;varx,vary,h:real):real;
    function dormand_prince(ecuacion:string; varx,vary,h:real):real;
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
  Lk1 := TStringList.Create;
  Lk2 := TStringList.Create;
  Lk3 := TStringList.Create;
  Lk4 := TStringList.Create;
end;

destructor TEdo.Destroy;
   begin

     Lxn.Destroy;
     Lyn.Destroy;
     Lyn2.Destroy;
     Lk1.Destroy;
     Lk2.Destroy;
     Lk3.Destroy;
     Lk4.Destroy;

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
   acum:=0;
   xn:=varx;
   yn:=vary;
   yn2:=vary;
   Lxn.Clear;
   Lyn.Clear;
   Lyn2.Clear;
   Lxn.Add('');
   Lyn.Add('');
   Lyn2.Add('');
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

function TEdo.runge_kutta4(ecuacion:string;varx,vary,h:real):real;
var xn,yn,acum,k1,k2,k3,k4 ,m:real;
var i :integer;
begin
  xn:=varx;
  yn:=vary;
  acum:=0;
  k1:=0;
  k2:=0;
  k3:=0;
  k4:=0;
  m:=0;
  Lxn.Clear;
  Lyn.Clear;
  Lk1.Clear;
  Lk2.Clear;
  Lk3.Clear;
  Lk4.Clear;
  Lxn.Add('');
   Lyn.Add('');
  Lk1.Add('');
   Lk2.Add('');
   Lk3.Add('');
   Lk4.Add('');
  Lxn.Add(FloatToStr( xn ));
  Lyn.Add(FloatToStr( yn ));
  for i:=0 to 5 do begin

    k1:= f(xn,yn,ecuacion);
    k2:= f(xn+(h/2),yn+(h/2*k1),ecuacion);
    k3:= f(xn+(h/2),yn+(h/2*k2),ecuacion);
    k4:= f(xn+h,yn+(h*k3),ecuacion);
    Lk1.Add(FloatToStr( k1 ));
    Lk2.Add(FloatToStr( k2 ));
    Lk3.Add(FloatToStr( k3 ));
    Lk4.Add(FloatToStr( k4 ));
    m:=1/6*(k1+(2*k2)+(2*k3)+k4);
    acum:= yn+(h*m);
    xn:=xn+h;
    yn:=acum;
    Lxn.Add(FloatToStr( xn ));
    Lyn.Add(FloatToStr( yn ));
  end;
  Result:=yn;
end;

function TEdo.dormand_prince(ecuacion:string ; varx,vary,h:real):real;
var s,eps,xn,yn,acum,acumz,k1,k2,k3,k4,k5,k6,k7 ,m:real;
    i :integer;
begin
  eps := 0.0001;
  xn:=varx;
  yn:=vary;
  acum:=0;
  acumz:=0;
  Lxn.Clear;
  Lyn.Clear;
  Lxn.Add('');
  Lyn.Add('');
  Lxn.Add(FloatToStr( xn ));
  Lyn.Add(FloatToStr( yn ));
  for i:=0 to 20 do begin
      k1:=h*f(xn,yn,ecuacion);
      k2:=h*f(xn+(1/5*h),yn+(1/5*k1),ecuacion);
      k3:=h*f(xn+(3/10*h),yn+(3/40*k1)+(9/40*k2),ecuacion);
      k4:=h*f(xn+(4/5*h),yn+(44/45*k1)-(56/15*k2)+(32/9*k3),ecuacion);
      k5:=h*f(xn+(8/9*h),yn+(19372/6561*k1)-(25360/2187*k2)+(64448/6561*k3)-(212/729*k4),ecuacion);
      k6:=h*f(xn+h,yn+(9017/3168*k1)-(355/33*k2)-(46732/5247*k3)+(49/176*k4)-(5103/18656*k5),ecuacion);
      k7:=h*f(xn+h,yn+(35/384*k1)+(500/1113*k3)+(125/192*k4)-(2187/6784*k5)+(11/84*k6),ecuacion);
      acum:=yn+ 35/384*k1 + 500/1113*k3 + 125/192*k4 - 2187/6784*k5 + 11/84*k6;
      acumz:=yn + 5179/57600*k1 + 7571/16695*k3 + 393/640*k4 - 92097/339200*k5+ 187/2100*k6 + 1/40*k7;
      s:= power(h*eps/(2*(10 - varx)*abs(acum - acumz)), 1/4);

      if s >= 2 then
      begin
         h := h * 2;
         xn:=xn+h;
         yn:=acum;
      end
      else if (s <1) then
      begin
        h:=h/2;
        xn:=xn+h;
        yn:=acum;
      end ;
      yn:=acum;
      xn:=xn+h;
      Lxn.Add(FloatToStr( xn ));
      Lyn.Add(FloatToStr( yn ));

  end;
  Result:=yn;
  showMessage(FloatToStr(yn));
end;

end.

