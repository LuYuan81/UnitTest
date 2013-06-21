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
	# -O2	-O2表示优化选项，2表示最优优化
	# -g	加入gdb编译信息
	# -c	只编译不链接
	# -fmessage-length=0	输出信息会根据控制台的宽度自动换行，这样就能看全输出信息了。
	# -M	生成文件关联的信息。包含目标文件所依赖的所有源代码
	# -MM	和上面的那个一样，但是它将忽略由#include<file>造成的依赖关系。
	# -MMD	和-MM相同，但是输出将导入到.d的文件里面
	# -MF	输出依赖文件名
	# -MT	在输出的依赖文件中的目标
	# -MP	
	# -o 	指定输出文件名
	# 有规则%.o:%.c，那么$@表示xxx.o文件(xxx是你的源代码文件的名称前缀)；$<表示搜索到的第一个匹配的文件，对于规则%.o:%.c，$<表示第一个找到的.c文件。
endif