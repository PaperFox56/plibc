#ifndef _STDIO_H
#define _STDIO_H

#include <features.h>
#include <stddef.h>

//#include <stdarg.h>

__BEGIN_DECLS

#define EOF -1


typedef struct _IO_FILE FILE;

extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;


int fflush(FILE*);

int fputc(int, FILE *);
int fputs(const char*, FILE*);

size_t fwrite(const void *restrict, size_t, size_t, FILE *restrict);



int puts(const char*);

// The standard library allows putc to be a macro
#define putc(c, stream) fputc((c), (stream))
#define putchar(c) putc((c), stdout)

__END_DECLS

#endif /* stdio.h */