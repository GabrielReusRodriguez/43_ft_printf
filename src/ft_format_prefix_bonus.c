/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_format_prefix_bonus.c                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gabriel <gabriel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/07/05 21:43:40 by gabriel           #+#    #+#             */
/*   Updated: 2024/07/17 22:41:38 by gabriel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "libft.h"
#include "ft_printf_bonus.h"

bool	ft_format_parse_prefix_flags(const char *str, size_t *j, \
					t_format *format)
{
	if (str[*j] == '+' || str[*j] == '#')
	{
		if (str[*j] == '+')
			format->b_plus = true;
		if (str[*j] == '#')
			format->b_hash = true;
		*j = *j + 1;
		return (true);
	}
	return (false);
}
