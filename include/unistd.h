#ifndef _UNISTD_H
#define _UNISTD_H

#include <features.h>
#include <stddef.h>

__BEGIN_DECLS

#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

_Noreturn void _exit(int);

ssize_t write(int, const void*, size_t);
ssize_t read(int, void*, size_t);

long syscall(long, ...);

__END_DECLS

#endif /* unistd.h */