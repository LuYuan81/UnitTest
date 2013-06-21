#-----------------------------------------------------------------------------
# defines / options
#-----------------------------------------------------------------------------
COMPILER_GCC      = 1
COMPILER_CW       = 0

## Directories
CW_PATH           = C:/Freescale/CodeWarrior
ANSIXB_LIBPATH    = $(CW_PATH)/lib/hc12c/lib/ansixb.lib
ANSIBF_LIBPATH    = $(CW_PATH)/lib/hc12c/lib/ansibf.lib
LIBPATH           = $(CW_PATH)/lib/hc12c/include

## file types
ASS = a
ALS = la
OBJ = o
LST = ls
LNK = inv
LIB = h12
EXE = hex
MAP = map
ERR = err
ABS = abs

## CodeWarrior Compiler / Assembler / Linker
ifeq ($(COMPILER_CW), 1)
CC              = $(CW_PATH)/Prog/chc12.exe  ## compile
ASS             = $(CW_PATH)/Prog/ahc12.exe   ## assemble
LD              = $(CW_PATH)/Prog/linker.exe    ## link


CFLAGS_COMMON= -WErrFileOff -WOutFileOff -EnvOBJPATH=$(OUTPUT_PATH)
CFLAGS= -CpuHCS12X -Mb -MapFLASH -D__MAP_FLASH__ -D__FAR_DATA -PSegObj $(CFLAGS_COMMON)

ASS_OPT         = $(ASS) +debug +nowiden -v -l -ax -co$(OUTPUT_PATH)
LD_FLAGS        = -M$(OUTPUT_PATH)/$(ECU).map
LD_FILES        = $(SW_SCRIPT_PATH)/Project.prm
endif

## GCC Compiler / Assembler / Linker
ifeq ($(COMPILER_GCC), 1)
GCOV            = -fprofile-arcs -ftest-coverage
CC              = gcc		 ## compile
ASS             = gcc -S       ## assemble
LD              = gcc        ## link

CFLAGS_COMMON= -O2 -g -Wall -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"
CFLAGS= -c $(CFLAGS_COMMON) #-o "$@" "$<"
	# -O2	-O2��ʾ�Ż�ѡ�2��ʾ�����Ż�
	# -g	����gdb������Ϣ
	# -c	ֻ���벻����
	# -fmessage-length=0	�����Ϣ����ݿ���̨�Ŀ���Զ����У��������ܿ�ȫ�����Ϣ�ˡ�
	# -M	�����ļ���������Ϣ������Ŀ���ļ�������������Դ����
	# -MM	��������Ǹ�һ������������������#include<file>��ɵ�������ϵ��
	# -MMD	��-MM��ͬ��������������뵽.d���ļ�����
	# -MF	��������ļ���
	# -MT	������������ļ��е�Ŀ��
	# -MP	
	# -o 	ָ������ļ���
	# �й���%.o:%.c����ô$@��ʾxxx.o�ļ�(xxx�����Դ�����ļ�������ǰ׺)��$<��ʾ�������ĵ�һ��ƥ����ļ������ڹ���%.o:%.c��$<��ʾ��һ���ҵ���.c�ļ���
endif