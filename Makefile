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
delete:
	-@if [ -n "$$(docker ps -qa)" ]; then docker stop $$(docker ps -qa); else echo "No containers to stop."; fi
	-@if [ -n "$$(docker ps -qa)" ]; then docker rm $$(docker ps -qa); else echo "No containers to remove."; fi
	-@if [ -n "$$(docker images -qa)" ]; then docker rmi -f $$(docker images -qa); else echo "No images to remove."; fi
	-@if [ -n "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q); else echo "No volumes to remove."; fi
	-@if [ -n "$$(docker network ls -q)" ]; then docker network rm $$(docker network ls -q); else echo "No networks to remove."; fi
	-rm -rf ./srcs/hnoguchi/data/mariadb/*
	-rm -rf ./srcs/hnoguchi/data/wordpress/*

.PHONY: info
info:
	docker image ls -a
	docker container ls -a
	docker volume ls
	docker network ls
