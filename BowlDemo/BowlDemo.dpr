program BowlDemo;

uses
  Vcl.Forms,
  uTestBowlForm in 'uTestBowlForm.pas' {FormTestBowl};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormTestBowl, FormTestBowl);
  Application.Run;
end.
