unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, Grids, Menus, ExtCtrls, Spin, Types, metodos_abiertos,
  ParseMath, metodosabiertos, Matrices, lagra_raphson, TASeries, TAFuncSeries,
  ColorBox, TARadialSeries, TATools, uCmdBox, LCLType, trapecio, edo;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Chart1: TChart;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    colorbtnFunction: TColorButton;
    ColorButton1: TColorButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    ediMin: TEdit;
    ediMax: TEdit;
    ediStep: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    PageControl1: TPageControl;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    ScrollBox1: TScrollBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TrackBar1: TTrackBar;
    trbarVisible: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ColorButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit24Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    function f(x:real;s:string):real;
    procedure MatrizToGrill(m: TMatrices; res:TStringGrid);
    procedure trbarVisibleChange(Sender: TObject);
    procedure FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FunctionList,
    EditList: TList;
    ActiveFunction: Integer;
    min,
    max: Real;
    Parse  : TparseMath;
    function f( x: Real ): Real;
    procedure CreateNewFunction;
    procedure Graphic2D;

  public

  end;

var
  Form1: TForm1;
  x : real;
  i,j,u,v,fila,cont1,cont2:Integer;
  matri : TMatrices;
  mn : Tnolineal;
  inte : TIntegrales;

implementation
 const
 col_pos = 0;
 col_iA = 1;
 col_iB = 2;
 col_Xn = 3;
 col_signo = 4;
 col_err = 5;
 FunctionEditName = 'FunctionEdit';
  FunctionSeriesName = 'FunctionLines';

{$R *.lfm}

{ TForm1 }



function TForm1.f(x:real;s:string):real;
var MiParse: TParseMath;
begin
  MiParse:= TParseMath.create();
  MiParse.AddVariable('x',x);
  MiParse.Expression:= s;
  check:=false;
  //try
    //result:=MiParse.Evaluate();
  //except
    //begin
    //ShowMessage('La funcion no es continua en el punto '+FloatToStr(x));
    //check:=true;
  //  end;
//end;

  MiParse.destroy;

end;
procedure TForm1.MatrizToGrill(m : TMatrices; res:TStringGrid);
var
  ma,na :Integer;
begin
  ma:=Length(m.A);na:=Length(m.A[0]);
  res.RowCount:=ma; res.ColCount:=na;
  for i:=0 to ma-1 do
    for j:=0 to na-1 do
      res.Cells[j,i]:=FloatToStr(m.A[i,j]);
end;


procedure TForm1.trbarVisibleChange(Sender: TObject);
begin
  Self.AlphaBlendValue:= trbarVisible.Position;
end;

function TForm1.f(x: Real): Real;
begin
    Parse.Expression:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.NewValue('x', x);
  Result:= Parse.Evaluate();
end;



procedure TForm1.Graphic2D;
var x, h: Real;

begin
  h:= StrToFloat( ediStep.Text );
  min:= StrToFloat( ediMin.Text );
  max:= StrToFloat( ediMax.Text );


  with TLineSeries( FunctionList[ ActiveFunction ] ) do begin
  try
       LinePen.Color:= ColorButton1.ButtonColor;
       LinePen.Width:= TrackBar1.Position;
  Except On E: Exception do
       ShowMessage( E.ClassName + LineEnding + E.Message );

  end;

  end;

  x:= min;
  TLineSeries( FunctionList[ ActiveFunction ] ).Clear;
  with TLineSeries( FunctionList[ ActiveFunction ] ) do
  repeat
      AddXY( x, f(x) );
      x:= x + h
  until ( x>= max );



end;

procedure TForm1.CreateNewFunction;
begin
   EditList.Add( TEdit.Create(ScrollBox1) );

   //We create Edits with functions
   with Tedit( EditList.Items[ EditList.Count - 1 ] ) do begin
        Parent:= ScrollBox1;
        Align:= alTop;
        name:= FunctionEditName + IntToStr( EditList.Count );
        OnKeyUp:= @FunctionsEditKeyUp;
        Font.Size:= 15;
        Text:= EmptyStr;
        Tag:= EditList.Count - 1;
        SetFocus;

   end;

   //We create serial functions
   FunctionList.Add( TLineSeries.Create( Chart1 ) );
   with TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) do begin
        Name:= FunctionSeriesName + IntToStr( FunctionList.Count );
        Tag:= EditList.Count - 1; // Edit Asossiated

   end;


   Chart1.AddSeries( TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) );

end;
procedure TForm1.FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if not (key = VK_RETURN) then
     exit;

   with TEdit( Sender ) do begin
       ActiveFunction:= Tag;
       Graphic2D;
       if tag = EditList.Count - 1 then
          CreateNewFunction;
   end;

end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
var Metodos: TCerrados;
var iRow: Integer;
var iA, iB, error: Double;
var ecuacion: String;
begin
  Metodos:= TCerrados.create;
  Metodos.MetodoType:= RadioGroup1.ItemIndex;
  iA:= StrToFloat(Edit2.Text);
  iB:= StrToFloat(Edit3.Text);
  error:= StrToFloat(Edit4.Text);
  ecuacion:= Edit1.Text;
  Metodos.ejecutarCerrados(iA, iB, error, ecuacion);
  StringGrid1.RowCount:= Metodos.datos.Count;
  StringGrid1.Cols[ col_iA ].Assign( Metodos.La );
  StringGrid1.Cols[ col_iB ].Assign( Metodos.Lb );
  StringGrid1.Cols[ col_Xn ].Assign( Metodos.datos );
  StringGrid1.Cols[ col_signo ].Assign( Metodos.Lsig );
  StringGrid1.Cols[ col_err ].Assign( Metodos.Le );
  with StringGrid1 do
   for iRow:= 1 to RowCount - 1 do begin
     Cells[ col_pos, iRow ]:= IntToStr( iRow );
   end;
  Metodos.Destroy;
end;

procedure TForm1.Button2Click(Sender: TObject);
  var Abierto: TAbiertos;
var iRow: Integer;
var iA, iB, error: Double;
var ecuacion, decuacion: String;
begin
  Abierto:= TAbiertos.create;
  Abierto.MetodoType:= RadioGroup2.ItemIndex;
  iA:= StrToFloat(Edit6.Text);
  error:= StrToFloat(Edit7.Text);
  ecuacion:= Edit5.Text;
  decuacion:= Edit8.Text;
  Abierto.ejecutarAbiertos(iA, error, ecuacion, decuacion);
  StringGrid2.RowCount:= Abierto.datos.Count;
  StringGrid2.Cols[ 1 ].Assign( Abierto.datos );
  StringGrid2.Cols[ 2 ].Assign( Abierto.Le );

  with StringGrid2 do
   for iRow:= 1 to RowCount - 1 do begin
     Cells[ col_pos, iRow ]:= IntToStr( iRow );
   end;
  Abierto.Destroy;
end;

procedure TForm1.Button3Click(Sender: TObject);
var a,b,c :TMatrices;
  d:Real;
  i: Integer;
begin
  if ComboBox1.Text='Suma' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     b := TMatrices.Create(StringGrid4.RowCount,StringGrid4.ColCount);
     a.GrillToMatrix(StringGrid3);
     b.GrillToMatrix(StringGrid4);
     c:= TMatrices.Create(StringGrid4.RowCount,StringGrid4.ColCount);
     c:=a.MSuma(b);
     MatrizToGrill(c,StringGrid5);
  end;
  if ComboBox1.Text='Resta' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     b := TMatrices.Create(StringGrid4.RowCount,StringGrid4.ColCount);
     a.GrillToMatrix(StringGrid3);
     b.GrillToMatrix(StringGrid4);
     c:= TMatrices.Create(StringGrid4.RowCount,StringGrid4.ColCount);
     c:=a.MResta(b);
     MatrizToGrill(c,StringGrid5);
  end;

  if ComboBox1.Text='Multiplicar' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     b := TMatrices.Create(StringGrid4.RowCount,StringGrid4.ColCount);
     a.GrillToMatrix(StringGrid3);
     b.GrillToMatrix(StringGrid4);
     c:= TMatrices.Create(StringGrid3.RowCount,StringGrid4.ColCount);
     c:=a.MMultiplicacion(a,b);
     MatrizToGrill(c,StringGrid5);
  end;
  if ComboBox1.Text='Escalar' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid4.ColCount);
     a.GrillToMatrix(StringGrid3);
     c:= TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     c:=a.MMultEscalar(a,StrToFloat(Edit9.Text));
     MatrizToGrill(c,StringGrid5);
  end;

  if ComboBox1.Text='Inversa' then
  begin
    if StringGrid3.RowCount=StringGrid3.ColCount then
    begin
       a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
       a.GrillToMatrix(StringGrid3);
       c:= TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
       c:=a.MInversa(a);
       MatrizToGrill(c,StringGrid5);
    end
    else
       ShowMessage('La matriz tiene que ser cuadrada');
  end;
  if ComboBox1.Text='Transpuesta' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     a.GrillToMatrix(StringGrid3);
     c:= TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     c:=a.MTranspuesta(a);
     MatrizToGrill(c,StringGrid5);
  end;

  if ComboBox1.Text='Determinante' then
  begin
     a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
     a.GrillToMatrix(StringGrid3);
     d:=a.MDeterminante(a);
     StaticText1.Caption:=FloatToStr(d);
  end;

  if ComboBox1.Text='Potencia' then
  begin
    a := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
    b := TMatrices.Create(StringGrid3.RowCount,StringGrid3.ColCount);
    a.GrillToMatrix(StringGrid3);
    b.GrillToMatrix(StringGrid3);
    for i:=1 to StrToInt(Edit9.Text)-1 do begin
          a := a.MMultiplicacion(a,b);
     end;
    MatrizToGrill(a,StringGrid5);
  end;

end;


procedure TForm1.Button4Click(Sender: TObject);
   var
  x0,x1,x2:Real;
  variable:Integer;
  fx,fy,fz:String;
begin
  x0:=StrToFloat(Edit12.Text);
  x1:=StrToFloat(Edit13.Text);
  x2:=StrToFloat(Edit18.Text);
  variable:=StrToInt(Edit17.Text);
  fx:=Edit10.Text;
  fy:=Edit11.Text;
  fz:=Edit16.Text;
  mn.raphson(x0,x1,x2,fx,fy,fz,variable,StrToFloat(Edit14.Text),StringGrid6);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
   StaticText2.Caption:=FloatToStr(mn.Lagrange(StringGrid7,StrToFloat(Edit15.Text),StaticText1));
   Memo1.Text:=StaticText1.Caption;
end;

procedure TForm1.Button6Click(Sender: TObject);
var ecuacion: string ;
var a,b:real;
var particion : integer;
begin
  ecuacion :=(Edit20.Text);
  a:= StrToFloat(Edit21.Text);
  b:= StrToFloat(Edit22.Text);
  particion := StrToInt(Edit23.Text);
  Memo2.Text:= FloatToStr( inte.trapecio(ecuacion,a,b,particion)   );
end;

procedure TForm1.Button7Click(Sender: TObject);
var ecuacion: string ;
var a,b:real;
var particion : integer;
begin
  ecuacion :=(Edit20.Text);
  a:= StrToFloat(Edit21.Text);
  b:= StrToFloat(Edit22.Text);
  particion := StrToInt(Edit23.Text);
  Memo2.Text:= FloatToStr( inte.simpson(ecuacion,a,b,particion)   );
end;

procedure TForm1.Button8Click(Sender: TObject);
var Edo: TEdo;
var iRow: Integer;
var varx, vary, h: Double;
var ecuacion: String;
begin
  Edo:= TEdo.create;
  Edo.MetodoType:= RadioGroup4.ItemIndex;
  varx:= StrToFloat(Edit25.Text);
  vary:= StrToFloat(Edit26.Text);
  h:= StrToFloat(Edit27.Text);
  ecuacion:= Edit24.Text;
  Edo.ejecutarEdo(ecuacion,varx,vary,h);
  StringGrid8.RowCount:= Edo.Lxn.Count;
  StringGrid8.Cols[ 1 ].Assign( Edo.Lxn );
  StringGrid8.Cols[ 2 ].Assign( Edo.Lyn2 );
  StringGrid8.Cols[ 3 ].Assign( Edo.Lyn );

  with StringGrid8 do
   for iRow:= 1 to RowCount - 1 do begin
     Cells[ col_pos, iRow ]:= IntToStr( iRow );
   end;
  //Memo3.text:= FloatToStr(Edo.euler(ecuacion,varx,vary,h));
  Edo.Destroy;


end;

procedure TForm1.ColorButton1Click(Sender: TObject);
begin

end;

procedure TForm1.ComboBox1Change(Sender: TObject);

  begin
  Edit9.Enabled:=False;
  GroupBox2.Enabled:=False;
  GroupBox1.Enabled:=True;

  if (ComboBox1.Text='Suma')or(ComboBox1.Text='Resta')or(ComboBox1.Text='Multiplicar') then
  begin
    GroupBox2.Enabled:=True;
  end;

  if (ComboBox1.Text='Escalar') or (ComboBox1.Text='Potencia') then
  begin
    Edit9.Enabled:=True;
  end;
end;

procedure TForm1.Edit24Change(Sender: TObject);
begin

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    ComboBox1.Items.Clear;
  ComboBox1.Items.Add('Suma');
  ComboBox1.Items.Add('Resta');
  ComboBox1.Items.Add('Escalar');
  ComboBox1.Items.Add('Multiplicar');
  ComboBox1.Items.Add('Inversa');
  ComboBox1.Items.Add('Transpuesta');
  ComboBox1.Items.Add('Determinante');
  ComboBox1.Items.Add('Potencia');
  GroupBox1.Enabled:=False;
  GroupBox2.Enabled:=False;
  Edit9.Enabled:=False;
  FunctionList:= TList.Create;
  EditList:= TList.Create;
  min:= -5.0;
  max:= 5.0;
  Parse:= TParseMath.create();
  Parse.AddVariable('x', min);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  CreateNewFunction;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  cont1:=0;
  i:=0;
  j:=0;
  StringGrid3.Clear;
  StringGrid3.RowCount:=SpinEdit1.Value;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin
  cont1:=0;
  i:=0;
  j:=0;
  StringGrid3.Clear;
  StringGrid3.ColCount:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin
  cont2:=0;
  u:=0;
  v:=0;
  StringGrid4.Clear;
  StringGrid4.RowCount:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4Change(Sender: TObject);
begin
  cont2:=0;
  u:=0;
  v:=0;
  StringGrid4.Clear;
  StringGrid4.ColCount:=SpinEdit4.Value;
end;

procedure TForm1.SpinEdit5Change(Sender: TObject);
begin
  fila:=1;
  StringGrid7.Clear;
  StringGrid7.ColCount:=SpinEdit5.Value+1;
  StringGrid7.Cells[0,0]:='X';
  StringGrid7.Cells[0,1]:='Y';
end;


end.

