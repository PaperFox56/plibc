const exit = @import("stdlib/exit.zig").exit;

extern fn main(argc: usize, argv: [*][*]u8) c_int;

pub fn __libc_start_main(
    argc: usize,
    argv: [*][*]u8,
    envp: [*][*]u8,
) callconv(.c) noreturn {
    // TODO: Initialize malloc
    // TODO: Initialize stdio
    // TODO: Register atexit handlers

    const result = main(argc, argv);
    _ = envp;
    exit(result);
}
