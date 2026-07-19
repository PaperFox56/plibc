pub export fn _exit(code: c_int) callconv(.c) noreturn {
    // TODO: Close the file descriptors

    // For now, a simple exit syscall
    // SYS_exit_group = 231 on x86_64
    asm volatile (
        \\ syscall
        \\ ud2
        :
        : [number] "{rax}" (@as(usize, 231)),
          [code] "{rdi}" (code),
        : .{
          .rax = true,
          .rcx = true,
          .r11 = true,
          .memory = true,
        });
    unreachable;
}
