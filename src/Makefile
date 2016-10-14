PROJECT = VSMLua
VERSION = 115

MAKE= make
CC:= gcc
AR:= ar
OBJCOPY:= objcopy
STRIP:= strip
WINRES:= windres

LIBDIR=../dll

MOD=modules
DEV=device
XXD=../tools/bin2source.exe
LUAC=../tools/luac.exe
OPENVSMLIB?=$(LIBDIR)/$(PROJECT)

SRC:=vsmapi.c \
lua_pin.c \
lua_bus.c \
lua_vsmobj.c \
utils.c \
wincompat.c \
bindings/cbind.c \
bindings/luabind.c

MODULES=\
$(MOD)/module_bus.lua \
$(MOD)/module_custom.lua \
$(MOD)/module_events.lua \
$(MOD)/module_pin.lua

DEVICE=\
$(DEV)/device.lua

CFLAGS:=-O2 -gdwarf-2 -std=gnu99 -g3 \
-Wno-unused-variable -I../include -Imodules \
-I../lua -D__MINGW32__ -D__VERSION=\"$(VERSION)\"

SLIB_CFLAGS:=-Wl,--export-all-symbols,--enable-auto-import

LDFLAGS:=../lua/liblua.a -lm

OBJ=$(SRC:%.c=%.o) \
$(MOD)/module_bus.c.o $(MOD)/module_custom.c.o \
$(MOD)/module_events.c.o $(MOD)/module_pin.c.o \
$(DEV)/device.c.o

LOBJ:=$(MODULES:%.lua=%.mod)
LOBJ+=$(DEVICE:%.lua=%.mod)

all: modules $(OPENVSMLIB).dll

%.mod: %.lua
	$(LUAC) -s -o $@ $<
	$(XXD) $@ > $@.c

$(DEV)/device.c.o:
	$(CC) -c -o $@ $(DEV)/device.mod.c $(CFLAGS)

$(MOD)/module_bus.c.o:
	$(CC) -c -o $@ $(MOD)/module_bus.mod.c $(CFLAGS)

$(MOD)/module_custom.c.o:
	$(CC) -c -o $@ $(MOD)/module_custom.mod.c $(CFLAGS)

$(MOD)/module_pin.c.o:
	$(CC) -c -o $@ $(MOD)/module_pin.mod.c $(CFLAGS)

$(MOD)/module_events.c.o:
	$(CC) -c -o $@ $(MOD)/module_events.mod.c $(CFLAGS)

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

$(OPENVSMLIB).dll: $(OBJ)
	$(CC) -shared -o $@ $^ $(LDFLAGS) $(SLIB_CFLAGS)
	$(OBJCOPY) --only-keep-debug $(OPENVSMLIB).dll $(OPENVSMLIB).dwarf
	$(STRIP) -s $(OPENVSMLIB).dll
	$(OBJCOPY) --add-gnu-debuglink=$(OPENVSMLIB).dwarf $(OPENVSMLIB).dll

modules: $(LOBJ)
	@echo "Lua modules compiled"

SUBDIRS:=bindings modules device

clean:	
	rm -f $(OPENVSMLIB).*	
	for dir in $(SUBDIRS); do \
		rm -f $$dir/*.o; \
		rm -f $$dir/*.mod; \
		rm -f $$dir/*.mod.c; \
	done
	rm -f *.o
	rm -f *.res
