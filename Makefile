#!/usr/bin/make -f
ifneq (,$(wildcard ./.env))
	include .env
	export
endif

build:
	docker compose up -d --build
	yarn && yarn build

serve:
	docker compose up -d
	docker compose exec app bin/console migration:migrate --no-interaction
	docker compose exec app bin/console orm:generate-proxies
	docker compose exec app bin/console app:auth:resources:update

sh:
	docker compose exec -it app /bin/bash

test:
	docker compose exec app composer analyse

mvc:
	cd vendor/strategio/megio-core
	git init
	git remote add origin git@github.com:strategio-digital/megio-core.git
	git pull
	git checkout master --force
	cd ../../../