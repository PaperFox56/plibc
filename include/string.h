#ifndef _STRING_H
#define _STRING_H

#include <features.h>
#include <stddef.h>

__BEGIN_DECLS

void *memcpy(void* restrict, const void* restrict, size_t);
void *memmove(void*, const void*, size_t);

int memcmp (const void*, const void*, size_t);

void *memset(void*, int, size_t);

void *memchr(const void*, int, size_t);
void *memrchr(const void*, int, size_t);


size_t strlen (const char*);

char *strnul(const char *s);
char *strcpy (char *__restrict, const char *__restrict);
// char *strncpy (char *__restrict, const char *__restrict, size_t);

char *strcat (char *__restrict, const char *__restrict);
// char *strncat (char *__restrict, const char *__restrict, size_t);

// int strcmp (const char *, const char *);
// int strncmp (const char *, const char *, size_t);

__END_DECLS

#endif /* string.h */