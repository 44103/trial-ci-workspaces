.PHONY: init plan apply destroy check create build chws

init:
	@docker compose run --rm terraform init -reconfigure -backend-config=dev.tfbackend

plan:
	@docker compose run --rm terraform plan

apply:
	@docker compose run --rm terraform apply -auto-approve

destroy:
	@docker compose run --rm terraform init -reconfigure -backend-config=dev.tfbackend
	@docker compose run --rm terraform validate
	@docker compose run --rm terraform workspace select $(WS)
	@docker compose run --rm terraform plan
	@docker compose run --rm terraform destroy

check:
	@make init
	@docker compose run --rm tf_fmt fmt -recursive
	@docker compose run --rm terraform validate
	@make plan

create:
	@docker compose run --rm app cargo new $(FUNC) --bin
	@sudo chmod -R a+w infrastructure/functions/$(FUNC)

build:
	# @docker compose run --rm app /bin/bash -c "cd $(FUNC) && rustup target add x86_64-unknown-linux-musl && cargo build --release --target x86_64-unknown-linux-musl"
	@docker compose run --rm app /bin/bash -c "cd lambda && rustup target add x86_64-unknown-linux-musl && cargo build --release --target x86_64-unknown-linux-musl --bin $(FUNC)"

chws:
	@docker compose run --rm terraform workspace select $(WS)
