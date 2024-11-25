LD_FLAGS:=-lc --dynamic-linker=/lib/ld-linux-x86-64.so.2

SRC_DIRS:=$(sort $(dir $(wildcard src/*/)))
LIB_DIRS:=lib/ $(SRC_DIRS:src/%=lib/%)

SOURCES:=$(shell find src/ -name "*.s")
OUTPUTS:=$(SOURCES:src/%.s=lib/%.o)
PROGRAM_SOURCES:=$(filter %/main.s, $(SOURCES))
PROGRAM_OUTPUTS:=$(PROGRAM_SOURCES:src/%/main.s=bin/%)

default: $(LIB_DIRS) bin/ $(OUTPUTS) $(PROGRAM_OUTPUTS)


bin/%: lib/%/**
	ld $^ $(LD_FLAGS) -o $@

lib/%.o: src/%.s
	nasm -felf64 $^ -o $@

%/:
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf lib
	rm -rf bin
