.PHONY: lint format format-check check

format:
	stylua lua/ colors/

format-check:
	stylua --check lua/ colors/

lint: format-check
	selene lua/ colors/

check: lint
