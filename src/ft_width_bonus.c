/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_width_bonus.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gabriel <gabriel@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/07/09 12:06:09 by greus-ro          #+#    #+#             */
/*   Updated: 2024/07/14 00:27:44 by gabriel          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>

#include "libft.h"
#include "ft_printf_bonus.h"

/*
If we geet precision with numeric conversion, zero flag is ignored.
*/
int	ft_format_width(t_format format, char **str, bool sign_print)
{
	int		len;

	if (format.n_width > 0)
	{
		len = ft_strlen(*str);
		if (sign_print)
			len++;
		if ((int)format.n_width - len <= 0)
			return (0);
		if (ft_add_padding(format, str, format.n_width, len) < 0)
			return (-1);
	}
	return (0);
}
