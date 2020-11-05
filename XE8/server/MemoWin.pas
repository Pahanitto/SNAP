unit MemoWin;

interface

uses
  System.SysUtils, Vcl.Dialogs, Vcl.Menus, System.Classes,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Forms;

type
  TfMemoWin = class(TForm)
    mText: TMemo;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMemoWin: TfMemoWin;

implementation

{$R MemoWin.dfm}

//----------------------------------------------------------------------------------------

procedure TfMemoWin.N2Click(Sender: TObject);
begin
  if SaveDialog1.Execute() then
   Self.mText.Lines.SaveToFile( SaveDialog1.FileName );
end;

//----------------------------------------------------------------------------------------

procedure TfMemoWin.N3Click(Sender: TObject);
begin
  Self.Close();
end;

//----------------------------------------------------------------------------------------

end.
