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
	docker-compose -f ./srcs/docker-compose.yml up -d --build

.PHONY: clean
clean:
	docker-compose -f ./srcs/docker-compose.yml down

.PHONY: fclean
fclean: clean

.PHONY: re
re: fclean all

.PHONY: sandbox
sandbox:
	docker-compose -f ./sandBox/docker-compose.yml up -d

.PHONY: sandbox-clean
sandbox-clean:
	docker-compose -f ./sandBox/docker-compose.yml down
