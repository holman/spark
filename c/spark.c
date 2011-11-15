/*
The MIT License

Copyright (c) Jonathan Wright, quaggy@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

#define _POSIX_C_SOURCE 1

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <math.h>
#include <unistd.h>

const char *ticks[] = {" ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█", "+"};

struct array {
	int len, cap;
	int *data;
};

void append(struct array *a, int value) {
	if (a->data == NULL || a->cap == 0) {
		a->cap = 16;
		a->data = calloc(a->cap, sizeof(*a->data));
	}

	if (a->len == a->cap) {
		a->data = realloc(a->data, a->cap * sizeof(*a->data));
	}

	a->data[a->len] = value;
	a->len++;
}

void spark(char *s) {
	struct array a = { 0, 0, NULL };

	int i = 0;
	char *str;
	char *saveptr;

	for (str = s; ; str = NULL) {
		char *token = strtok_r(str, ",", &saveptr);
		if (token == NULL) {
			break;
		}
		i++;
		int d = atoi(token);

		append(&a, d);
	}

	int max = INT_MIN;
	for (int j = 0; j < a.len; j++) {
		int d = a.data[j];
		if (d > max) {
			max = d;
		}
	}

	for (int j = 0; j < a.len; j++) {
		int d = a.data[j];
		int o = round(8*((double)d)/max);
		printf("%s", ticks[o]);
	}

	printf("\n");
}

int main(int argc, char **argv) {
	if (argc >= 2) {
		spark(argv[1]);
		return EXIT_SUCCESS;
	} else if (!isatty(fileno(stdin))) {
		int bufcap = 4096;
		char *buf = calloc(bufcap, sizeof(*buf));
		if (fgets(buf, bufcap, stdin) != NULL) {
			spark(buf);
			return EXIT_SUCCESS;
		}
	}

	return EXIT_FAILURE;
}
