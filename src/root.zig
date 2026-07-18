pub const _start = {};

pub export const __libc_start_main = @import("libc_start.zig").__libc_start_main;

pub const stdlib = @import("stdlib/lib.zig");
pub const unistd = @import("unistd/lib.zig");
