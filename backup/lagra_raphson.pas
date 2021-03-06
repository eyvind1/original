unit lagra_raphson;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Grids, ParseMath, Dialogs, Math;

type
  Tnolineal = class
    private
    public
    procedure raphson(xo:Real; xi:Real; fx:String; fy:String; error:Real; grill:TStringGrid);
    function f(x : Real;y : Real;s: String):Real;
    function Lagrange(serie:TStringGrid; xo:Real;text:TStaticText):Real;
  end;
var
  check: Boolean ;
implementation

 function Tnolineal.f(x : Real;y : Real;s: String):Real;
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
    ShowMessage('La funcion no es continua en el punto '+FloatToStr(x)+FloatToStr(y));
    check:=true;
    end;
  end;

  MiParse.destroy;
end;

procedure Tnolineal.raphson(xo:Real; xi:Real; fx:String; fy:String; error:Real; grill:TStringGrid);
var
  e,h,e1,det,ui,vi : Real;
  fxy,fxhy,fxyh,f1xy,f1xhy,f1xyh : Real;
  j0,j1,j2,j3 : Real;
  n,i,j : Integer;
begin
  grill.RowCount:=2;
  e:=1;
  e1:=0;
  n:=0;
  i:=0; //grill
  j:=1;
  h:=error/10;
  while e > error do
  begin
      fxy:=f(xo,xi,fx); //u
      if check=true then exit;
      fxhy:=f(xo+h,xi,fx);
      if check=true then exit;
      fxyh:=f(xo,xi+h,fx);
      if check=true then exit;

      f1xy:=f(xo,xi,fy); //v
      if check=true then exit;
      f1xhy:=f(xo+h,xi,fy);
      if check=true then exit;
      f1xyh:=f(xo,xi+h,fy);
      if check=true then exit;

      j0:=(fxhy-fxy)/h;
      j1:=(fxyh-fxy)/h;
      j2:=(f1xhy-f1xy)/h;
      j3:=(f1xyh-f1xy)/h;

      det:=(j0*j3)-(j1*j2);
      ui:=xo-(((fxy*j3)-(f1xy*j1))/det);
      vi:=xi-(((f1xy*j0)-(fxy*j2))/det);

      e:=sqrt(power(xo-ui,2)+power(xi-vi,2));

      grill.Cells[i,j]:=IntToStr(n);
      grill.Cells[i+1,j]:=FormatFloat('0.0000',xo)+' , '+FormatFloat('0.0000',xi);
      grill.Cells[i+2,j]:=FormatFloat('0.0000',(ui-xo)*-1)+' , '+FormatFloat('0.0000',(vi-xi)*-1);
      grill.Cells[i+3,j]:=FormatFloat('0.0000',e);

      if (n<>0) and (n mod 3=0) then
      begin
         e1:=e;
      end;
      if (e1<>0) and (e1<e) then
      begin
         ShowMessage('La funcion Diverge');
         exit;
      end;
      xo:=ui;
      xi:=vi;
      n:=n+1;
      j:=j+1;
      grill.RowCount:=grill.RowCount+1;
  end;
  ShowMessage('La raiz es: '+FormatFloat('0.0000',xo)+' , '+FormatFloat('0.0000',xi));
end;
 function Tnolineal.Lagrange(serie:TStringGrid; xo:Real;text:TStaticText):Real;
var
  fi,i,j :Integer;
  mul,sum,c,d: Real;
  pln:String;
begin
  fi:=serie.ColCount-1; //
  pln:='';
  c:=1;
  sum:=0;
  for i:=1 to fi do
  begin
    mul:=1;
      for j:=1 to fi do
      begin
        if j<>i then
        begin
          pln:=pln+'(x-'+serie.Cells[j,0]+')';
          d:=StrToFloat(serie.Cells[i,0])-StrToFloat(serie.Cells[j,0]);
          c:=c*d;
          mul:=mul*(xo-StrToFloat(serie.Cells[j,0]))/d;  //
        end;
      end;

      pln:=pln+'*(1/'+FloatToStr(c)+')';
      c:=1;
      if i<>(fi) then
         pln:=pln+' + ';
      sum:=sum+(mul*StrToFloat(serie.Cells[i,1]));      //
  end;
  text.Caption:=pln;
  Result:=sum;
end;

end.

