# Define variable CC to be the compilier we want to use
CC = clang 
# Ditto for the flags we will want to use everywhere
CFLAGS  = -g -Wall
default: samp

# $^ = names of all dependant files, deduped and with spaces
# $@ = complete name of the target 
samp: sample.o 
	$(CC) $(CFLAGS) $^ -o $@
# $< = name of first dependant file (here that is <something>.c)
%.o : %.c %.h 
	$(CC) $(CFLAGS) -o $@ -c $<

# $(RM) is the platform agnostic way to delete a file (here rm -f)
clean: 
	$(RM) samp *.o 


## Sanatizers
S_FLAGS = -O1 -fsanitize=address -fno-omit-frame-pointer

samp_san: sample.o
	$(CC) $(CFLAGS) $(S_FLAGS) $^ -o $@
