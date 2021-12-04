VERSION = 0.0.1

.PHONY: com linux macosx_arm64 clean

com:
	cd lua-cmsgpack && mkdir -p build && cd build && cmake ..
	cd lua-cmsgpack/build && make
	cd pbc && make

linux: com
	cd pbc/binding/lua53 && make
	cd skynet && make linux

macosx_arm64: com
	cd pbc/binding/lua53 && chmod +x build_ios.sh && ./build_ios.sh
	JEMALLOC_STATICLIB = 3rd/jemalloc/autogen.sh; export JEMALLOC_STATICLIB;
	export CC;
	cd skynet && make macosx

clean:
	cd skynet && make clean
	cd pbc && make clean
	cd pbc/binding/lua53 && make clean
	cd lua-cmsgpack/build && make clean