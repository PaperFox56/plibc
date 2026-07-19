pub export fn memcpy(noalias dest: [*]u8, noalias src: [*]const u8, count: usize) callconv(.c) [*]u8 {
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

pub export fn memmove(dest: [*]u8, src: [*]const u8, count: usize) callconv(.c) [*]u8 {
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

pub export fn memset(buf: [*]u8, value: c_int, count: usize) callconv(.c) [*]u8 {
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

pub export fn memcmp(str1: [*]const u8, str2: [*]const u8, n: usize) callconv(.c) c_int {
    var i: usize = 0;
    while (i < n) {
        if (str1[i] != str2[i]) {
            return @as(c_int, str1[i]) - @as(c_int, str2[i]);
        }
        i += 1;
    }
    return 0;
}

// Tests
//--------------------------
test "memcpy basic" {
    const std = @import("std");
    var dest: [5]u8 = undefined;
    const src = "hello";
    _ = memcpy(&dest, src, 5);
    try std.testing.expectEqualSlices(u8, "hello", &dest);
}

test "memmove overlapping forward" {
    const std = @import("std");
    var buf = [_]u8{ 1, 2, 3, 4, 5 };
    _ = memmove(buf[1..].ptr, buf[0..].ptr, 4);
    try std.testing.expectEqualSlices(u8, &.{ 1, 1, 2, 3, 4 }, &buf);
}

test "memset zero count is a no-op" {
    const std = @import("std");
    var buf = [_]u8{ 9, 9, 9 };
    _ = memset(&buf, 0, 0);
    try std.testing.expectEqualSlices(u8, &.{ 9, 9, 9 }, &buf);
}
