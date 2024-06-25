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
	./start.sh

.PHONY: clean
clean:

.PHONY: fclean
fclean: clean
