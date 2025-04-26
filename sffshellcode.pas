unit sffshellcode; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    OpenButton: TButton;
    ExtractButton: TButton;
    ErrorCheckBox: TCheckBox;
    PaletteCheckBox: TCheckBox;
    SubDirectoryCheckBox: TCheckBox;
    ShortNamesCheckBox: TCheckBox;
    HexaDecimalCheckBox: TCheckBox;
    ModernMugenCheckBox: TCheckBox;
    FileField: TLabeledEdit;
    OpenDialog: TOpenDialog;
    procedure OpenButtonClick(Sender: TObject);
    procedure ExtractButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileFieldChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var MainWindow: TMainWindow;

implementation

{$R *.lfm}

function convert_file_name(const source:string): string;
var target:string;
begin
 target:=source;
 if Pos(' ',source)>0 then
 begin
  target:='"'+source+'"';
 end;
 convert_file_name:=target;
end;

function execute_program(const executable:string;const argument:string):Integer;
var code:Integer;
begin
 try
  code:=ExecuteProcess(executable,argument,[]);
 except
  code:=-1;
 end;
 execute_program:=code;
end;

function get_options():string;
var options:string;
begin
 options:='-i -p ';
 if MainWindow.ErrorCheckBox.Checked=True then options:=options+'-f ';
 if MainWindow.PaletteCheckBox.Checked=True then options:=options+'-1 ';
 if MainWindow.SubDirectoryCheckBox.Checked=True then options:=options+'-d ';
 if MainWindow.ShortNamesCheckBox.Checked=True then options:=options+'-8 ';
 if MainWindow.HexaDecimalCheckBox.Checked=True then options:=options+'-x ';
 if MainWindow.ModernMugenCheckBox.Checked=True then options:=options+'-n ';
 get_options:=options;
end;

procedure do_job(const target:string);
var backend,options:string;
begin
 backend:=ExtractFilePath(Application.ExeName)+'sffextract.exe';
 options:=get_options()+convert_file_name(target);
 if execute_program(backend,options)=-1 then ShowMessage('Can not run an external program');
end;

procedure window_setup();
begin
 Application.Title:='SFFEXTRACT SHELL';
 MainWindow.Caption:='SFFEXTRACT SHELL 2.7.3';
 MainWindow.BorderStyle:=bsDialog;
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
end;

procedure dialog_setup();
begin
 MainWindow.OpenDialog.InitialDir:='';
 MainWindow.OpenDialog.DefaultExt:='*.sff';
 MainWindow.OpenDialog.FileName:='*.sff';
 MainWindow.OpenDialog.Filter:='Sff file|*.sff';
end;

procedure interface_setup();
begin
 MainWindow.OpenButton.ShowHint:=False;
 MainWindow.ExtractButton.ShowHint:=MainWindow.OpenButton.ShowHint;
 MainWindow.ExtractButton.Enabled:=False;
 MainWindow.FileField.Enabled:=MainWindow.ExtractButton.Enabled;
 MainWindow.FileField.LabelPosition:=lpLeft;
 MainWindow.FileField.Text:='';
end;

procedure language_setup();
begin
 MainWindow.FileField.EditLabel.Caption:='The file';
 MainWindow.OpenButton.Caption:='Open';
 MainWindow.ExtractButton.Caption:='Extract';
 MainWindow.ErrorCheckBox.Caption:='Igrone an errors';
 MainWindow.PaletteCheckBox.Caption:='Use the shared palette';
 MainWindow.SubDirectoryCheckBox.Caption:='Put a sprites in the subdirectory';
 MainWindow.ShortNamesCheckBox.Caption:='Use short file names';
 MainWindow.HexaDecimalCheckBox.Caption:='Use hexadecimal numbers as file names';
 MainWindow.ModernMugenCheckBox.Caption:='This file is designed for MUGEN 2001.04.14';
 MainWindow.OpenDialog.Title:='Open a mugen graphic container';
end;

procedure setup();
begin
 window_setup();
 dialog_setup();
 interface_setup();
 language_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
setup();
end;

procedure TMainWindow.FileFieldChange(Sender: TObject);
begin
 MainWindow.ExtractButton.Enabled:=MainWindow.FileField.Text<>'';
end;

procedure TMainWindow.OpenButtonClick(Sender: TObject);
begin
 if MainWindow.OpenDialog.Execute()=True then MainWindow.FileField.Text:=MainWindow.OpenDialog.FileName;
end;

procedure TMainWindow.ExtractButtonClick(Sender: TObject);
begin
 do_job(MainWindow.FileField.Text);
end;

end.
