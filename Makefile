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
	./down.sh

.PHONY: fclean
fclean: clean
