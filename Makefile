.PHONY: pre-commit
pre-commit:
	pre-commit install --hook-type commit-msg
