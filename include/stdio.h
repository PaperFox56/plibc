#ifndef _STDIO_H
#define _STDIO_H

#include <features.h>
#include <stddef.h>

//#include <stdarg.h>

__BEGIN_DECLS

#define EOF -1


typedef struct {} FILE;

extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;


int fflush(FILE *stream);

int fputc(int c, FILE *stream);
int fputs(const char* str, FILE *stream);

size_t fwrite(const void *restrict src, size_t size, size_t count, FILE *restrict stream);

int puts(const char* str);

// The standard library allows putc to be a macro
#define putc(c, stream) fputc((c), (stream))
#define putchar(c) putc((c), stdout)

__END_DECLS

#endif /* stdio.h */