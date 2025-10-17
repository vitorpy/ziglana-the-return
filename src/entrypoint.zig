export fn entrypoint(_: [*]u8) u64 {
    // Inline string data to prevent sbpf-linker from stripping .rodata
    const message = [_]u8{'H','e','l','l','o',' ','w','o','r','l','d','!'};
    const sol_log_ = @as(*align(1) const fn ([*]const u8, u64) void, @ptrFromInt(0x207559bd));
    sol_log_(&message, message.len);
    return 0;
}
