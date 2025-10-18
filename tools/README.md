# Syscall Generator Tools

This directory contains tools for generating Solana syscall bindings for Zig.

## Files

- **murmur3.zig** - MurmurHash3-32 implementation (matches Solana's syscall hash function)
- **syscall_defs.zig** - Syscall definitions with signatures
- **gen_syscalls.zig** - Generator that creates `src/syscalls.zig`

## Usage

Generate the syscalls file:

```bash
zig run tools/gen_syscalls.zig -- src/syscalls.zig
```

This creates `src/syscalls.zig` with all Solana syscalls as function pointers.

## How It Works

1. Each syscall name (e.g., `"sol_log_"`) is hashed with MurmurHash3-32 (seed=0)
2. The hash becomes a magic constant (e.g., `0x207559bd`)
3. At runtime, Solana VM resolves these via `call -0x1` instruction

## Testing

Test the MurmurHash implementation:

```bash
cd tools && zig test murmur3.zig
```

This verifies that `"sol_log_"` hashes to `0x207559bd`.

## Adding New Syscalls

To add syscalls, edit `syscall_defs.zig` and add a new entry to the `syscalls` array:

```zig
.{
    .name = "sol_new_syscall",
    .signature = "fn(u64, [*]const u8) u64",
    .params = &[_]Param{
        .{ .name = "arg1", .type = "u64" },
        .{ .name = "arg2", .type = "[*]const u8" },
    },
    .return_type = "u64",
},
```

Then regenerate `src/syscalls.zig`.
