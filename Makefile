all: test.exe

FLAGS=-g -veiwnh

mlkhs.dll: UWebSDK.pas mlkhs.pas
	wine fpc -CD $(FLAGS) mlkhs.pas

test.exe: mlkhs.dll test.pas
	wine fpc $(FLAGS) test.pas

clean:
	rm -f *.o *.dll *.exe *.ppu
