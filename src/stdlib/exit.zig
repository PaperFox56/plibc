/// A function that takes no argument and returns nothing
const Procedure = *const fn () callconv(.c) void;

const ATEXIT_FUNCTIONS_MAX = 256;
/// TODO: Implement dynamic allocation.
///
/// List of pointers to the functions that need to be called at exit.
/// It is implemented as stack were the elements are inserted from the
/// bottom (higher index) to the top (0).
var atexitFunctions: [ATEXIT_FUNCTIONS_MAX]Procedure = undefined;
var atexitFunctionsBase: usize = ATEXIT_FUNCTIONS_MAX;

pub export fn exit(code: c_int) callconv(.c) noreturn {
    for (atexitFunctions[atexitFunctionsBase..]) |func| {
        func();
    }

    _Exit(code);
}

pub export fn atexit(func: Procedure) callconv(.c) c_int {
    if (atexitFunctionsBase <= 0) {
        // TODO: Handle this error properly by allocating more space
        return -1;
    }
    atexitFunctionsBase -= 1;
    atexitFunctions[atexitFunctionsBase] = func;

    return 0;
}

pub export fn _Exit(code: c_int) callconv(.c) noreturn {
    // Specification says those are identical
    @import("root").unistd._exit(code);
}
