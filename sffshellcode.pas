unit sffshellcode;

{
 This software was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

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
    function get_options():string;
    procedure do_job(const target:string);
    procedure window_setup();
    procedure dialog_setup();
    procedure interface_setup();
    procedure language_setup();
    procedure setup();
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

function TMainWindow.get_options():string;
var options:string;
begin
 options:='-i -p ';
 if Self.ErrorCheckBox.Checked=True then options:=options+'-f ';
 if Self.PaletteCheckBox.Checked=True then options:=options+'-1 ';
 if Self.SubDirectoryCheckBox.Checked=True then options:=options+'-d ';
 if Self.ShortNamesCheckBox.Checked=True then options:=options+'-8 ';
 if Self.HexaDecimalCheckBox.Checked=True then options:=options+'-x ';
 if Self.ModernMugenCheckBox.Checked=True then options:=options+'-n ';
 Result:=options;
end;

procedure TMainWindow.do_job(const target:string);
var backend,options:string;
begin
 backend:=ExtractFilePath(Application.ExeName)+'sffextract.exe';
 options:=Self.get_options()+convert_file_name(target);
 if execute_program(backend,options)<>0 then ShowMessage('Cannot extract an images');
end;

procedure TMainWindow.window_setup();
begin
 Application.Title:='SFFEXTRACT SHELL';
 Self.Caption:='SFFEXTRACT SHELL 2.7.6';
 Self.BorderStyle:=bsDialog;
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
end;

procedure TMainWindow.dialog_setup();
begin
 Self.OpenDialog.InitialDir:='';
 Self.OpenDialog.DefaultExt:='*.sff';
 Self.OpenDialog.FileName:='*.sff';
 Self.OpenDialog.Filter:='Sff file|*.sff';
end;

procedure TMainWindow.interface_setup();
begin
 Self.OpenButton.ShowHint:=False;
 Self.ExtractButton.ShowHint:=False;
 Self.ExtractButton.Enabled:=False;
 Self.FileField.Enabled:=False;
 Self.FileField.LabelPosition:=lpLeft;
 Self.FileField.Text:='';
end;

procedure TMainWindow.language_setup();
begin
 Self.FileField.EditLabel.Caption:='The file';
 Self.OpenButton.Caption:='Open';
 Self.ExtractButton.Caption:='Extract';
 Self.ErrorCheckBox.Caption:='Igrone an errors';
 Self.PaletteCheckBox.Caption:='Use the shared palette';
 Self.SubDirectoryCheckBox.Caption:='Put a sprites in the subdirectory';
 Self.ShortNamesCheckBox.Caption:='Use short file names';
 Self.HexaDecimalCheckBox.Caption:='Use hexadecimal numbers as file names';
 Self.ModernMugenCheckBox.Caption:='This file is designed for MUGEN 2001.04.14';
 Self.OpenDialog.Title:='Open a mugen graphic container';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.dialog_setup();
 Self.interface_setup();
 Self.language_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.FileFieldChange(Sender: TObject);
begin
 Self.ExtractButton.Enabled:=Self.FileField.Text<>'';
end;

procedure TMainWindow.OpenButtonClick(Sender: TObject);
begin
 if Self.OpenDialog.Execute()=True then Self.FileField.Text:=Self.OpenDialog.FileName;
end;

procedure TMainWindow.ExtractButtonClick(Sender: TObject);
begin
 do_job(Self.FileField.Text);
end;

end.
