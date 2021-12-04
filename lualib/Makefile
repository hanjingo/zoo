VERSION = 0.0.1

3RD ?= ${shell pwd}/../3rd/
LLIB ?= ${3RD}/lualib/

PHONY: copy clean

copy:
	cp ${3RD}/pbc/binding/lua53/protobuf.lua ./
	cp ${LLIB}/str.lua ./
	cp ${LLIB}/currency.lua ./

clean:
	rm protobuf.lua
	rm str.lua
	rm currency.lua