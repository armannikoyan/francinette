
#include "utils.h"

int single_test_striteri(char *str, void (*fn)(unsigned int, char *), char *func, char *expected)
{
	set_sign("ft_striteri(\"%s\", %s)", str, func);

	char buffer[20];
	strcpy(buffer, str);
	int result = 1;
	ft_striteri(buffer, fn);
	result = same_string(expected, buffer);
	result = check_leaks(NULL) && result;
	null_null_check(ft_striteri(buffer, fn), result);
	return result;
}

void add(unsigned int i, char *c) {
	*c = (char)(i + *c);
}

void to_char_zero(unsigned int i, char *c) {
	*c = i - i + '0';
}

int test_striteri()
{
	int res = single_test_striteri("", add, "{(i, c) => i + c}", "");
	res = single_test_striteri("abcd0 ", add, "{(i, c) => i + c}", "aceg4%") && res;
	res = single_test_striteri("abcdfsdfs", to_char_zero, "{(i, c) => '0'}", "000000000") && res;

	return res;
}

int	main()
{
	handle_signals();
	test(striteri);
}
