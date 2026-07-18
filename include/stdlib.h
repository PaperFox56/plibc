#ifndef _STDLIB_H
#define _STDLIB_H

#include <sys/cdefs.h>

/* NONIMPLEMENTED!
   Call all functions registered with `atexit' and `on_exit',
   in the reverse of the order in which they were registered,
   perform stdio cleanup, and terminate program execution with STATUS.  */
void exit(int __status) __THROW __NORETURN;

/* Terminate the program with STATUS without calling any of the
   functions registered with `atexit' or `on_exit'.  */
void _Exit(int __status) __THROW __NORETURN;

#endif /* stdlib.h */