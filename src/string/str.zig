pub export fn strlen(
    str: [*:0]const u8,
) callconv(.c) usize {
    var len: usize = 0;
    while (str[len] != 0) : (len += 1) {}

    return len;
}

pub export fn strnul(
    str: [*:0]u8,
) callconv(.c) *u8 {
    return @ptrCast(str + strlen(str));
}

pub export fn strcpy(
    noalias dest: [*:0]u8,
    noalias src: [*:0]const u8,
) callconv(.c) [*:0]u8 {
    var i: usize = 0;
    while (src[i] != 0) : (i += 1) {
        dest[i] = src[i];
    }
    dest[i] = 0;
    return dest;
}

pub export fn strcat(
    noalias dest: [*:0]u8,
    noalias src: [*:0]const u8,
) callconv(.c) [*]u8 {
    return strcpy(@ptrCast(strnul(dest)), src);
}

// Tests
//--------------------------
test "strlen" {
    const std = @import("std");
    const strings = [_]struct { [:0]const u8, usize }{
        .{ "Hello", 5 },
        .{ "This is a string!", 17 },
        .{ "This string is \x00cut in the middle", 15 },
    };
    for (strings) |s| {
        try std.testing.expectEqual(
            s.@"1",
            strlen(s.@"0"),
        );
    }
}
