/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf_hex_bonus.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gabriel <gabriel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/01/10 19:52:41 by greus-ro          #+#    #+#             */
/*   Updated: 2024/07/18 00:12:20 by gabriel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdarg.h>
#include <stdbool.h>
#include <stdlib.h>

#include "libft.h"
#include "ft_printf_bonus.h"

/*Sign flags + and space do not have sense with hex . 
	When we compile it gives you a "warning"*/
/* Hex only works with unsigned values so negatives are 0*/
/*
	Hex in case of 0, we do not have to put an 0x0.
*/
static int	ft_format_hashtag(bool up_case, t_format format, char **str)
{
	char	*new_str;

	if (format.b_hash)
	{
		if (up_case)
			new_str = ft_strjoin("0X", *str);
		else
			new_str = ft_strjoin("0x", *str);
		if (new_str == NULL)
			return (-1);
		free(*str);
		*str = new_str;
	}
	return (0);
}

static int	ft_format(t_format format, char **str, unsigned long number, \
				bool up_case)
{
	if (format.b_dot || format.b_minus)
		format.b_zero = false;
	if (number != 0)
		if (ft_format_hashtag(up_case, format, str) < 0)
			return (-1);
	if (ft_format_precision(format, str) < 0)
		return (-1);
	if (ft_format_width(format, str, false) < 0)
		return (-1);
	return (0);
}

int	ft_printf_hex(int fd, unsigned long number, bool up_case, t_format format)
{
	char	*str;
	int		num_bytes;

	str = ft_htoa(number, up_case);
	if (str == NULL)
		return (-1);
	if (ft_format(format, &str, number, up_case) < 0)
		return (free(str), -1);
	num_bytes = ft_iputstr_fd(str, fd);
	free (str);
	return (num_bytes);
}
