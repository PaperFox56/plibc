var errno_storage: c_int = 0;

pub export fn __errno_location() callconv(.c) *c_int {
    // TODO: Implement thread safety
    return &errno_storage;
}

/// Set errno if the provided code is negative and return -1. if the code is positive, simply return it.
pub fn negErrno(code: isize) isize {
    if (code < 0) {
        // The kernel guaranties that the negative error codes are within range of 4096
        __errno_location().* = @intCast(-code);
        return -1;
    } else {
        return code;
    }
}
