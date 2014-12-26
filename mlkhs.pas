{
    MyLittleKaraoke high score submission
}
library mlkhs;

{$MODE Delphi}

uses UWebSDK
    ,sysutils
    ,fphttpclient
;

procedure WebsiteInfo (var Info: TWebsiteInfo);
begin
  Info.ID := 0; // seems to be ignored
  Info.Name := 'My Little Karaoke';
end;
exports WebsiteInfo;

function SendScore (SendInfo: TSendInfo): integer;
var
  url: UTF8String;
  res: UTF8String;
begin
{
      Username:   UTF8String;   // Username
      Password:   UTF8String;   // Password
      Name:       UTF8String;   // Name of the player
      ScoreInt:       integer;  // Player's Score Int
      ScoreLineInt:   integer;  // Player's Score Line
      ScoreGoldenInt: integer;  // Player's Score Golden
      MD5Song:        string;   // Song Hash
      Level:      byte;         // Level (0- Easy, 1- Medium, 2- Hard)

  Returns:
  0: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_NO_CONNECTION'));
  2: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_LOGIN_ERROR'));
  3: ScreenPopupInfo.ShowPopup(Language.Translate('WEBSITE_OK_SEND'));
  4: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SCORE'));
  5: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SCORE_DUPLICATED'));
  7: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SONG'));
}
  url := 'http://www.mylittlekaraoke.com/scores.php';
  AppendStr(url, '?username=');
  AppendStr(url, SendInfo.Username);
  AppendStr(url, '&password=');
  AppendStr(url, SendInfo.Password);
  AppendStr(url, '&player=');
  AppendStr(url, SendInfo.Name);
  AppendStr(url, '&song=');
  AppendStr(url, SendInfo.MD5Song);

  AppendStr(url, '&score=');
  AppendStr(url, Inttostr(SendInfo.ScoreInt));
  AppendStr(url, '&scoreline=');
  AppendStr(url, Inttostr(SendInfo.ScoreLineInt));
  AppendStr(url, '&scoregolden=');
  AppendStr(url, Inttostr(SendInfo.ScoreGoldenInt));
  AppendStr(url, '&level=');
  AppendStr(url, Inttostr(SendInfo.Level));

  writeln(url);

  With TFPHttpClient.Create(Nil) do
    try
      res := Get(url);
    finally
      Free;
    end;

  writeln(res);
  Result := 3;
end;
exports SendScore;

function EncryptScore (SendInfo: TSendInfo): widestring;
var
  ret: UTF8String;
begin
  ret := '';
  AppendStr(ret, '&score=');
  AppendStr(ret, Inttostr(SendInfo.ScoreInt));
  AppendStr(ret, '&scoreline=');
  AppendStr(ret, Inttostr(SendInfo.ScoreLineInt));
  AppendStr(ret, '&scoregolden=');
  AppendStr(ret, Inttostr(SendInfo.ScoreGoldenInt));
  AppendStr(ret, '&level=');
  AppendStr(ret, Inttostr(SendInfo.Level));
  Result := widestring(ret);
end;
exports EncryptScore;

function Login (LoginInfo: TLoginInfo): byte;
begin
  {
    *****************************
    ** 100: NOT A VALID DLL :p
    ** 0: ERROR_CONNECT
    ** 1: OK_LOGIN
    ** 2: ERROR_LOGIN
    *****************************
  }
  Result := 1;
end;
exports Login;

function EncryptPassword (LoginInfo: TLoginInfo): widestring;
begin
  Result := widestring(LoginInfo.Password);
end;
exports EncryptPassword;

function DownloadScore (ListMD5Song: widestring; Level: byte): widestring;
begin
  Result := widestring('');
end;
exports DownloadScore;

end.
