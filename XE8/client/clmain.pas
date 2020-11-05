unit clmain;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Datasnap.Provider, Vcl.DBCtrls, Vcl.Grids,  Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.ExtDlgs, Vcl.Controls, IPPeerClient, Data.SqlExpr, Data.DB,
  Data.DBXCommon, Datasnap.DBClient, Data.DBXDataSnap, Data.FMTBcd;

type
  TfclMain = class(TForm)
    SQLConnection1: TSQLConnection;
    SqlServerMethod1: TSqlServerMethod;
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    ehost: TEdit;
    Label1: TLabel;
    ePort: TEdit;
    bName: TButton;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    bCSV: TButton;
    DBNavigator1: TDBNavigator;
    procedure bNameClick(Sender: TObject);
    procedure bCSVClick(Sender: TObject);
    procedure SQLConnection1AfterConnect(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fclMain: TfclMain;

implementation

{$R *.dfm}

//----------------------------------------------------------------------------------
// CSV
procedure TfclMain.bCSVClick(Sender: TObject);
const
  _Del  : String = ';'; // разделитель ...пусть такой стандартный
var
  i     : Integer;
  StrL  : TStringList;
  SRes  : String;
  Book  : TBookMark;
  Enc   : TEncoding;
begin
// сохраним ручками
//все кандово самыми простыми средаствами
//будемм считать что "безразмерных" полей нет... .
//как в задачке все просто...числа текст дата

i := 0;
StrL := TStringList.Create();
try
  with Self.ClientDataSet1 do
  begin
    Book := ClientDataSet1.GetBookmark();
    DisableControls();
    First();
    while not Eof do
    begin
      SRes  := '';
      i     := 0;
      while i < FieldCount do begin
        SRes := SRes + Fields[i].AsString + _Del;
        Inc( i );
      end;
      StrL.Add( SRes );
      Next();
    end;
  end;

  if SaveDialog1.Execute() then
  begin
    Enc := TEncoding.UTF8;  // пусть всегда  будет солнце)
    StrL.SaveToFile( SaveDialog1.FileName , Enc );
  end;

finally
  StrL.Free();
  with Self.ClientDataSet1 do
  begin
    if BookmarkValid( Book ) then
      GotoBookmark( Book );
    EnableControls();
  end;
end;

end;

//----------------------------------------------------------------------------------
//законектимся
procedure TfclMain.bNameClick(Sender: TObject);
begin
  SQLConnection1.Close();
  with SQLConnection1.Params do
  begin
    Clear();
    Append('DriverName=DataSnap');
    Append('HostName=' + trim( ehost.Text ) );
    Append('Port=' + trim( ePort.Text ) );
  end;

  try
    SQLConnection1.Open();
    ClientDataSet1.Open();
  except on Exception do
    begin
      MessageDlg('Ошибка!' ,mtError ,[mbOk] ,-1);
      ClientDataSet1.Close();
      SQLConnection1.Close();
    end;
  end;

end;

//----------------------------------------------------------------------------------

procedure TfclMain.DataSource1StateChange(Sender: TObject);
begin
  bCSV.Enabled :=  ClientDataSet1.Active;
end;

//----------------------------------------------------------------------------------
//не ьудем навешивать всякие акшенлисты и датабилдингс
procedure TfclMain.SQLConnection1AfterConnect(Sender: TObject);
begin
    eHost.Enabled := False;
    ePort.Enabled := False;
    bName.Enabled := False;
end;

//----------------------------------------------------------------------------------

end.
