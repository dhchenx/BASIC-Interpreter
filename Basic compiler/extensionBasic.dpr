program extensionBasic;

uses
  Forms,
  Basic in 'Basic.pas' {Form43};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm43, Form43);
  Application.Run;
end.
