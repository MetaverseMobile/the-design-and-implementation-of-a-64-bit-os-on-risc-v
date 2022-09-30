#! /usr/bin/bash

../toolchain/bin/riscv64-unknown-elf-gcc -march=rv64g -mabi=lp64 -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -Tboot.ld  -o boot -g3 ./boot.S
