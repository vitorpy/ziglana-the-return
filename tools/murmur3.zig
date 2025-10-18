const std = @import("std");

/// MurmurHash3-32 implementation matching Solana's syscall hash function
/// Based on: https://github.com/anza-xyz/solana-sdk/blob/master/define-syscall/src/lib.rs
pub fn murmur3_32(buf: []const u8, seed: u32) u32 {
    const pre_mix = struct {
        fn f(bytes: [4]u8) u32 {
            const val = std.mem.readInt(u32, &bytes, .little);
            return std.math.rotl(u32, val *% 0xcc9e2d51, 15) *% 0x1b873593;
        }
    }.f;

    var hash = seed;
    var i: usize = 0;

    // Process 4-byte chunks
    while (i < buf.len / 4) : (i += 1) {
        const chunk = [4]u8{
            buf[i * 4],
            buf[i * 4 + 1],
            buf[i * 4 + 2],
            buf[i * 4 + 3],
        };
        hash ^= pre_mix(chunk);
        hash = std.math.rotl(u32, hash, 13);
        hash = hash *% 5 +% 0xe6546b64;
    }

    // Process remaining bytes
    const remainder = buf.len % 4;
    if (remainder > 0) {
        var final_chunk = [4]u8{ 0, 0, 0, 0 };
        for (0..remainder) |j| {
            final_chunk[j] = buf[i * 4 + j];
        }
        hash ^= pre_mix(final_chunk);
    }

    // Finalization
    hash ^= @as(u32, @intCast(buf.len));
    hash ^= hash >> 16;
    hash *%= 0x85ebca6b;
    hash ^= hash >> 13;
    hash *%= 0xc2b2ae35;
    hash ^= hash >> 16;

    return hash;
}

/// Compute syscall hash (wrapper for clarity)
pub fn syscallHash(name: []const u8) u32 {
    return murmur3_32(name, 0);
}

test "murmur3_32 matches known syscall hashes" {
    const testing = std.testing;

    // Known hash from Solana: sol_log_ -> 0x207559bd
    const sol_log_hash = syscallHash("sol_log_");
    try testing.expectEqual(@as(u32, 0x207559bd), sol_log_hash);

    // Verify a few more known syscalls
    const sol_log_64_hash = syscallHash("sol_log_64_");
    const sol_sha256_hash = syscallHash("sol_sha256");
    const sol_keccak256_hash = syscallHash("sol_keccak256");

    // These should all be non-zero and distinct
    try testing.expect(sol_log_64_hash != 0);
    try testing.expect(sol_sha256_hash != 0);
    try testing.expect(sol_keccak256_hash != 0);
    try testing.expect(sol_log_hash != sol_log_64_hash);
    try testing.expect(sol_log_hash != sol_sha256_hash);
}
