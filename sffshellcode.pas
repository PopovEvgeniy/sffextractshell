unit sffshellcode; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Dialogs, ExtCtrls, StdCtrls, LazFileUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var Form1: TForm1;

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
 if Form1.CheckBox1.Checked=True then options:=options+'-f ';
 if Form1.CheckBox2.Checked=True then options:=options+'-1 ';
 if Form1.CheckBox3.Checked=True then options:=options+'-d ';
 if Form1.CheckBox4.Checked=True then options:=options+'-8 ';
 if Form1.CheckBox5.Checked=True then options:=options+'-x ';
 if Form1.CheckBox6.Checked=True then options:=options+'-n ';
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
 Form1.Caption:='SFFEXTRACT SHELL 2.7';
 Form1.BorderStyle:=bsDialog;
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
end;

procedure dialog_setup();
begin
 Form1.OpenDialog1.InitialDir:='';
 Form1.OpenDialog1.DefaultExt:='*.sff';
 Form1.OpenDialog1.FileName:='*.sff';
 Form1.OpenDialog1.Filter:='Sff file|*.sff';
end;

procedure interface_setup();
begin
 Form1.Button1.ShowHint:=False;
 Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
 Form1.Button2.Enabled:=False;
 Form1.LabeledEdit1.Enabled:=Form1.Button2.Enabled;
 Form1.LabeledEdit1.LabelPosition:=lpLeft;
 Form1.LabeledEdit1.Text:='';
end;

procedure language_setup();
begin
 Form1.LabeledEdit1.EditLabel.Caption:='The file';
 Form1.Button1.Caption:='Open';
 Form1.Button2.Caption:='Extract';
 Form1.CheckBox1.Caption:='Igrone an error';
 Form1.CheckBox2.Caption:='Use the shared palette';
 Form1.CheckBox3.Caption:='Put a sprites in the subdirectory';
 Form1.CheckBox4.Caption:='Use short file names';
 Form1.CheckBox5.Caption:='Use hexadecimal numbers as file names';
 Form1.CheckBox6.Caption:='This file is designed for MUGEN 2001.04.14';
 Form1.OpenDialog1.Title:='Open a mugen graphic container';
end;

procedure setup();
begin
 window_setup();
 dialog_setup();
 interface_setup();
 language_setup();
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
setup();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
 Form1.Button2.Enabled:=Form1.LabeledEdit1.Text<>'';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Form1.OpenDialog1.Execute()=True then Form1.LabeledEdit1.Text:=Form1.OpenDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 do_job(Form1.LabeledEdit1.Text);
end;

end.
