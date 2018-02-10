unit grafica;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TGraph = class
  Chart1: TChart;
  colorbtnFunction: TColorButton;
  ScrollBox1: TScrollBox;
  TrackBar1: TTrackBar;
  trbarVisible: TTrackBar;
    private
    public

  end;

implementation

const
  FunctionEditName = 'FunctionEdit';
  FunctionSeriesName = 'FunctionLines';

end.

