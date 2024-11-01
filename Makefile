# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: greus-ro <greus-ro@student.42barcel>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/13 02:39:39 by greus-ro          #+#    #+#              #
#    Updated: 2024/11/01 23:46:38 by greus-ro         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
# Colours
################################################################################

RST				= \033[0;39m
GRAY			= \033[0;90m
RED				= \033[0;91m
GREEN			= \033[0;92m
YELLOW			= \033[0;93m
BLUE			= \033[0;94m
MAGENTA			= \033[0;95m
CYAN			= \033[0;96m
WHITE			= \033[0;97m

################################################################################
# Folders
################################################################################

INC_DIR=./include
OBJ_DIR=./build
BIN_DIR=./bin
SRC_DIR=./src
LIBFT_DIR = ./libft
LIBFT_LIB = ${LIBFT_DIR}/bin/libft.a

################################################################################
# Compiler stuff
################################################################################

NAME		= libgnl.a
CC			= cc
CFLAGS		= -Wall -Werror -Wextra -MMD -MP
DFLAGS		= -D BUFFER_SIZE=30

ifdef	CSANITIZE
	SANITIZE_FLAGS	= -g3 -fsanitize=address -fsanitize=leak
endif

SRC		= 	ft_format.c				\
			ft_format_padding.c		\
			ft_format_prefix.c		\
			ft_width.c				\
			ft_padding_utils.c		\
			ft_precision.c			\
			ft_printf_char.c		\
			ft_printf_dec.c			\
			ft_printf_hex.c			\
			ft_printf_int.c			\
			ft_printf_low_hex.c		\
			ft_printf_percent.c		\
			ft_printf_ptr.c			\
			ft_printf_str.c			\
			ft_printf_up_hex.c		\
			ft_printf_usgn.c		\
			ft_printf.c
			
HDR		=	ft_printf.h

SRCS	= $(patsubst %.c, ${SRC_DIR}/%.c, ${SRC})
HDRS	= $(patsubst %.h, ${INC_DIR}/%.h, ${HDR})
OBJS	= $(patsubst %.c, ${OBJ_DIR}/%.o, ${SRC})
DEPS	= $(patsubst %.c, ${OBJ_DIR}/%.d, ${SRC})

all: folders ${SRCS} ${HDRS} ${BIN_DIR}/${NAME}

${SRCS}:
	@echo "Importing libft source..."
	@git submodule update --init
	@cp ${LIBFT_DIR}/src/ft_strjoin.c ${SRC_DIR}/libft/ft_strjoin.c
	@cp ${LIBFT_DIR}/src/ft_strlen.c ${SRC_DIR}/libft/ft_strlen.c
	@cp ${LIBFT_DIR}/src/ft_istrchr.c ${SRC_DIR}/libft/ft_istrchr.c
	@cp ${LIBFT_DIR}/src/ft_substr.c ${SRC_DIR}/libft/ft_substr.c
	@cp ${LIBFT_DIR}/src/ft_pointer.c ${SRC_DIR}/libft/ft_pointer.c
	@cp ${LIBFT_DIR}/src/ft_calloc.c ${SRC_DIR}/libft/ft_calloc.c
	@cp ${LIBFT_DIR}/src/ft_strlcpy.c ${SRC_DIR}/libft/ft_strlcpy.c
	@cp ${LIBFT_DIR}/src/ft_strlcat.c ${SRC_DIR}/libft/ft_strlcat.c
	@cp ${LIBFT_DIR}/src/ft_bzero.c ${SRC_DIR}/libft/ft_bzero.c
	@cp ${LIBFT_DIR}/src/ft_memset.c ${SRC_DIR}/libft/ft_memset.c
	
${HDRS}:
	@echo "Importing libft haders..."
	@git submodule update --init
	@cp ${LIBFT_DIR}/include/libft.h ${INC_DIR}/libft/libft.h

${BIN_DIR}/${NAME}: ${OBJS} Makefile
	@echo "\t${CYAN}Linking ${NAME}${RST}"
	ar -rcs ${BIN_DIR}/${NAME} ${OBJS}

${OBJ_DIR}/%.o:${SRC_DIR}/%.c Makefile
	@echo "\t${YELLOW}Compiling ${RST} $<"
	@${CC} ${CFLAGS} ${SANITIZE_FLAGS} ${DFLAGS} -I ${INC_DIR} -I ${INC_DIR}/libft -o $@ -c $<

clean:
	rm -rf ${OBJ_DIR}

fclean: clean 
	rm -rf ${BIN_DIR}

re: fclean all

folders: 
	@mkdir -p ${BIN_DIR}
	@mkdir -p ${OBJ_DIR}
	@mkdir -p ${OBJ_DIR}/libft
	@mkdir -p ${SRC_DIR}/libft
	@mkdir -p ${INC_DIR}/libft
	
-include ${DEPS}

.PHONY: all clean fclean re folders