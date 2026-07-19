const root = @import("root");

pub export fn write(fd: c_int, buf: ?*const anyopaque, count: usize) callconv(.c) isize {
    const result = asm volatile (
        \\ syscall
        : [ret] "={rax}" (-> isize),
        : [number] "{rax}" (@as(usize, 1)),
          [di] "{rdi}" (@as(usize, @intCast(fd))),
          [si] "{rsi}" (@as(usize, @intFromPtr(buf))),
          [dx] "{rdx}" (@as(usize, count)),
        : .{
          .rax = true,
          .rcx = true,
          .r11 = true,
          .memory = true,
        });

    return root.errno.negErrno(result);
}

pub export fn _exit(status: c_int) callconv(.c) noreturn {
    // TODO: Close the file descriptors

    // For now, a simple exit syscall
    // SYS_exit_group = 231 on x86_64
    const code = status & 0xff;

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
