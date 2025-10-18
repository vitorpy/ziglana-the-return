const syscalls = @import("syscalls.zig");

export fn entrypoint(_: [*]u8) u64 {
    // Inline string data to prevent sbpf-linker from stripping .rodata
    const message = [_]u8{'H','e','l','l','o',' ','w','o','r','l','d','!'};
    syscalls.log(&message);
    return 0;
}
