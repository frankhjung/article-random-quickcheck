#!/usr/bin/make

PROJECT:= quickcheck
PYTHON := python3
PANDOC := pandoc
RM := rm

default: $(PROJECT).html $(PROJECT).pdf

.SUFFIXES:
.SUFFIXES: .md .html .pdf

.md.html:
	@mkdir -p public
	@$(PANDOC) \
		--from=gfm --to html5 \
		--embed-resources --standalone \
		--css article.css \
		--output public/index.html \
		$<

.md.pdf:
	@mkdir -p public
	@$(PANDOC) \
		--include-in-header preamble.tex \
		--from=markdown --pdf-engine=xelatex \
		--css article.css \
		--toc \
		--output public/$@ \
		$<

.PHONY: check
check:
	@uv run ruff check --fix src/
	@uv run ruff format src/

.PHONY: lint
lint:
	@uv run ruff check src/
	@uv run ruff format --check src/

.PHONY: test
test:
	@uv run pytest src/ -v

.PHONY: sync
sync:
	@uv sync --extra dev

.PHONY: clean
clean:
	@$(RM) -rf public
	@$(RM) -rf .pytest_cache
	@$(RM) -rf .ruff_cache
	@$(RM) -rf __pycache__
	@find . -name "__pycache__" -type d -exec $(RM) -rf {} +
