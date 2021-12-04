VERSION = 0.0.1

BIN ?= $(shell pwd)/bin
NAME ?= $(shell pwd)/proj/hello

export ZOO_BIN_PATH = ${BIN}
export SKYNET_BUILD_PATH = $(ZOO_BIN_PATH)
export LUA_CLIB_PATH = $(ZOO_BIN_PATH)/luaclib
export CSERVICE_PATH = $(ZOO_BIN_PATH)/cserviceexport

.PHONY: all linux macosx_arm64 clean init make_linux make_macosx_arm64 
		copy copy_linux copy_macosx_arm64 lulib proto

all: linux macosx_arm64

linux: init make_linux lulib proto

macosx_arm64: init make_macosx_arm64 lulib proto

clean:
	rm -rf $(ZOO_BIN_PATH)
	cd 3rd && ${MAKE} clean
	cd lualib && ${MAKE} clean
	cd protocol && ${MAKE} clean

make_linux:
	cd 3rd && ${MAKE} linux
	cp 3rd/lua-cmsgpack/build/cmsgpack.so $(LUA_CLIB_PATH)
	cp 3rd/pbc/binding/lua53/protobuf.so $(LUA_CLIB_PATH)
	
make_macosx_arm64:
	cd 3rd && ${MAKE} macosx_arm64 
	cp 3rd/pbc/binding/lua53/libprotobuf-arm64.a $(LUA_CLIB_PATH)
	cp 3rd/lua-cmsgpack/build/cmsgpack.so $(LUA_CLIB_PATH)

init:
	git submodule update --init
	mkdir -p $(ZOO_BIN_PATH)

lulib:
	cd lualib && ${MAKE} all

proto:
	cd protocol && ${MAKE} all

proj:
	mkdir -p ${NAME}