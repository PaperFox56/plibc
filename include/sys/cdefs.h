#ifndef _SYS_CDEFS_H
#define _SYS_CDEFS_H


#ifdef __cplusplus
# define __BEGIN_DECLS extern "C" {
# define __END_DECLS }
#else
# define __BEGIN_DECLS
# define __END_DECLS
#endif

#define __LEAF
#define __NORETURN __attribute__ ((__noreturn__))
#define __THROW __attribute__ ((__nothrow__ __LEAF))

#endif /* sys/cdefs.h */