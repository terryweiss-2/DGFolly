.PHONY: install lint test

install:
	npm install

lint:
	npx oxlint

test:
	npx tap --allow-empty-coverage --disable-coverage packages/*/tests
