# Mojo Test
This repo is to test out Mojo in a `devcontainer` based on the laatest installation instructions from https://docs.modular.com/mojo/manual/get-started/.

# What works?

## Running `magic init ...`
Required adding `tzdata`

## Running `mojo main.mojo`
Required adding `build-essential`

## Running `mojo build main.mojo && ./main`
Same as above

## Running `mojo test test_combiner.mojo`
Required adding `libedit2`, `zlib1g-dev`, `libtinfo-dev`

# What doesn't?

## Stack dump with symbol names
Installing via Magic doesn't set `LLVM_SYMBOLIZER_PATH`

### TODO
Discover where the Magic installer places `llvm_symbolizer` and add the following to `Dockerfile`:
```
export LLVM_SYMBOLIZER_PATH=<path to llvm_symbolizer>
```

## API documentation tests
Followed https://docs.modular.com/mojo/tools/testing#writing-api-documentation-tests and the test in `combiner.mojo` is found, but it fails to even run

### Repro Steps
> Open devcontainer

> Run `magic shell`

> Run `mojo test`

### Results
Expected: 2 tests passed

Actual: 1 passed, 1 failed

### Full Error
```text
error: Failed to launch `mojo-repl-entry-point` process: 
error: Failed to launch `mojo-repl-entry-point` process: 
[1612:1612:20250121,191934.428706:ERROR elf_dynamic_array_reader.h:64] tag not found
[1650:1650:20250121,191934.428782:ERROR elf_dynamic_array_reader.h:64] tag not found
[1612:1612:20250121,191934.431215:ERROR file_io_posix.cc:144] open /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: No such file or directory (2)
[1612:1612:20250121,191934.431228:ERROR file_io_posix.cc:144] open /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: No such file or directory (2)
[1650:1650:20250121,191934.431369:ERROR file_io_posix.cc:144] open /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq: No such file or directory (2)
[1650:1650:20250121,191934.431383:ERROR file_io_posix.cc:144] open /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq: No such file or directory (2)
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.      Program arguments: /workspaces/mojo_test/.magic/envs/default/lib/mojo-test-executor - /tmp/test-entrypoint-83a955 -I /workspaces/mojo_test
1.      Program arguments: /workspaces/mojo_test/.magic/envs/default/lib/mojo-test-executor - /tmp/test-entrypoint-83a955 -I /workspaces/mojo_test
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace.
Stack dump:
0.      Program arguments: /workspaces/mojo_test/.magic/envs/default/lib/mojo-test-executor - /tmp/test-entrypoint-83a955 -I /workspaces/mojo_test
1.      Program arguments: /workspaces/mojo_test/.magic/envs/default/lib/mojo-test-executor - /tmp/test-entrypoint-83a955 -I /workspaces/mojo_test
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  mojo-test-executor 0x0000aaaac5cc3014
1  mojo-test-executor 0x0000aaaac5cc117c
2  mojo-test-executor 0x0000aaaac5cc370c
3  linux-vdso.so.1    0x0000ffff809817a0 __kernel_rt_sigreturn + 0
4  libMojoJupyter.so  0x0000ffff808b56bc
5  libMojoJupyter.so  0x0000ffff808b2610 M::Mojo::Jupyter::MojoKernel::~MojoKernel() + 32
6  mojo-test-executor 0x0000aaaac59734c8
7  mojo-test-executor 0x0000aaaac596f76c
8  libc.so.6          0x0000ffff732684c4
9  libc.so.6          0x0000ffff73268598 __libc_start_main + 152
10 mojo-test-executor 0x0000aaaac596eff0
mojo-test-executor crashed!
Please file a bug report.
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  mojo-test-executor 0x0000aaaad3663014
1  mojo-test-executor 0x0000aaaad366117c
2  mojo-test-executor 0x0000aaaad366370c
3  linux-vdso.so.1    0x0000ffffad2c27a0 __kernel_rt_sigreturn + 0
4  libstdc++.so.6     0x0000ffff9fb13358 std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>::_M_assign(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> const&) + 36
5  mojo-test-executor 0x0000aaaad332b794
6  mojo-test-executor 0x0000aaaad3315308
7  mojo-test-executor 0x0000aaaad3313070
8  mojo-test-executor 0x0000aaaad330f76c
9  libc.so.6          0x0000ffff9fc684c4
10 libc.so.6          0x0000ffff9fc68598 __libc_start_main + 152
11 mojo-test-executor 0x0000aaaad330eff0
mojo-test-executor crashed!
Please file a bug report.
Testing Time: 0.179s

Total Discovered Tests: 2

Passed : 1 (50.00%)
Failed : 1 (50.00%)
Skipped: 0 (0.00%)

******************** Failure: '/workspaces/mojo_test/combiner.mojo@Combiner.combine(combiner\3A\3ACombiner,\3A\3AInt).__doc__::0' ********************

failed to initialize test executor kernel
********************
```