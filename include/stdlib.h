#ifndef _STDLIB_H
#define _STDLIB_H

#include <features.h>

int atexit(void (*) (void));
_Noreturn void exit(int __status);
_Noreturn void _Exit(int __status);

#endif /* stdlib.h */