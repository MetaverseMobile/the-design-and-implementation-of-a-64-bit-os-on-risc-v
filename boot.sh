#! /usr/bin/bash

/home/mobb/workspace/qemu/build/qemu-system-riscv64    \
	 -nographic   \
	  -machine virt   \
	   -smp 8     \
	    -m 8G     \
	     -kernel /home/mobb/imgs/Fedora-Minimal-Rawhide-20200108.n.0-fw_payload-uboot-qemu-virt-smode.elf    \
	      -bios none     \
	       -object rng-random,filename=/dev/urandom,id=rng0     \
	        -device virtio-rng-device,rng=rng0     \
		 -device virtio-blk-device,drive=hd0     \
		  -drive file=/home/mobb/imgs/Fedora-Minimal-Rawhide-20200108.n.0-sda.raw,format=raw,id=hd0     \
		   -device virtio-net-device,netdev=usernet  \
		    -fsdev local,security_model=passthrough,id=fsdev-fs0,path=/tmp   \
		     -netdev user,id=usernet,hostfwd=tcp::10000-:22
