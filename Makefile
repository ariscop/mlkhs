all: test.exe

FLAGS=-viwnh

FPC=wine C:\\FPC\\3.0.2\\bin\\i386-win32\\fpc.exe

mlkhs.dll: UWebSDK.pas mlkhs.pas
	$(FPC) $(FLAGS) mlkhs.pas

test.exe: mlkhs.dll test.pas
	$(FPC) $(FLAGS) test.pas

clean:
	rm -f *.o *.dll *.exe *.ppu
