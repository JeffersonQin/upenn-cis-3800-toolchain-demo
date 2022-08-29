# Define variable CC to be the compilier we want to use
CC = clang 
# Ditto for the flags we will want to use everywhere
CFLAGS  = -g -Wall
# If no arguments are passed to make, it will attempt the 'samp' target
default: samp

# This will construct the binary 'samp' using the dependancy 'sample.o'
# $^ = names of all dependant files, deduped and with spaces
# $@ = complete name of the target 
samp: sample.o
	$(CC) $(CFLAGS) $^ -o $@

# Note: the following section does not necessarily have to exist
# and that's why they are commented out.
# they are automatically applied
# 
# This will construct arbitrary *.o targets given the matching *.c and *.h files.
# $< = name of first dependant file (here that is <something>.c)
# % = The % will match any string in the target and then use that string to fill in the dependant files
# %.o : %.c %.h
	# $(CC) $(CFLAGS) -o $@ -c $<

# However, by default make will do this if it doesn't have a receipe for .c files via implicit rules
# https://www.gnu.org/software/make/manual/make.html#Implicit-Rules<Paste>

# $(RM) is the platform agnostic way to delete a file (here rm -f)
clean: 
	$(RM) samp samp_san *.o 


## Sanatizers
S_FLAGS = -O1 -fsanitize=address -fno-omit-frame-pointer

samp_san: sample.o
	$(CC) $(CFLAGS) $(S_FLAGS) $^ -o $@
