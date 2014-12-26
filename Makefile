all: libmlkhs.so test

libmlkhs.so: UWebSDK.pas mlkhs.pas
	fpc -g mlkhs.pas

test: libmlkhs.so test.pas
	fpc -g test.pas
