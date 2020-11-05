{ Набросок....возможно пригодиться раличные параметры хранить}
unit uStats;

interface

uses System.SysUtils, System.Contnrs, System.Classes;

type TEvent_Det = class(TObject)
  protected
    FDateTime : TDateTime;
    FType     : Integer;
    FIntData  : array [0..7] of Integer;
    FDData    : array [0..7] of Double;
    FStrData  : array [0..7] of String;
  public
    constructor Create(DateTime: TDateTime); overload;
  end;

  TEventList = class(TObject)
  protected
    FList: TObjectList;
    procedure AddGap(List: TStrings; TypeGap:integer = 1);
    procedure GetConnect(ID: integer; List: TStrings);
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Clear();
    procedure GetStrings(List: Tstrings);
    function AddConnect(Active: Boolean; SerClassName: String;  ChanInfo: String;  ChanId: Integer;
                        ClAppName: String;  CLIpAddress: String;  CLClientPort: String;
                        CLProtocol: String):Integer;
  end;

implementation

{ TEvent_Det }

//----------------------------------------------------------------------------------------

constructor TEvent_Det.Create(DateTime: TDateTime);
begin
  inherited Create();
  FDateTime := Now();
end;

{ TeventList }

//----------------------------------------------------------------------------------------

function TEventList.AddConnect(Active: Boolean; SerClassName, ChanInfo: String; ChanId: Integer;
      ClAppName, CLIpAddress, CLClientPort, CLProtocol: String): Integer;
var
  buf: TEvent_Det;
begin
  buf := TEvent_Det.Create( Now() );
  with buf do
  begin
    if Active then
      buf.FType := 1 //приконектили
    else buf.FType := 2; //разорвали
    FStrData[0] := SerClassName;
    FStrData[1] := ChanInfo;
    FIntData[0] := ChanId;
    FStrData[2] := ClAppName;
    FStrData[3] := CLIpAddress;
    FStrData[4] := CLClientPort;
    FStrData[5] := CLProtocol;
  end;
  Self.FList.Add(buf);
  Result := 1;
end;

//----------------------------------------------------------------------------------------

procedure TEventList.AddGap(List: TStrings; TypeGap:integer = 1);
begin
  if TypeGap <> 1 then
    List.Add('');
  List.Add('---------------------------------------------------------------------');
  if TypeGap <> 1 then
    List.Add('');
end;

//----------------------------------------------------------------------------------------

procedure TeventList.Clear;
begin
  Self.FList.Clear();
end;

constructor TeventList.Create;
begin
  Self.FList := TObjectList.Create();
  Self.FList.OwnsObjects := True;
end;

//----------------------------------------------------------------------------------------

destructor TeventList.Destroy;
begin
  Self.FList.Destroy();
end;

//----------------------------------------------------------------------------------------

procedure TEventList.GetConnect(ID: integer; List: TStrings);
var
  S: String;
begin
  AddGap(List);
  with TEvent_Det(FList.Items[ID]) do
  begin
    if FType = 1 Then S := ' Коннект '
    else S := ' Дисконект  ';
    S := S + '         Дата:  ' + DateTimeToStr( FDateTime );
    List.add(S);
    S :='      Класс сервера: ' + FStrData[0] +
        '      ID канала: ' + IntToStr(FIntData[0]) +
        '      Info канала: "' + FStrData[1] + '"';
    List.add(S);
    S :='      Приложение: ' + FStrData[2];
    List.add(S);
    S :='      IP клиента: ' + FStrData[3] +
        '      Port клиента: ' + FStrData[4] +
        '      Протокол : ' + FStrData[5];
    List.add(S);
  end;
end;

//----------------------------------------------------------------------------------------

procedure TEventList.GetStrings(List: Tstrings);
var
  i: Integer;
begin
  i := 0;
  while i < FList.Count do
  begin
    case TEvent_Det(FList.Items[i]).FType of
      1 , 2: GetConnect(i, List);
      else List.Add('Ошибка данных');
    end;
    Inc( i );
  end;
end;

//----------------------------------------------------------------------------------------

end.




