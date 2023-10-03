.PHONY: mojo
mojo:
	sh .env_setup.sh

.PHONY: test
test: 
	mojo run test.mojo

.PHONY: build
build: 
	mkdir -p dist
	mojo package mo_time -o dist/mo_time.mojopkg
