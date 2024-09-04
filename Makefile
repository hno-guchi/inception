###########
# General #
###########

NAME = inception

#################
# General Rules #
#################

.PHONY: all
all: $(NAME)

$(NAME):
	docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml up -d --build

.PHONY: clean
clean:
	docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml down

.PHONY: fclean
fclean: clean
	docker volume rm srcs_inception_mariadb_data
	docker volume rm srcs_inception_wp_data
	docker image rm inception_nginx:latest
	docker image rm inception_mariadb:latest
	docker image rm inception_wordpress:latest

.PHONY: re
re: fclean all

.PHONY: sandbox
sandbox:
	docker-compose -f ./sandBox/docker-compose.yml up -d

.PHONY: sandbox-clean
sandbox-clean:
	docker-compose -f ./sandBox/docker-compose.yml down
