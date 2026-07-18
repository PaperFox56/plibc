const std = @import("std");

pub fn build(b: *std.Build) void {
    // TODO: Support dynamic linking

    // Target: x86_64 Linux only
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .os_tag = .linux,
        .abi = .none, // Static linking, no dynamic linker
    });
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .strip = true,
    });

    mod.link_libc = false;
    mod.addIncludePath(b.path("include"));
    mod.addAssemblyFile(b.path("src/crt/start.s"));

    const libc_exe = b.addExecutable(.{
        .root_module = mod,
        .name = "plibc",
    });

    // Disable PIE (Position Independent Executable) to simplify addressing.
    libc_exe.pie = false;
    libc_exe.entry = .disabled;
    // Test
    //---------
    const test_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .strip = true,
    });
    test_mod.link_libc = false;
    test_mod.addIncludePath(b.path("include"));
    test_mod.addCSourceFile(.{
        .file = b.path("test/main.c"),
    });

    const test_obj = b.addObject(.{
        .root_module = test_mod,
        .name = "test",
    });

    libc_exe.root_module.addObjectFile(test_obj.getEmittedBin());

    b.installArtifact(libc_exe);

    const run_cmd = b.addRunArtifact(libc_exe);
    const run_step = b.step("run", "Run the test program with our libc");
    run_step.dependOn(&run_cmd.step);
}
