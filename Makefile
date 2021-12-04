VERSION = 0.0.1

ZOO_BIN_PATH ?= $(shell pwd)/bin

export SKYNET_BUILD_PATH = $(ZOO_BIN_PATH)
export LUA_CLIB_PATH = $(ZOO_BIN_PATH)/luaclib
export CSERVICE_PATH = $(ZOO_BIN_PATH)/cserviceexport

.PHONY: all linux macosx_arm64 clean

all: linux macosx_arm64

linux:
	mkdir -p $(ZOO_BIN_PATH)
	git submodule update --init
	cd 3rd/skynet && make linux
	cd 3rd/pbc && make
	cd 3rd/pbc/binding/lua53 && make
	cp 3rd/pbc/binding/lua53/protobuf.so $(LUA_CLIB_PATH)
	cp 3rd/pbc/binding/lua53/protobuf.lua ./lualib/

macosx_arm64:
	mkdir -p $(ZOO_BIN_PATH)
	git submodule update --init
	JEMALLOC_STATICLIB = 3rd/jemalloc/autogen.sh; export JEMALLOC_STATICLIB;
	export CC;
	cd 3rd/skynet && make macosx
	cd 3rd/pbc && make
	cd 3rd/pbc/binding/lua53 && chmod +x build_ios.sh && ./build_ios.sh
	cp 3rd/pbc/binding/lua53/libprotobuf-arm64.a $(LUA_CLIB_PATH)
	cp 3rd/pbc/binding/lua53/protobuf.lua ./lualib/

clean:
	rm -rf $(ZOO_BIN_PATH)
	cd 3rd/skynet && make clean
	cd 3rd/pbc && make clean
	cd 3rd/pbc/binding/lua53 && make clean
	cd 3rd/pbc/binding/lua53 && rm libprotobuf*
