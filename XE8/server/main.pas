{все простенько с минимальными настройками коннекта, зачатком трасировки да и все}
unit main;

interface

uses   Vcl.Mask, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Controls,
       Vcl.Forms, System.ImageList, Vcl.ImgList, System.Classes,
       Vcl.Dialogs, System.SysUtils, System.UITypes, Vcl.Graphics,
       Winsock, System.DateUtils, ServerContainerUnit1, ServerMethodsUnit1;

type
  TfMain = class(TForm)
    gbSnapNew: TGroupBox;
    ImageList1: TImageList;
    gbSnapStat: TGroupBox;
    lStatus: TLabel;
    LSnapDTStart: TLabel;
    Label6: TLabel;
    lSnapPort: TLabel;
    Label9: TLabel;
    lSQLHost: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lSnapHost: TLabel;
    lSQLAut: TLabel;
    Label19: TLabel;
    lSQLDB: TLabel;
    Label21: TLabel;
    Bevel1: TBevel;
    lSnapTimeOnline: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    LSnapCon: TLabel;
    Button1: TButton;
    bStopServ: TButton;
    Bevel3: TBevel;
    Timer1: TTimer;
    Bevel2: TBevel;
    bStartServ: TButton;
    cbOSAut: TCheckBox;
    eDB: TEdit;
    eSQLHost: TEdit;
    eLogin: TEdit;
    ePass: TEdit;
    ePort: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LSnapHostNew: TLabel;
    procedure bStartServClick(Sender: TObject);
    procedure bStopServClick(Sender: TObject);
    procedure cbOSAutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure SetParamsConn();
    procedure SetEnableStat(FWinCon: TWinControl; FEnabled: Boolean);
    function GetElapsedTiemStr(DFrom: TDateTime; ErrStr: String = ''): String;
  protected
    procedure LoadStringsFromData(L: TStrings);
  public
    procedure ChangeVisual();
  end;

var
  fMain: TfMain;
  _vMyHost: String = 'LocalHost';

const
  _Erraser  = '   ---  ';
  _isStarted= 'работает';
  _isStoped = 'стоп';
  _OsAut = ' OS авторизация ';


function GetMyHost (): String;

implementation

{$R *.dfm}

uses MemoWin, uStats;

//----------------------------------------------------------------------------------------

procedure TfMain.bStartServClick(Sender: TObject);
begin
  SetParamsConn();
  //тестирууем БД
  if not ServerMethodsUnit1.TestConParam() then
  begin
    MessageDLG( 'Ошибка! '#10#13'Параметры базы неверные.',
      mtError, [mbOK], -1 );
    exit;
  end;

//стартуем
  try
    with ServerContainerUnit1.ServerContainer1 do
    begin
      DSServer1.Stop();
      DSServer1.Start();
    end;
  except on Exception do
    MessageDlg( 'Ошибка старта сервера!', mtError, [mbOk], -1 );
  end;

  Self.ChangeVisual();
end;

//----------------------------------------------------------------------------------------

procedure TfMain.bStopServClick(Sender: TObject);
begin
  if MessageDLG( 'Вы уверенны что хотите остановить сервер?',
      mtWarning, [mbOK, mbCancel], -1 ) = mrOK then
  begin
    ServerContainerUnit1.ServerContainer1.DSServer1.Stop();
  end;
end;

//----------------------------------------------------------------------------------------

procedure TfMain.Button1Click(Sender: TObject);
var
  MW : TfMemoWin;
begin
  MW := TfMemoWin.Create( Self );
  with MW do
  try
    LoadStringsFromData( mText.Lines );
    ShowModal();
  finally
    Destroy();
  end;
end;

//----------------------------------------------------------------------------------------

procedure TfMain.cbOSAutClick(Sender: TObject);
begin
  eLogin.Enabled  := not cbOSAut.Checked;
  ePass.Enabled   := not cbOSAut.Checked;
end;

//----------------------------------------------------------------------------------------

procedure TfMain.ChangeVisual();
begin
  with ServerContainerUnit1.ServerContainer1 do
   begin
      vSerHost_ := GetMyHost();

      SetEnableStat( gbSnapStat, DSServer1.Started) ;
      SetEnableStat( gbSnapNew, Not DSServer1.Started );

      if DSServer1.Started then
      begin
        Timer1.Enabled      := True;

        lStatus.Font.Color  := clGreen;
        lStatus.Caption     := _isStarted;

        LSnapDTStart.Caption:= DateTimeToStr( vSnapStartTime_ );
        LSnapCon.Caption    := IntToStr( vAllCon_ ) + ' / ' + IntToStr( vActiveCon_ );
        lSnapHost.Caption   := vSerHost_;
        LSnapHostNew.Caption:= vSerHost_;
        lSnapPort.Caption   := IntToStr ( vPort_ );
        lSnapTimeOnline.Caption := GetElapsedTiemStr( vSnapStartTime_, _Erraser );
        lSQLHost.Caption    := vSQLHost_;
        lSQLDB.Caption      := vDB_;
        if vOSAut_ then
          lSQLAut.Caption   := _OsAut
        else
          lSQLAut.Caption   := vLogin_;

    end
      else begin
        Timer1.Enabled      := False;

        lStatus.Caption     := _isStoped;
        lStatus.Font.Color  := clRed;

        LSnapDTStart.Caption:= _Erraser;
        LSnapCon.Caption    := _Erraser;
        lSnapHost.Caption   := _Erraser;
        LSnapHostNew.Caption:= vSerHost_;
        lSnapPort.Caption   := _Erraser;
        lSnapPort.Caption   := _Erraser;
        lSnapTimeOnline.Caption :=  _Erraser;

        lSQLHost.Caption    := _Erraser;
        lSQLDB.Caption      := _Erraser;
        lSQLAut.Caption     := _Erraser;
      end;
    end;

end;

//----------------------------------------------------------------------------------------

procedure TfMain.FormShow(Sender: TObject);
begin
  ChangeVisual();
end;

//----------------------------------------------------------------------------------------

function TfMain.GetElapsedTiemStr(DFrom: TDateTime; ErrStr: String = ''): String;
var
 D, H, M, S : Integer;
 MS         : LongInt;
begin
  MS := Trunc( SecondSpan(Now() , DFrom) );
  if MS > 0 then
  begin
    D := (MS div 3600) div 24;
    H := (MS - (D * 24 * 3600) ) div 3600;
    M := (MS - (D * 24 * 3600) - (H * 3600) ) div 60;
    S :=  MS - (D * 24 * 3600) - (H * 3600) -  (M * 60);
    Result := Format('%d дней %d:%d:%d', [D, H, M, S]);
  end else
    Result := ErrStr;
end;

//----------------------------------------------------------------------------------------
//собираем стринс по данным сервера
procedure TfMain.LoadStringsFromData(L: TStrings);
var
  S: String;
begin
  with L do
  begin
    Clear();
    Add('');
    Add('----------------------------------------------------------------');
    Add('');

    Add('Дата отчета:  ' + DateTimeToStr( Now() ));
    Add('Дата старта:  ' + DateTimeToStr( ServerContainer1.vSnapStartTime_ ));
    Add('Время работы: ' + GetElapsedTiemStr( ServerContainer1.vSnapStartTime_, _Erraser ));

    Add('');

    Add('ХОСТ сервера: ' + ServerContainer1.vSerHost_);
    Add('Порт сервера: ' + IntToStr( ServerContainer1.vPort_ ));

    Add('');

    Add('ХОСТ SQL: ' + ServerContainer1.vSQLHost_);
    Add('DB: ' + ServerContainer1.vDB_);
    if ServerContainer1.vOSAut_ then
      S := _OsAut
    else
      S := ServerContainer1.vLogin_;
    Add('Логин: ' + S);

    Add('');

    Add('Всего / Активных: ' + IntToStr( ServerContainer1.vAllCon_ )
          + ' / ' + IntToStr( ServerContainer1.vActiveCon_ ) );

    Add('');
    Add('----------------------------------------------------------------');
    Add('');
  end;
  ServerContainer1.vListEvents.GetStrings(L);
end;

//----------------------------------------------------------------------------------------
//какойто глюк чтоли.. визуалку чтот не подсвечивает - легче самому прописать
procedure TfMain.SetEnableStat(FWinCon: TWinControl; FEnabled: Boolean);
var
  i : Integer;
begin
  i := 0;
  with FWinCon do
    while i < ControlCount do
    begin
      FWinCon.Controls[i].Enabled := FEnabled;
      Inc(i);
    end;
  FWinCon.Enabled := FEnabled;
end;

//----------------------------------------------------------------------------------------

procedure TfMain.SetParamsConn();
begin
  with ServerContainer1 do
  begin

    vSerHost_ := LSnapHostNew.Caption;
    vPort_  := StrToInt( ePort.Text );

    vSQLHost_  := eSQLHost.Text;
    vDB_    := eDB.Text;
    vLogin_ := eLogin.Text;
    vPass_  := ePass.Text;
    vOSAut_ := cbOSAut.Checked;
    vActiveCon_       := 0;
    vAllCon_          := 0;
    vSnapElapsedTime_ := 0;
    vSnapStartTime_   := Now();
    DSTCPServerTransport1.Port := vPort_;
  end;
end;

//----------------------------------------------------------------------------------------

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  ChangeVisual();
end;

//----------------------------------------------------------------------------------------
//честно не мое)) с просторов ...самому лень ковырять АПИ если уже есть )
//Правда паленая ...  чутка поправил
function GetMyHost (): String;
var
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  szHostName: PAnsiChar;
begin
  GetMem(szHostName, 128);
  if gethostname(szHostName, 128) = 0 then
    begin
      HostEnt:= gethostbyname(szHostName);
      if HostEnt = nil then
        Result:= ''
      else
        begin
          SockAddrIn.sin_addr.S_addr:= longint(plongint(HostEnt^.h_addr_list^)^);
          Result:= AnsiChar(inet_ntoa(SockAddrIn.sin_addr));
        end;
    end
  else
    Result := 'LocalHost';

  FreeMem(szHostName, 128);
end;

//----------------------------------------------------------------------------------------

end.

