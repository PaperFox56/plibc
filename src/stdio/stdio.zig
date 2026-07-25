comptime {
    _ = @import("put.zig");
}

const _stream = @import("stream.zig");

const EOF = _stream.EOF;
const IO_FILE = _stream.IO_FILE;
const __overflow = _stream.__overflow;

pub export fn fwrite(
    noalias src: [*]const u8,
    size: usize,
    count: usize,
    noalias stream: *IO_FILE,
) callconv(.c) usize {
    var item: usize = 0;
    var pos: usize = 0;

    while (item < count) : (item += 1) {
        for (0..size) |_| {
            if (!__overflow(src[pos], stream)) {
                break;
            }
            pos += 1;
        }
    }

    return item;
}
