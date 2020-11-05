unit ServerContainerUnit1;

interface

uses System.SysUtils, System.Contnrs, System.Classes, Datasnap.DSTCPServerTransport,
    Datasnap.DSServer,  Datasnap.DSCommonServer, Datasnap.DSAuth, IPPeerServer,
    Vcl.Dialogs, Vcl.ExtCtrls, uStats, data.dbxcommon;

type
  TServerContainer1 = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServer1Connect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    { Private declarations }
  public
    vListEvents: TEventList;
  //от лени выскивать часть данных
  //пусть у нас 1 настройки на все методыи тд
    vSerHost_ : String;
    vPort_    : Integer;

    vSQLHost_ : String;
    vServer_  : String;
    vDB_      : String;
    vLogin_   : String;
    vPass_    : String;
    vOSAut_   : Boolean;
    vAllCon_  : Integer;
    vActiveCon_       : Integer;
    vSnapStartTime_   : TDateTime;
    vSnapElapsedTime_ : LongInt;
  end;

var
  ServerContainer1: TServerContainer1;

implementation

{$R *.dfm}

uses Winapi.Windows, main, ServerMethodsUnit1;

//----------------------------------------------------------------------------------------

procedure TServerContainer1.DataModuleCreate(Sender: TObject);
begin
  vListEvents := TEventList.Create();
end;

//----------------------------------------------------------------------------------------

procedure TServerContainer1.DataModuleDestroy(Sender: TObject);
begin
  vListEvents.Destroy();
end;

//----------------------------------------------------------------------------------------

procedure TServerContainer1.DSServer1Connect( DSConnectEventObject: TDSConnectEventObject);
begin
  vActiveCon_ := vActiveCon_ + 1;
  vAllCon_    := vAllCon_ + 1;

  with DSConnectEventObject.ChannelInfo do
    vListEvents.AddConnect(True, DSConnectEventObject.Transport.Server.ClassName, Info, Id,
                            DSConnectEventObject.ConnectProperties['AppName'], ClientInfo.IpAddress,
                            ClientInfo.ClientPort, ClientInfo.Protocol)
end;

//----------------------------------------------------------------------------------------

procedure TServerContainer1.DSServer1Disconnect(DSConnectEventObject: TDSConnectEventObject);
begin
  vActiveCon_ := vActiveCon_ - 1;
  with DSConnectEventObject.ChannelInfo do
    vListEvents.AddConnect(False, DSConnectEventObject.ClassName, Info, Id,
                            DSConnectEventObject.ConnectProperties['AppName'], ClientInfo.IpAddress,
                            ClientInfo.ClientPort, ClientInfo.Protocol)
end;

//----------------------------------------------------------------------------------------

procedure TServerContainer1.DSServerClass1GetClass(
             DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

//----------------------------------------------------------------------------------------

end.

