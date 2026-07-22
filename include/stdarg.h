#ifndef _STDARGRING_H
#define _STDARG_H

#include <features.h>
#include <stddef.h>

__BEGIN_DECLS

typedef struct
{
    unsigned int gp_offset;
    unsigned int fp_offset;
    void *overflow_arg_area;
    void *reg_save_area;
} va_list;

#define va_start(v, l) __builtin_va_start(v, l)
#define va_end(v) __builtin_va_end(v)
#define va_arg(v, l) __builtin_va_arg(v, l)
#define va_copy(d, s) __builtin_va_copy(d, s)
__END_DECLS

#endif /* stdarg.h */