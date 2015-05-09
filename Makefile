CC=gcc
CFLAGS=-Wno-deprecated
LDFLAGS=-lcurl -lcrypto

OBJECTS=keychaindump.o
SOURCE=keychaindump.c

display : keychaindump
	xcodebuild

keychaindump : keychaindump.o
	$(CC) $(CFLAGS) $(OBJECTS) -o display/dumperx.tmp $(LDFLAGS)

.PHONY : clean tidy
clean :
	rm -r $(OBJECTS) keychaindump build/Release/*

tidy :
	rm $(OBJECTS)
