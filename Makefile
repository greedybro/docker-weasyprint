.SILENT:
.PHONY: build-weasyprint push-weasyprint
# Colors
COLOR_RESET   = \033[0m
COLOR_INFO    = \033[32m
COLOR_COMMENT = \033[33m
COLOR_ERROR   = \033[31m

## Help
help:
	printf "$(COLOR_COMMENT)Usage:$(COLOR_RESET)\n"
	printf " make [target]\n\n"
	printf "$(COLOR_COMMENT)Available targets:$(COLOR_RESET)\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-24s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

#################
# Weasyprint #
#################

WEASYPRINT_VERSION = 51

## Build weasyprint image(s)
build-weasyprint:
	docker build \
		--tag greedybro/weasyprint:$(WEASYPRINT_VERSION) \
		--build-arg WEASYPRINT_VERSION=$(WEASYPRINT_VERSION) \
		weasyprint

## Run temporary weasyprint container
run-weasyprint:
	docker run \
		--rm \
		--interactive \
		--tty \
		greedybro/weasyprint:$(WEASYPRINT_VERSION) \
		--help

## Sh into temporary weasyprint container
sh-weasyprint:
	docker run \
		--rm \
		--interactive \
		--tty \
		--entrypoint /bin/ash \
		greedybro/weasyprint:$(WEASYPRINT_VERSION)

## Publish weasyprint image(s)
push-weasyprint:
	$(call docker_login)
	docker push \
		greedybro/weasyprint:$(WEASYPRINT_VERSION)
