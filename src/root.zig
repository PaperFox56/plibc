pub const _start = {};

pub export const __libc_start_main = @import("libc_start.zig").__libc_start_main;

pub const stdlib = @import("stdlib/stdlib.zig");
pub const unistd = @import("unistd/unistd.zig");
pub const errno = @import("errno/errno.zig");
