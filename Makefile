# dependent Makefile
DEPM = Makefile

# posix tools
SH    := bash
RM    := rm
GREP  := grep
MKDIR := mkdir

# posix development tools
MAKE  := make
STRIP := strip
NM    := nm

# compiler tool chain
CC   := gcc
CPP  := $(CC) -E
CXX  := g++
AS   := as
AR   := ar
LD   := ld
DUMP := objdump
GDB  := gdb

# compiler option
CFLAGS  = -g
CFLAGS += -O0
CFLAGS += -Wall
CFLAGS += -MMD
CFLAGS += -MP

# preprocessor definition
DEFINES  = -DDUMMY

# include path
INCLUDES  = -I./

# link library path
LIBS  = -LC:/MinGW/lib

# sourcecode file
SRCS  = main.c

# output directory
OBJDIR  = obj
DUMPDIR = reverse

# project name
PROJ = program

# output file
PROG  := $(PROJ).exe                                 # program file
MAP   := $(PROJ).map
HEAD  := $(DUMPDIR)/$(PROJ).header
DASM  := $(DUMPDIR)/$(PROJ).dasm
LDD   := $(DUMPDIR)/$(PROJ).ldd
NMF   := $(DUMPDIR)/$(PROJ).nm
OBJS  := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))    # object file
DEPS  := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))    # dependent file
PPS   := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.pp))   # preprocessed file
ASMS  := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.s))    # assembler file
DASMS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.dasm)) # disassembler file
NMS   := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.nm))   # nm file

# targets
.PHONY: clean version test
all: $(PROG)
dump: $(DASM) $(HEAD) $(NMF) $(LDD) $(DASMS) $(NMS)
assemble: $(ASMS)
preprocess: $(PPS)
-include $(DEP)
clean:
	$(RM) -f $(PROG) $(OBJS) $(DEPS) $(MAP) $(PPS) $(ASMS) $(HEAD) $(LDD) $(DASM) $(NMF) $(DASMS) $(NMS)
version:
	@$(SH) version.sh $(MAKE) $(CC) $(CXX) $(GDB) $(AS) $(AR) $(LD) $(DUMP) $(STRIP) $(NM) $(RM)
test:
	@$(PROG) test; echo returned : $$?

# from program file
$(DASM): $(PROG)
	@[ -d $(DUMPDIR) ] || $(MKDIR) $(DUMPDIR)
	$(DUMP) -d $^ > $@
$(HEAD): $(PROG)
	$(DUMP) -x $^ > $@
$(LDD): $(PROG)
	$(DUMP) -p $^ | $(GREP) 'DLL Name:' > $@
$(NMF): $(PROG)
	$(NM) -o -g $^ > $@

# from object file
$(PROG): $(OBJS)
	$(CC) $(CFLAGS) -Wl,-Map=$(MAP) $(LIBS) -o $@ $^
$(DASMS): $(OBJS)
	$(DUMP) -d $^ > $@
$(NMS): $(OBJS)
	$(NM) -o -g $^ > $@

# from sourcecode file
$(OBJS): $(SRCS) $(DEPM)
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< -o $@
$(ASMS): $(SRCS) $(DEPM)
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CC) -S $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< -o $@
$(PPS): $(SRCS) $(DEPM)
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CPP) $(DEFINES) $(INCLUDES) -c $< > $@
