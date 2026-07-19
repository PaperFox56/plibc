extern fn exit(code: c_int) callconv(.c) noreturn;
extern fn main(argc: usize, argv: [*][*]u8) callconv(.c) c_int;

pub export fn __libc_start_main(
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
