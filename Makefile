.PHONY: test/all test/suite build run clean get-gohint deps

GOPATH:=$(lastword $(subst :, ,$(GOPATH)))
PROJ_PATH:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
GOHINT_CONFIG_PATH:=$(PROJ_PATH)/deploy/go_hint_config.json

# Find packages with tests
GOHINT_ARGS:=$$(find . ! -path "./vendor/*" -iname '*.go')

test/all:
	$(info Starting all tests...)
	@cd $(PROJ_PATH) && go test -cover ./...

test/coverage:
	@cd $(PROJ_PATH) && go test -coverprofile=cover.out ./core

coverage:
	@cd $(PROJ_PATH) && go tool cover -html=cover.out

test/suite:
	$(info Starting specified test suite...)
	@cd $(path) && go test -tags="all" -check.f="$(suite)" .

$(GOPATH)/bin/gohint:
	@echo "Installing gohint ..."
	@go get godep.lzd.co/hint/gohint

get-gohint: $(GOPATH)/bin/gohint
	@echo "Gohint is installed"

gohint: get-gohint
ifeq ($(wildcard $GOHINT_CONFIG_PATH),)
		@cd $(PROJ_PATH)
		$(info Starting gohint...)
		@$(GOPATH)/bin/gohint -config=$(GOHINT_CONFIG_PATH) $(GOHINT_ARGS)
endif

build:
	@cd $(PROJ_PATH)
	$(info Starting build...)
	@go build

run:
	@cd $(PROJ_PATH)
	$(info Run...)
	@go run main.go

clean:
	rm -rf cover

deps:
	go get gopkg.in/check.v1