#ifndef _UNISTD_H
#define _UNISTD_H

#include <features.h>
#include <stddef.h>

__BEGIN_DECLS

#define STDIN_FILENO 0
#define STDOUT_FILENO 1
#define STDERR_FILENO 2

_Noreturn void _exit(int __status);

ssize_t write(int fd, const void *buf, size_t count);
ssize_t read(int fd, void *buf, size_t count);

long syscall(long number, ...);

__END_DECLS

#endif /* unistd.h */