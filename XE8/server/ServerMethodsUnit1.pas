unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json, Datasnap.DSServer,
     Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter, Datasnap.Provider,
     Data.DB, Data.DBXMSSQL, Data.FMTBcd, Data.SqlExpr,
     ServerContainerUnit1;



procedure SetConParam(Con: TSQLConnection);
//Тест параметров базы на вшивость
function TestConParam ():Boolean;


type
  TServerMethods1 = class(TDSServerModule)
    MssqlCon: TSQLConnection;
    dsTest_tab: TSQLDataSet;
    procedure MssqlConBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  protected
    //procedure SetConParam_ (Con: TSQLConnection);
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
//Установка параметров базы
    procedure SetMainParam ();
//получить данны по заданию
    function ClientGetSQLRes(sql_like :String): TDataSet;
  end;

implementation

{$R *.dfm}

uses System.StrUtils, vcl.dialogs;

//----------------------------------------------------------------------------------------

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

//----------------------------------------------------------------------------------------
//параметры коннека воткнем сюда
procedure TServerMethods1.MssqlConBeforeConnect(Sender: TObject);
begin
  SetMainParam();
end;

//----------------------------------------------------------------------------------------

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

//----------------------------------------------------------------------------------------

procedure TServerMethods1.SetMainParam;
begin
  SetConParam(Self.MssqlCon);
end;

//----------------------------------------------------------------------------------------

procedure SetConParam(Con: TSQLConnection);
begin
  //Con.st
  Con.DriverName:='MSSQL';
  with Con.Params do
   begin
      Clear();
      Append('SchemaOverride=sa.dbo');
      Append('DriverName=MSSQL');
      Append('HostName='  + trim( ServerContainer1.vSQLHost_ ) );
      Append('Database='  + trim( ServerContainer1.vDB_ ) );
      Append('User_Name=' + trim( ServerContainer1.vLogin_ ) );
      Append('Password='  + trim( ServerContainer1.vPass_ ) );
      Append('BlobSize=-1');
      Append('ErrorResourceFile=');
      Append('LocaleCode=0000');
      Append('IsolationLevel=ReadCommitted');
      if ServerContainer1.vOSAut_ then
        Append('OS Authentication=True')
      else
        Append('OS Authentication=False');
      Append('Prepare SQL=False');
      Append('ConnectTimeout=60');
      Append('Mars_Connection=False');
    end;
end;

//----------------------------------------------------------------------------------------

function TestConParam: Boolean;
var
  _Con: TSQLConnection;
begin
  Result := True;
  _Con := TSQLConnection.Create(nil);
  try
    SetConParam(_Con);
    _Con.Open();
  except on Exception do
    Result := False;
  end;
  _Con.Destroy();
end;

//----------------------------------------------------------------------------------------

//собсно вот и вся забота о том чтоб получить данны по заданию )
function TServerMethods1.ClientGetSQLRes(sql_like :String): TDataSet;
begin
  with dsTest_tab do
  begin
     Close;
     CommandText := 'SELECT * FROM [DB].[Test_Tab] ORDER BY [ID_]';// like% ''%'
            //       + sql_like + '%'' Order by [ID]';
     Open;
  end;
  Result := dsTest_tab;
end;

//----------------------------------------------------------------------------------------

end.

