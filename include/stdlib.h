#ifndef _STDLIB_H
#define _STDLIB_H

#include <features.h>

int atexit(void (*) (void));
_Noreturn void exit(int);
_Noreturn void _Exit(int);

#endif /* stdlib.h */