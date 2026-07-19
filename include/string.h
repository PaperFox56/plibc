#ifndef _STRING_H
#define _STRING_H

#include <features.h>
#include <stddef.h>

__BEGIN_DECLS

void *memcpy(void *restrict dest, const void *restrict src, size_t count);
void *memmove(void * dest, const void *src, size_t count);
void *memset(void *buf, int val, size_t count);
int memcmp (const void * str1, const void *str2, size_t n);

size_t strlen (const char * str);
// void *memchr (const void *, int, size_t);

// char *strcpy (char *__restrict, const char *__restrict);
// char *strncpy (char *__restrict, const char *__restrict, size_t);

// char *strcat (char *__restrict, const char *__restrict);
// char *strncat (char *__restrict, const char *__restrict, size_t);

// int strcmp (const char *, const char *);
// int strncmp (const char *, const char *, size_t);

__END_DECLS

#endif /* string.h */