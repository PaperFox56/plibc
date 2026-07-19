const std = @import("std");

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .x86_64,
        .os_tag = .linux,
    });

    const static_mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    static_mod.link_libc = false;
    static_mod.addIncludePath(b.path("include"));

    const lib_static = b.addLibrary(.{
        .name = "plibc",
        .root_module = static_mod,
        .linkage = .static,
    });
    b.installArtifact(lib_static);

    const dyn_mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    dyn_mod.link_libc = false;
    dyn_mod.addIncludePath(b.path("include"));

    const lib_dyn = b.addLibrary(.{
        .name = "plibc",
        .root_module = dyn_mod,
        .linkage = .dynamic,
    });
    b.installArtifact(lib_dyn);

    // const free_target = b.resolveTargetQuery(.{
    //     .cpu_arch = .x86_64,
    //     .os_tag = .linux,
    //     .abi = .none,
    // });
    const crt_mod = b.createModule(.{
        .root_source_file = b.path("src/crt/libc_start.zig"),
        .target = target,
        .optimize = optimize,
    });
    crt_mod.addAssemblyFile(b.path("src/crt/start.s"));
    const crt = b.addObject(.{
        .name = "crt",
        .root_module = crt_mod,
    });

    const install_crt = b.addInstallFile(crt.getEmittedBin(), "obj/crt.o");
    b.getInstallStep().dependOn(&install_crt.step);

    const test_mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = b.graph.host,
        .optimize = optimize,
    });
    test_mod.addIncludePath(b.path("include"));

    const tests = b.addTest(.{
        .root_module = test_mod,
        .name = "all",
    });
    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_tests.step);
}
