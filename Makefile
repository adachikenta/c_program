# basic tools
SH := bash
MAKE := make
RM := rm
GREP := grep
MKDIR := mkdir

# compiler tool chain
CC := gcc
DUMP := objdump
NM := nm
GDB := gdb

# compiler option
FLAGS := -g
FLAGS += -O0
FLAGS += -Wall
FLAGS += -MMD
FLAGS += -MP

# include path
INCLUDES := -I./

# preprocessor definition
DEFINES := -DDUMMY

# link library
LIBRARYS := -LC:/MinGW/lib

# sourcecode file
SRCS := main.c

# output directory
OBJDIR := obj
DUMPDIR := reverse

# project name
PROJ := program

# program file
PROG := $(PROJ).exe

# map file
MAP := $(PROJ).map
HEAD := $(DUMPDIR)/$(PROJ).header
DASM := $(DUMPDIR)/$(PROJ).dasm
LDDF := $(DUMPDIR)/$(PROJ).ldd
NMF := $(DUMPDIR)/$(PROJ).nm

# object file
OBJS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.o))

# preprocessed file
PRES := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.prepro))

# assembler file
ASMS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.s))
DASMS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.dasm))

# nm file
NMS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.nm))

# dependent file
DEPS := $(addprefix $(OBJDIR)/, $(SRCS:%.c=%.d))
DEPM := Makefile

# rules
all: $(PROG)
dump: $(DASM) $(HEAD) $(NMF) $(LDDF) $(DASMS) $(NMS)
assemble: $(ASMS)
preprocess: $(PRES)

-include $(DEPS)

# from program file
$(DASM): $(PROG)
	@[ -d $(DUMPDIR) ] || $(MKDIR) $(DUMPDIR)
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
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CC) $(FLAGS) $(DEFINES) $(INCLUDES) -c $< -o $@

$(ASMS): $(SRCS) $(DEPM)
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CC) -S $(FLAGS) $(DEFINES) $(INCLUDES) -c $< -o $@

$(PRES): $(SRCS) $(DEPM)
	@[ -d $(OBJDIR) ] || $(MKDIR) $(OBJDIR)
	$(CC) -E $(DEFINES) $(INCLUDES) -c $< > $@

# clean
clean:
	$(RM) -f $(PROG) $(OBJS) $(DEPS) $(MAP) $(PRES) $(ASMS) $(HEAD) $(LDDF) $(DASM) $(NMF) $(DASMS) $(NMS)

# version
version:
	@$(SH) -c "version.sh $(MAKE) $(CC) $(GDB) $(DUMP) $(NM) $(RM)"
