#ifndef _ERRNO_H
#define _ERRNO_H

#include <features.h>

__BEGIN_DECLS

extern int *__errno_location(void);
#define errno (*__errno_location())

__END_DECLS

#endif /* errno.h */