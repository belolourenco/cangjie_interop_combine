.DEFAULT_GOAL := build

CJPM = cjpm
PYTHON_CONFIG ?= python3-config

DEPS_DIR := build/deps
PYTHON_INTEROP_REPO := https://github.com/belolourenco/cangjie_interop_python.git
JAVASCRIPT_INTEROP_REPO := https://github.com/belolourenco/cangjie_interop_javascript.git
PYTHON_INTEROP_DIR := $(DEPS_DIR)/cangjie_interop_python
JAVASCRIPT_INTEROP_DIR := $(DEPS_DIR)/cangjie_interop_javascript

PYTHON_LDFLAGS ?= $(shell $(PYTHON_CONFIG) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG) --ldflags)
export PYTHON_LDFLAGS

.PHONY: all deps native build run clean

all: build

deps: $(PYTHON_INTEROP_DIR)/cjpm.toml $(JAVASCRIPT_INTEROP_DIR)/cjpm.toml

native: deps
	$(MAKE) -C $(PYTHON_INTEROP_DIR) native
	$(MAKE) -C $(JAVASCRIPT_INTEROP_DIR) native

build: native
	$(CJPM) build

run: build
	target/release/bin/main

clean:
	rm -rf build target build-script-cache

$(PYTHON_INTEROP_DIR)/cjpm.toml:
	mkdir -p $(DEPS_DIR)
	git clone $(PYTHON_INTEROP_REPO) $(PYTHON_INTEROP_DIR)

$(JAVASCRIPT_INTEROP_DIR)/cjpm.toml:
	mkdir -p $(DEPS_DIR)
	git clone $(JAVASCRIPT_INTEROP_REPO) $(JAVASCRIPT_INTEROP_DIR)
