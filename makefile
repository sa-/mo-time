.PHONY: mojo
mojo:
	sh .env_setup.sh

.PHONY: test
test: 
	mojo run test.mojo