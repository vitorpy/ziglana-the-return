/// Syscall definitions from solana-sdk
/// Based on: https://github.com/anza-xyz/solana-sdk/blob/master/define-syscall/src/definitions.rs

pub const SyscallDef = struct {
    name: []const u8,
    signature: []const u8,
    params: []const Param,
    return_type: ?[]const u8,
};

pub const Param = struct {
    name: []const u8,
    type: []const u8,
};

pub const syscalls = [_]SyscallDef{
    .{
        .name = "sol_log_",
        .signature = "fn([*]const u8, u64) void",
        .params = &[_]Param{
            .{ .name = "message", .type = "[*]const u8" },
            .{ .name = "len", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_log_64_",
        .signature = "fn(u64, u64, u64, u64, u64) void",
        .params = &[_]Param{
            .{ .name = "arg1", .type = "u64" },
            .{ .name = "arg2", .type = "u64" },
            .{ .name = "arg3", .type = "u64" },
            .{ .name = "arg4", .type = "u64" },
            .{ .name = "arg5", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_log_compute_units_",
        .signature = "fn() void",
        .params = &[_]Param{},
        .return_type = null,
    },
    .{
        .name = "sol_log_pubkey",
        .signature = "fn([*]const u8) void",
        .params = &[_]Param{
            .{ .name = "pubkey_addr", .type = "[*]const u8" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_log_data",
        .signature = "fn([*]const u8, u64) void",
        .params = &[_]Param{
            .{ .name = "data", .type = "[*]const u8" },
            .{ .name = "data_len", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_sha256",
        .signature = "fn([*]const u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "vals", .type = "[*]const u8" },
            .{ .name = "val_len", .type = "u64" },
            .{ .name = "hash_result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_keccak256",
        .signature = "fn([*]const u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "vals", .type = "[*]const u8" },
            .{ .name = "val_len", .type = "u64" },
            .{ .name = "hash_result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_blake3",
        .signature = "fn([*]const u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "vals", .type = "[*]const u8" },
            .{ .name = "val_len", .type = "u64" },
            .{ .name = "hash_result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_memcpy_",
        .signature = "fn([*]u8, [*]const u8, u64) void",
        .params = &[_]Param{
            .{ .name = "dst", .type = "[*]u8" },
            .{ .name = "src", .type = "[*]const u8" },
            .{ .name = "n", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_memmove_",
        .signature = "fn([*]u8, [*]const u8, u64) void",
        .params = &[_]Param{
            .{ .name = "dst", .type = "[*]u8" },
            .{ .name = "src", .type = "[*]const u8" },
            .{ .name = "n", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_memcmp_",
        .signature = "fn([*]const u8, [*]const u8, u64, [*]i32) void",
        .params = &[_]Param{
            .{ .name = "s1", .type = "[*]const u8" },
            .{ .name = "s2", .type = "[*]const u8" },
            .{ .name = "n", .type = "u64" },
            .{ .name = "result", .type = "[*]i32" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_memset_",
        .signature = "fn([*]u8, u8, u64) void",
        .params = &[_]Param{
            .{ .name = "s", .type = "[*]u8" },
            .{ .name = "c", .type = "u8" },
            .{ .name = "n", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_invoke_signed_c",
        .signature = "fn([*]const u8, [*]const u8, u64, [*]const u8, u64) u64",
        .params = &[_]Param{
            .{ .name = "instruction_addr", .type = "[*]const u8" },
            .{ .name = "account_infos_addr", .type = "[*]const u8" },
            .{ .name = "account_infos_len", .type = "u64" },
            .{ .name = "signers_seeds_addr", .type = "[*]const u8" },
            .{ .name = "signers_seeds_len", .type = "u64" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_invoke_signed_rust",
        .signature = "fn([*]const u8, [*]const u8, u64, [*]const u8, u64) u64",
        .params = &[_]Param{
            .{ .name = "instruction_addr", .type = "[*]const u8" },
            .{ .name = "account_infos_addr", .type = "[*]const u8" },
            .{ .name = "account_infos_len", .type = "u64" },
            .{ .name = "signers_seeds_addr", .type = "[*]const u8" },
            .{ .name = "signers_seeds_len", .type = "u64" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_set_return_data",
        .signature = "fn([*]const u8, u64) void",
        .params = &[_]Param{
            .{ .name = "data", .type = "[*]const u8" },
            .{ .name = "length", .type = "u64" },
        },
        .return_type = null,
    },
    .{
        .name = "sol_get_return_data",
        .signature = "fn([*]u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "data", .type = "[*]u8" },
            .{ .name = "length", .type = "u64" },
            .{ .name = "program_id", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_get_stack_height",
        .signature = "fn() u64",
        .params = &[_]Param{},
        .return_type = "u64",
    },
    .{
        .name = "sol_create_program_address",
        .signature = "fn([*]const u8, u64, [*]const u8, [*]const u8) u64",
        .params = &[_]Param{
            .{ .name = "seeds_addr", .type = "[*]const u8" },
            .{ .name = "seeds_len", .type = "u64" },
            .{ .name = "program_id_addr", .type = "[*]const u8" },
            .{ .name = "address_bytes_addr", .type = "[*]const u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_try_find_program_address",
        .signature = "fn([*]const u8, u64, [*]const u8, [*]const u8, [*]const u8) u64",
        .params = &[_]Param{
            .{ .name = "seeds_addr", .type = "[*]const u8" },
            .{ .name = "seeds_len", .type = "u64" },
            .{ .name = "program_id_addr", .type = "[*]const u8" },
            .{ .name = "address_bytes_addr", .type = "[*]const u8" },
            .{ .name = "bump_seed_addr", .type = "[*]const u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_secp256k1_recover",
        .signature = "fn([*]const u8, u64, [*]const u8, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "hash", .type = "[*]const u8" },
            .{ .name = "recovery_id", .type = "u64" },
            .{ .name = "signature", .type = "[*]const u8" },
            .{ .name = "result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_poseidon",
        .signature = "fn(u64, u64, [*]const u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "parameters", .type = "u64" },
            .{ .name = "endianness", .type = "u64" },
            .{ .name = "vals", .type = "[*]const u8" },
            .{ .name = "val_len", .type = "u64" },
            .{ .name = "hash_result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_remaining_compute_units",
        .signature = "fn() u64",
        .params = &[_]Param{},
        .return_type = "u64",
    },
    .{
        .name = "sol_alt_bn128_group_op",
        .signature = "fn(u64, [*]const u8, u64, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "group_op", .type = "u64" },
            .{ .name = "input", .type = "[*]const u8" },
            .{ .name = "input_size", .type = "u64" },
            .{ .name = "result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_big_mod_exp",
        .signature = "fn([*]const u8, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "params", .type = "[*]const u8" },
            .{ .name = "result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_curve_validate_point",
        .signature = "fn(u64, [*]const u8, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "curve_id", .type = "u64" },
            .{ .name = "point_addr", .type = "[*]const u8" },
            .{ .name = "result", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_curve_group_op",
        .signature = "fn(u64, u64, [*]const u8, [*]const u8, [*]u8) u64",
        .params = &[_]Param{
            .{ .name = "curve_id", .type = "u64" },
            .{ .name = "group_op", .type = "u64" },
            .{ .name = "left_input_addr", .type = "[*]const u8" },
            .{ .name = "right_input_addr", .type = "[*]const u8" },
            .{ .name = "result_point_addr", .type = "[*]u8" },
        },
        .return_type = "u64",
    },
    .{
        .name = "sol_get_sysvar",
        .signature = "fn([*]const u8, [*]u8, u64, u64) u64",
        .params = &[_]Param{
            .{ .name = "sysvar_id_addr", .type = "[*]const u8" },
            .{ .name = "result", .type = "[*]u8" },
            .{ .name = "offset", .type = "u64" },
            .{ .name = "length", .type = "u64" },
        },
        .return_type = "u64",
    },
};
