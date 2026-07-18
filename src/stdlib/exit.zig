pub export fn exit(code: c_int) callconv(.c) noreturn {
    // TODO: call the functions registered by atexit
    _Exit(code);
}

pub export fn _Exit(code: c_int) callconv(.c) noreturn {
    // Specification says those are identical
    @import("../unistd/lib.zig")._exit(code);
}
