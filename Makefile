SHELL := bash
.DEFAULT_GOAL := help
TARGET_COLUMN_CHARS = 20

post-title := $(shell echo $(title) | awk -f $(CURDIR)/scripts/titlecase.awk)
post-file := $(shell date +"%Y-%m-%d")-$(title)
post-path := _posts/$(post-file).md

.PHONY: new-post
.SILENT: new-post
## Create a new post template with the specified title
new-post:
	[[ -n "$(title)" ]] || (echo "error: no title set, use make new-post title=post-title"; exit 1)
	[[ ! -f "$(post-path)" ]] || (echo "error: $(post-path) exists"; exit 1)
	echo "Creating new post with title '$(post-title)'"
	echo "---" > $(post-path)
	echo "layout: post" >> $(post-path)
	echo 'title: "$(post-title)"' >> $(post-path)
	echo "date: $(shell date +"%Y-%m-%d %H:%M:%S %z")" >> $(post-path)
	echo "categories: posts" >> $(post-path)
	echo -e "---\n" >> $(post-path)
	echo "Created $(post-path)"

.PHONY: help
.SILENT: help
## Print this help
help:
	echo 'usage: make <target>'
	echo
	echo 'targets:'
	awk '/^[a-zA-Z\-_0-9]+:/ { \
		docstring = match(lastline, /^## (.*)/); \
		if (docstring) { \
			target = substr($$1, 1, index($$1, ":")-1); \
			docstring = substr(lastline, RSTART + 3, RLENGTH); \
			printf "  %-$(TARGET_COLUMN_CHARS)s %s\n", target, docstring; \
		} \
	} \
	{ lastline = $$0 }' $(MAKEFILE_LIST)
