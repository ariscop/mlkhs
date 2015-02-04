{
    MyLittleKaraoke high score submission
}
library mlkhs;

{$MODE Delphi}

uses UWebSDK
    ,sysutils
    ,classes
    ,fphttpclient
    ,fpjson
;

procedure WebsiteInfo (var Info: TWebsiteInfo); {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
begin
  Info.ID := 0; // seems to be ignored
  Info.Name := 'My Little Karaoke';
end;
exports WebsiteInfo;


function SendInfoToJson (SendInfo: TSendInfo): string;
begin
  with TJSONObject.Create() do begin
    Add('username', SendInfo.Username);
    Add('password', SendInfo.Password);
    Add('player', SendInfo.Name);
    Add('score', Inttostr(SendInfo.ScoreInt));
    Add('scoreline', Inttostr(SendInfo.ScoreLineInt));
    Add('scoregolden', Inttostr(SendInfo.ScoreGoldenInt));
    Add('song', SendInfo.MD5Song);
    Add('level', Inttostr(SendInfo.Level));
    Result := AsJSON;
    Free;
  end;
end;


function SendScore (SendInfo: TSendInfo): integer; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
var
  url: UTF8String;
begin
{
  Returns:
  0: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_NO_CONNECTION'));
  2: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_LOGIN_ERROR'));
  3: ScreenPopupInfo.ShowPopup(Language.Translate('WEBSITE_OK_SEND'));
  4: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SCORE'));
  5: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SCORE_DUPLICATED'));
  7: ScreenPopupError.ShowPopup(Language.Translate('WEBSITE_ERROR_SONG'));
}
  Result := 4; // WEBSITE_ERROR_SCORE

  url := 'http://sco.mylittlekaraoke.com/hs.php';
  With TFPHttpClient.Create(Nil) do try
      RequestBody := TStringStream.Create(SendInfoToJson(SendInfo));
      AddHeader('Content-Type','application/json');
      Result := StrToInt(Post(url));
      if ResponseStatusCode <> 200 then
        Result := 4;
      Free;
    except
      RequestBody.Free;
      Free;
    end;
end;
exports SendScore;


function EncryptScore (SendInfo: TSendInfo): widestring; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
begin
  Result := SendInfoToJson(SendInfo);
end;
exports EncryptScore;


function Login (LoginInfo: TLoginInfo): byte; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
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


function EncryptPassword (LoginInfo: TLoginInfo): widestring; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
begin
  Result := widestring(LoginInfo.Password);
end;
exports EncryptPassword;


function DownloadScore (ListMD5Song: widestring; Level: byte): widestring; {$IFDEF MSWINDOWS} stdcall; {$ELSE} cdecl; {$ENDIF}
var
  url: string;
begin
  {
  * 0768006477Elena_PM
  * Jan 07 22:57:22 <Phase4>        so 07680 06477 Elena_PM
  * Jan 07 22:57:48 <Phase4>        top, average, user
  }
  url := 'http://sco.mylittlekaraoke.com/hs.php';
  With TFPHttpClient.Create(Nil) do try
      AppendStr(url, '?level=');
      AppendStr(url, Inttostr(Level));
      AddHeader('Content-Type','text/plain');
      RequestBody := TStringStream.Create(ListMD5Song);
      Result := widestring(Post(url));
      if ResponseStatusCode <> 200 then
        Result := widestring('0');
      Free;
    except
      Result := widestring('0');
      Free;
    end;
end;
exports DownloadScore;

end.
