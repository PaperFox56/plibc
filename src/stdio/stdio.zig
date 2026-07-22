const unistd = @import("../unistd/unistd.zig");
const string = @import("../string/string.zig");

const EOF = 0;

pub export fn puts(str: [*:0]const u8) callconv(.c) c_int {
    const result = unistd.write(
        unistd.STDOUT_FILENO,
        str,
        string.strlen(str),
    );
    if (result < 0) return EOF;
    const _result = unistd.write(
        unistd.STDOUT_FILENO,
        "\n",
        1,
    );
    return if (_result < 0) EOF else @intCast(result + 1);
}
