.global _start

_start:
    xor %rbp, %rbp
    mov (%rsp), %rdi            # argc
    lea 8(%rsp), %rsi           # argv
    lea 16(%rsp, %rdi, 8), %rdx # envp
    call __libc_start_main
    ud2