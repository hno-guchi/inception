###########
# General #
###########

NAME = inception
ENV_FILE = ./srcs/.env
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

#################
# General Rules #
#################

.PHONY: all
all: $(NAME)

$(NAME):
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) up -d

.PHONY: clean
clean:
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down

.PHONY: fclean
fclean: clean
	docker system prune -f
	docker volume prune -f
	docker network prune -f

.PHONY: re
re: fclean all

.PHONY: update
update: clean
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) up -d --build

.PHONY: delete
delete: fclean
	docker volume rm srcs_inception_mariadb_data
	docker volume rm srcs_inception_wp_data
	docker image rm inception_nginx:latest
	docker image rm inception_mariadb:latest
	docker image rm inception_wordpress:latest
	rm -rf ./srcs/hnoguchi/mariadb/*
	rm -rf ./srcs/hnoguchi/wordpress/*

.PHONY: info
info:
	docker image ls -a
	docker container ls -a
	docker volume ls
	docker network ls
