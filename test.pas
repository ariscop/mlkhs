program test;

{$MODE Delphi}

uses UWebSDK
    ,dynlibs
    ,sysutils
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
    writeln(Inttostr(ret));

//    writeln(DownloadScore('baea337e82b5fcb502864652445d3683', 1));
//    writeln(DownloadScore('eb3ede10c92d6de8ad1e3080beeed5a9eb3ede10c92d6de8ad1e3080beeed5a97aac491412f0771475dbc600ac1d5a227aac491412f0771475dbc600ac1d5a222f76d9ba1bd52399836e386aae374bb3c72fe3dad6fdda51b522fce27504e1a81c64b21f60e77d48e0d4739a28cccb351c64b21f60e77d48e0d4739a28cccb35e0c947afbb5c616d36022fe0aec2c21570bd7c69dd62e78b39fe01235f154c6a70bd7c69dd62e78b39fe01235f154c6a852f680c94c538532da9dcf9fd66cc2b852f680c94c538532da9dcf9fd66cc2b65d4bdbd008f477977e71fe9f445798a7eb859640ff8e1fb233835ddfefba25c0c4306af854f699d4dbef3d2129fc47abc54f732f106f1fef8c46a45619b94fdf03cb5798c0650535a1943a564c838c3', 2));
end.
