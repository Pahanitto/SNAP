program SnapClient;

uses
  Vcl.Forms,
  clmain in 'clmain.pas' {fclMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfclMain, fclMain);
  Application.Run;
end.
