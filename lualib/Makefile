VERSION = 0.0.1

3RD ?= ${shell pwd}/../3rd
LLIB ?= ${3RD}/lualib/

PHONY: all init copy build clean

all: init copy

init:
	mkdir -p data

copy:
	cp ${LLIB}/str.lua ./
	cp ${LLIB}/currency.lua ./

build:
	

clean:
	rm str.lua
	rm currency.lua