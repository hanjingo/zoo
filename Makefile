VERSION = 0.0.1

BIN ?= $(shell pwd)/bin# binary path: 
LUA_LIB_PATH ?= ${BIN}/lualib

export SKYNET_BUILD_PATH = ${BIN}
export LUA_CLIB_PATH = ${BIN}/luaclib
export CSERVICE_PATH = ${BIN}/cservice

.PHONY: all linux macosx_arm64 clean

all: linux macosx_arm64

linux: env
	cd 3rd/skynet && make linux

	cd 3rd/pbc && make
	cd 3rd/pbc/binding/lua53 && make

	cd 3rd/lua-cmsgpack && mkdir -p build && cd build && cmake ..
	cd 3rd/lua-cmsgpack/build && make

	cp 3rd/pbc/binding/lua53/protobuf.so $(LUA_CLIB_PATH)
	cp 3rd/lua-cmsgpack/build/cmsgpack.so $(LUA_CLIB_PATH)

macosx_arm64: env
	JEMALLOC_STATICLIB = 3rd/jemalloc/autogen.sh; export JEMALLOC_STATICLIB;
	export CC;
	cd 3rd/skynet && make macosx

	cd 3rd/pbc && make
	cd 3rd/pbc/binding/lua53 && chmod +x build_ios.sh && ./build_ios.sh

	cd 3rd/lua-cmsgpack && mkdir -p build && cd build && cmake ..
	cd 3rd/lua-cmsgpack/build && make

	cp 3rd/pbc/binding/lua53/libprotobuf-arm64.a $(LUA_CLIB_PATH)
	cp 3rd/lua-cmsgpack/build/cmsgpack.so $(LUA_CLIB_PATH)
	cp 3rd/pbc/binding/lua53/protobuf.lua ${LUA_LIB_PATH}

clean:
	rm -rf $(BIN)
	cd 3rd/skynet && make clean
	cd 3rd/pbc && make clean
	cd 3rd/pbc/binding/lua53 && make clean
	cd 3rd/pbc/binding/lua53 && rm libprotobuf*

env:
	git submodule update --init

	mkdir -p ${BIN}
	mkdir -p ${LUA_LIB_PATH}
	mkdir -p $(LUA_CLIB_PATH)
	mkdir -p $(CSERVICE_PATH)

	cp -r 3rd/skynet/lualib/* ${LUA_LIB_PATH}
	cp -r 3rd/skynet/service ${LUA_LIB_PATH}
	cp 3rd/pbc/binding/lua53/protobuf.lua ${LUA_LIB_PATH}

test: macosx_arm64
	mkdir -p ${BIN}/logic
	cp config.tmpl ${BIN}/config
	cp main.tmpl ${BIN}/logic/main.lua