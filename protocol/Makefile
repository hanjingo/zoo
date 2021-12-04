VERSION = 0.0.1

3RD ?= ${shell pwd}/../3rd
ZOO_BIN_PATH ?= ${shell pwd}/../bin

PHONY: all init copy clean

all: init copy

init: 

copy:
	cp ${3RD}/pbc/binding/lua53/protobuf.lua ./

clean:
	rm protobuf.lua
	rm -rf data