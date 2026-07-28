pub export fn memcpy(
    noalias dest: [*]u8,
    noalias src: [*]const u8,
    count: usize,
) callconv(.c) [*]u8 {
    // for (0..count) |i| {
    //    dest[i] = src[i];
    // }

    // Had to rewrite this in assembly because the compiler wouldn't stop creating weird recursions here
    asm volatile (
        \\ rep movsb
        :
        : [d] "{rdi}" (dest),
          [s] "{rsi}" (src),
          [c] "{rcx}" (count),
        : .{ .rdi = true, .rsi = true, .rcx = true, .memory = true });
    return dest;
}

pub export fn memmove(
    dest: [*]u8,
    src: [*]const u8,
    count: usize,
) callconv(.c) [*]u8 {
    const s = @intFromPtr(src);
    const d = @intFromPtr(dest);

    if (d <= s or s + count <= d) {
        // dest is ahead of src, we can copy from the front
        for (0..count) |i| {
            dest[i] = src[i];
        }
    } else {
        // dest is in front of src, we copy from the end to the start
        var i = count;
        while (i > 0) {
            i -= 1;
            dest[i] = src[i];
        }
    }
    return dest;
}

pub export fn memset(
    buf: [*]u8,
    value: c_int,
    count: usize,
) callconv(.c) [*]u8 {
    const byte: u8 = @truncate(@as(c_uint, @bitCast(value)));

    asm volatile (
        \\ rep stosb
        :
        : [dst] "{rdi}" (buf),
          [val] "{al}" (byte),
          [cnt] "{rcx}" (count),
        : .{ .rdi = true, .rcx = true, .memory = true });
    return buf;
}

pub export fn memcmp(
    str1: [*]const u8,
    str2: [*]const u8,
    n: usize,
) callconv(.c) c_int {
    var i: usize = 0;
    while (i < n) {
        if (str1[i] != str2[i]) {
            return @as(c_int, str1[i]) - @as(c_int, str2[i]);
        }
        i += 1;
    }
    return 0;
}

pub export fn memchr(
    s: [*]const u8,
    c: c_int,
    n: usize,
) callconv(.c) ?*const u8 {
    const ch: u8 = @truncate(@as(c_uint, @bitCast(c)));

    for (0..n) |i| {
        if (s[i] == ch) {
            return @ptrCast(s + i);
        }
    }
    return null;
}

pub export fn memrchr(
    s: [*]const u8,
    c: c_int,
    n: usize,
) callconv(.c) *const u8 {
    const ch: u8 = @truncate(@as(c_uint, @bitCast(c)));

    var i = n - 1;
    while (i >= 0) : (i -= 1) {
        if (s[i] == ch) {
            return @ptrCast(s + i);
        }
    }
    return null;
}

// Tests
//----------------------------------
test "memchr and memrchr" {
    const std = @import("std");
    const strings = [_]struct { []const u8, u8, usize, usize }{
        .{ "This is a string!", 'i', 2, 3 },
        .{ "This string isn't too long is it?", 'g', 10, 7 },
        .{ []u8{ 2, 4, 1, 5, 2, 5, 2 }, 5, 3, 3 },
    };
    for (strings) |s| {
        const str = s.@"0";
        const c = s.@"1";
        const pos1 = memchr(str, c, str.len);
        try std.testing.expectEqual(c, pos1.*);
        try std.testing.expectEqual(str.ptr + s.@"2", pos1);
        const pos2 = memrchr(str, c, str.len);
        try std.testing.expectEqual(c, pos2.*);
        try std.testing.expectEqual(str.ptr + s.@"3", pos2);
    }
}

test "memcpy" {
    const std = @import("std");
    var dest: [5]u8 = undefined;
    const src = "hello";
    _ = memcpy(&dest, src, 5);
    try std.testing.expectEqualSlices(u8, "hello", &dest);
}

test "memmove" {
    const std = @import("std");
    var buf = [_]u8{ 1, 2, 3, 4, 5 };
    _ = memmove(buf[1..].ptr, buf[0..].ptr, 4);
    try std.testing.expectEqualSlices(u8, &.{ 1, 1, 2, 3, 4 }, &buf);
}

test "memset" {
    const std = @import("std");
    var buf = [_]u8{ 9, 9, 9 };
    _ = memset(&buf, 0, 0);
    try std.testing.expectEqualSlices(u8, &.{ 9, 9, 9 }, &buf);
}
