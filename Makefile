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
	docker-compose -f ./srcs/docker-compose.yml build
	docker-compose -f ./srcs/docker-compose.yml up -d

.PHONY: clean
clean:
	docker-compose -f ./srcs/docker-compose.yml down

.PHONY: fclean
fclean: clean

.PHONY: re
re: fclean all
