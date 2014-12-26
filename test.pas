program test;

{$MODE Delphi}

uses UWebSDK
    ,dynlibs
;

var
    ret:       integer;
    testinfo:  TSendInfo;
    hLibW:     TLibHandle;
    SendScore:       fModi_SendScore;
    EncryptScore:    fModi_EncryptScore;
    Login:           fModi_Login;
    EncryptPassword: fModi_EncryptPassword;
    DownloadScore:   fModi_DownloadScore;
begin
    testinfo.Username := 'ariscop';
    testinfo.Password := 'SuprSecrt';
    testinfo.Name := 'Phase4';
    testinfo.ScoreInt := 1337;
    testinfo.ScoreLineInt := 7331;
    testinfo.ScoreGoldenInt := 3173;
    testinfo.MD5Song := 'thisisahash';
    testinfo.Level := 2;

    hLibW := LoadLibrary('./mlkhs.dll');
    @Login := GetProcAddress (hLibW, 'Login');
    @SendScore := GetProcAddress (hLibW, 'SendScore');
    @EncryptScore := GetProcAddress (hLibW, 'EncryptScore');
    @EncryptPassword := GetProcAddress (hLibW, 'EncryptPassword');
    @DownloadScore := GetProcAddress (hLibW, 'DownloadScore');
    ret := SendScore(testinfo);
    writeln('got ret');
end.
