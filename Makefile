# posix development tools
MAKE  :=make
STRIP :=strip
NM    :=nm
# compiler tool chain
CC    :=gcc
CPP   :=$(CC) -E
CXX   :=g++
AS    :=as
AR    :=ar
LD    :=ld
DUMP  :=objdump
GDB   :=gdb
TOOLS :=$(MAKE) $(STRIP) $(NM) $(CC) $(CXX) $(AS) $(AR) $(LD) $(DUMP) $(GDB)

# compiler option
CFLAGS  =-g
CFLAGS += -O0
CFLAGS += -Wall
CFLAGS += -MMD
CFLAGS += -MP
# preprocessor definition
DEFINES  =-DDUMMY
# include path
INCLUDES  =-I./
# link library path
LIBS  =-LC:/MinGW/lib
# source code file
SRCS  =main.c

# output directory
OBJDIR  =obj
DUMPDIR =reverse
# output file
PROG    :=program.exe#                                      : program file
MAP     :=$(PROG:%.exe=%.map)#                              : map file
HEAD    :=$(addprefix $(DUMPDIR)/, $(PROG:%.exe=%.header))# : header file
DASM    :=$(addprefix $(DUMPDIR)/, $(PROG:%.exe=%.dasm))#   : disassembler file
LDD     :=$(addprefix $(DUMPDIR)/, $(PROG:%.exe=%.ldd))#    : use dll list
NMF     :=$(addprefix $(DUMPDIR)/, $(PROG:%.exe=%.nm))#     : nm file
OBJS    :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.o))#        : object file
DEPS    :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.d))#        : dependent file
PPS     :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.pp))#       : preprocessed file
ASMS    :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.s))#        : assembler file
DASMS   :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.dasm))#     : disassembler file
NMS     :=$(addprefix $(OBJDIR)/,  $(SRCS:%.c=%.nm))#       : nm file
OUTPUTS :=$(PROG) $(OBJS) $(DEPS) $(MAP) $(PPS) $(ASMS) $(HEAD) $(LDD) $(DASM) $(NMF) $(DASMS) $(NMS)

# common rule
define common-rule
    @echo ------------------------------------------------------------------
	@echo creating $@ "<-------" depends on $?
	@[ -d $(dir $@) ] || mkdir $(dir $@)
endef

# targets
.PHONY: clean version test
all: $(PROG)
dump: $(DASMS) $(NMS) $(DASM) $(NMF) $(HEAD) $(LDD)
assemble: $(ASMS)
preprocess: $(PPS)
#-include $(DEP)
clean:
	@echo cleaning output file...; echo $(OUTPUTS) | sed -e 's/ /\n/g' | sort | sed -e 's/^/\t/'; rm -f $(OUTPUTS)
version:
	@echo checking version...; bash version.sh $(TOOLS)
test:
	@$(PROG) test a b c; echo returned : $$?

# depend program file
$(DASM): $(PROG)
	$(common-rule)
	$(DUMP) -d $^ > $@
$(NMF): $(PROG)
	$(common-rule)
	$(NM) -o -g $^ > $@
$(HEAD): $(PROG)
	$(common-rule)
	$(DUMP) -x $^ > $@
$(LDD): $(PROG)
	$(common-rule)
	$(DUMP) -p $^ | grep 'DLL Name:' > $@

# depend object file
$(PROG): $(OBJS)
	$(common-rule)
	$(CC) $(CFLAGS) -Wl,-Map=$(MAP) $(LIBS) $^ $(OUTPUT_OPTION)
$(DASMS): $(OBJS)
	$(common-rule)
	$(DUMP) -d $^ > $@
$(NMS): $(OBJS)
	$(common-rule)
	$(NM) -o -g $^ > $@

# depend source code file
$(OBJS): $(SRCS) $(DEPS) $(MAKEFILE_LIST)
	$(common-rule)
	$(CC) $(CFLAGS) $(DEFINES) $(INCLUDES) $(OUTPUT_OPTION) -c $< 
$(ASMS): $(SRCS) $(MAKEFILE_LIST)
	$(common-rule)
	$(CC) -S $(CFLAGS) $(DEFINES) $(INCLUDES) -c $< $(OUTPUT_OPTION)
$(PPS): $(SRCS) $(DMAKEFILE_LISTEPM)
	$(common-rule)
	$(CPP) $(DEFINES) $(INCLUDES) -c $< > $@
