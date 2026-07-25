const _stream = @import("stream.zig");

const EOF = _stream.EOF;
const IO_FILE = _stream.IO_FILE;
const __overflow = _stream.__overflow;

pub export fn fputc(c: c_int, stream: *IO_FILE) callconv(.c) c_int {
    const char: u8 = @truncate(@as(c_uint, @bitCast(c)));
    return if (__overflow(char, stream)) 0 else EOF;
}

pub export fn fputs(noalias str: [*:0]const u8, noalias stream: *IO_FILE) callconv(.c) c_int {
    var i: usize = 0;

    while (str[i] != 0) : (i += 1) {
        if (!__overflow(str[i], stream)) {
            return EOF;
        }
    }

    return 0;
}

pub export fn puts(str: [*:0]const u8) callconv(.c) c_int {
    if (fputs(str, _stream.stdout) < 0) {
        return EOF;
    }

    if (!__overflow('\n', _stream.stdout)) {
        return EOF;
    }

    return 0;
}
