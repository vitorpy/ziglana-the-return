# Solana BPF Programs with Zig + sbpf-linker

A minimal template for building Solana BPF programs using standard Zig compiler and [sbpf-linker](https://github.com/blueshift-gg/sbpf-linker).

## Features

- ✅ Uses standard Zig BPF target (no custom forks)
- ✅ Zero external dependencies (no SDK needed)
- ✅ LLVM bitcode generation via `-femit-llvm-bc`
- ✅ Direct syscall invocation via function pointers
- ✅ Automated build pipeline with `zig build`
- ✅ Jest-based integration tests with solana-test-validator

## Prerequisites

```bash
# Install sbpf-linker (must be in ../sbpf-linker)
git clone https://github.com/blueshift-gg/sbpf-linker.git ../sbpf-linker
cd ../sbpf-linker && cargo build

# Install Zig 0.15.2 or later
# Install Node.js for testing
```

## Building

```bash
zig build
```

This generates:
1. `entrypoint.bc` - LLVM bitcode from Zig source
2. `zig-out/lib/program_name.so` - Final Solana program

## Testing

```bash
npm install
npm test
```

Tests will:
- Build the program
- Start solana-test-validator
- Deploy the program
- Execute and verify "Hello world!" log output

## How It Works

### 1. Direct Syscalls via Function Pointers

Instead of using extern declarations (which get optimized away), we call Solana syscalls directly:

```zig
const sol_log_ = @as(*align(1) const fn ([*]const u8, u64) void, @ptrFromInt(0x207559bd));
sol_log_(message.ptr, message.len);
```

The magic constant `0x207559bd` is the syscall hash that Solana VM resolves at runtime.

### 2. Inline String Data

To prevent sbpf-linker from stripping .rodata, we inline string data:

```zig
const message = [_]u8{'H','e','l','l','o',' ','w','o','r','l','d','!'};
```

### 3. LLVM Bitcode Pipeline

sbpf-linker is an LTO compiler, not a traditional linker. It needs LLVM IR:

```bash
zig build-lib -target bpfel-freestanding -femit-llvm-bc=entrypoint.bc
sbpf-linker --cpu v3 --export entrypoint -o program.so entrypoint.bc
```

## Project Structure

```
.
├── build.zig           # Automated build pipeline
├── build.zig.zon       # Zero dependencies
├── src/
│   └── entrypoint.zig  # Program entrypoint with inline syscalls
└── test/
    └── program.test.ts # Integration tests
```

## License

MIT
