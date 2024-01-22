define help =
make help
  Display this help.
make up
  Build, create, and start the service containers.
make down
  Stop and delete the service containers.
make purge
  Delete all service containers and named volumes.
make etl/requirements.txt
  Update etl/requirements.txt to reflect currently installed Python packages.
make etl/renv.lock
  Update etl/renv.lock to reflect currently installed R packages.
endef

NORM = $(shell tput sgr0)
BOLD = $(shell tput bold)

help:
	@: $(info $(help))
.PHONY: help

up:
	docker compose up --build --detach
	@echo "Access the ADMIN site at $(BOLD)http://$$ADMIN_HOST:$$ADMIN_PORT/$(NORM)"
	@echo "Access the DGS site at $(BOLD)http://$$DGS_HOST:$$DGS_PORT/$(NORM)"
.PHONY: up

down:
	docker compose down
.PHONY: down

purge:
	docker compose down --volumes
.PHONY: purge
