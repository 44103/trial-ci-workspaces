.PHONY: init plan apply destroy check create build \
	ci-build ci-stage

init:
	@docker compose run --rm terraform init -reconfigure -backend-config=dev.tfbackend

plan:
	@docker compose run --rm terraform plan

apply:
	@docker compose run --rm terraform apply -auto-approve

destroy:
	@docker compose run --rm terraform init -reconfigure -backend-config=dev.tfbackend
	@docker compose run --rm terraform fmt -check
	@docker compose run --rm terraform validate
	@docker compose run --rm terraform workspace switch default
	@docker compose run --rm terraform plan
	@docker compose run --rm terraform destroy

check:
	@docker compose run --rm terraform fmt -recursive
	@docker compose run --rm terraform fmt -check
	@docker compose run --rm terraform validate

create:
	@docker compose run --rm app cargo new $(FUNC) --bin
	@sudo chmod -R a+w infrastructure/functions/$(FUNC)

build:
	@docker compose run --rm app /bin/bash -c "cd $(FUNC) && rustup target add x86_64-unknown-linux-musl && cargo build --release --target x86_64-unknown-linux-musl"

ci-build:
	@./ci-build.sh

ci-stage:
	@./ci-stage.sh
