const root = @import("root");

pub export fn syscall(number: c_long, ...) callconv(.c) c_long {
    var ap = @cVaStart();
    defer @cVaEnd(&ap);

    const a1 = @cVaArg(&ap, usize);
    const a2 = @cVaArg(&ap, usize);
    const a3 = @cVaArg(&ap, usize);
    const a4 = @cVaArg(&ap, usize);
    const a5 = @cVaArg(&ap, usize);
    const a6 = @cVaArg(&ap, usize);

    const result = asm volatile (
        \\ syscall
        : [ret] "={rax}" (-> isize),
        : [num] "{rax}" (number),
          [di] "{rdi}" (a1),
          [si] "{rsi}" (a2),
          [dx] "{rdx}" (a3),
          [r10] "{r10}" (a4),
          [r8] "{r8}" (a5),
          [r9] "{r9}" (a6),
        : .{ .rcx = true, .r11 = true, .memory = true });

    return @intCast(root.errno.negErrno(result));
}

pub export fn write(fd: c_int, buf: ?*const anyopaque, count: usize) callconv(.c) isize {
    return @intCast(syscall(
        1,
        @as(usize, @intCast(fd)),
        @intFromPtr(buf),
        count,
    ));
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
