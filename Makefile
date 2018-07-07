# project name
PROJ := program_name

# program file
PROG := $(PROJ).exe

# map file
MAP := $(PROJ).map
HEAD := $(PROJ).header
DASM := $(PROJ).dasm
LDDF := $(PROJ).ldd
NMF := $(PROJ).nm

# sourcecode file
SRCS := main.c

# object file
OBJS := $(SRCS:%.c=%.o)

# preprocessed file
PRES := $(SRCS:%.c=%.prepro)

# assembler file
ASMS := $(SRCS:%.c=%.s)
DASMS := $(SRCS:%.c=%.dasm)

# nm file
NMS := $(SRCS:%.c=%.nm)

# dependent file
DEPS := $(SRCS:%.c=%.d)
DEPM := Makefile

# compiler tool chain
CC := gcc
DUMP := objdump
NM := nm

# other tools
RM := rm
GREP := grep

# compiler option
FLAGS := -g
FLAGS += -O0
FLAGS += -Wall

# include path
INCLUDES := -I./

# compile option
DEFINES := -DDUMMY

# link library
LIBRARYS := -LC:/MinGW/lib

# rules
all: $(PROG)
dump: $(DASM) $(HEAD) $(NMF) $(LDDF) $(DASMS) $(NMS)
assemble: $(ASMS)
preprocess: $(PRES)

-include $(DEPS)

# from program file
$(DASM): $(PROG)
	$(DUMP) -d $^ > $@

$(HEAD): $(PROG)
	$(DUMP) -x $^ > $@

$(LDDF): $(PROG)
	$(DUMP) -p $^ | $(GREP) 'DLL Name:' > $@

$(NMF): $(PROG)
	$(NM) -o -g $^ > $@

# from object file
$(PROG): $(OBJS)
	$(CC) $(FLAGS) -Wl,-Map=$(MAP) $(LIBRARYS) -o $@ $^

$(DASMS): $(OBJS)
	$(DUMP) -d $^ > $@

$(NMS): $(OBJS)
	$(NM) -o -g $^ > $@

# from sourcecode file
$(OBJS): $(SRCS) $(DEPM)
	$(CC) $(FLAGS) $(DEFINES) $(INCLUDES) -c -MMD -MP $<

$(ASMS): $(SRCS) $(DEPM)
	$(CC) -S $(FLAGS) $(DEFINES) $(INCLUDES) -c -MMD -MP $<

$(PRES): $(SRCS) $(DEPM)
	$(CC) -E $(FLAGS) $(DEFINES) $(INCLUDES) -c -MMD -MP $< > $@

# clean
clean:
	$(RM) -f $(PROG) $(OBJS) $(DEPS) $(MAP) $(PRES) $(ASMS) $(HEAD) $(LDDF) $(DASM) $(NMF) $(DASMS) $(NMS)

version:
	@bash -c "version.sh make $(CC) $(DUMP) $(NM)"
