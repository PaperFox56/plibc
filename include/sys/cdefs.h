#ifndef _SYS_CDEFS_H
#define _SYS_CDEFS_H


#ifdef __cplusplus
# define __BEGIN_DECLS extern "C" {
# define __END_DECLS }

#define NULL nullptr
#else
# define __BEGIN_DECLS
# define __END_DECLS

#define NULL ((void*)0)
#endif

#endif /* sys/cdefs.h */