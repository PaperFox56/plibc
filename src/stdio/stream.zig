const unistd = @import("../unistd/unistd.zig");
const errno = @import("../errno/errno.zig");

// TODO: keep track of all open streams
// TODO: support other buffering modes than line buffering

pub const EOF = -1;

pub const IO_FILE = extern struct {
    fd: c_int,
    buf: [*]u8,
    buf_size: usize, // The actual memory size
    buf_pos: usize,
    buf_len: usize, // The amount of meaningful data inside the buffer
    eof: c_int,
    err: c_int,
};

const buffer_size = 4096;
var stdout_buf: [buffer_size]u8 = undefined;
var stdout_file = IO_FILE{
    .fd = unistd.STDOUT_FILENO,
    .buf = &stdout_buf,
    .buf_size = buffer_size,
    .buf_pos = 0,
    .buf_len = 0,
    .eof = 0,
    .err = 0,
};

pub export const stdout = &stdout_file;

pub export fn fflush(stream: *IO_FILE) callconv(.c) c_int {
    // TODO: Take in account NULL
    // TODO: Not all stream are open in write mode!
    const expected_count = stream.buf_len;
    const result = unistd.write(stream.fd, stream.buf, expected_count);

    stream.buf_pos = 0;
    stream.buf_len = 0;

    if (result < expected_count) {
        stream.err = errno.__errno_location().*;
        return EOF;
    } else return 0;
}

/// Tries to put one character into the stream's buffer and flushes it if necessary
pub inline fn __overflow(c: u8, stream: *IO_FILE) bool {
    stream.buf[stream.buf_pos] = c;
    stream.buf_pos += 1;

    if (stream.buf_pos > stream.buf_len) {
        stream.buf_len = stream.buf_pos;
    }

    var flush = false;
    if (stream.buf_pos >= stream.buf_size) {
        flush = true;
    } else if (c == '\n') {
        flush = true;
    }

    if (flush) {
        const result = fflush(stream);

        if (result != 0) return false;
    }

    return true;
}
