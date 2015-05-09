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
	rm $(OBJECTS) keychaindump

tidy :
	rm $(OBJECTS)