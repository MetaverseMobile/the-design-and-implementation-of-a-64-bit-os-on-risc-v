.equ UART_BASE,         0x10000000
.equ UART_REG_TXFIFO,   0

.equ NAN_MACRO,		0xfff8000000000000

.section .text
.globl _start


_start:
# =========================== halt all other hart except hart0 ===========================
        csrr	t0, mhartid			# read hardware thread id (`hart` stands for `hardware thread`)
        bnez	t0, halt			# run only on the first hardware thread (hartid == 0), halt all the other threads

# ===========================       prepare for stack          ===========================
        la	sp, stack_top			# setup stack pointer

# ===========================     output message of 'boot'     ===========================
        la	a0, msg				# load address of `msg` to a0 argument register

        li	t0, UART_BASE			# t0 = UART_BASE
1:
	lbu	t1, (a0)			# t1 = load unsigned byte from memory address specified by a0 register
	beqz	t1, halt
						# wait until UART is ready
2:
	lw	t2, UART_REG_TXFIFO(t0)		# t2 = uart[UART_REG_TXFIFO]
        bltz	t2, 2b				# t2 becomes positive once UART is ready for transmission
        sw	t1, UART_REG_TXFIFO(t0)		# send byte, uart[UART_REG_TXFIFO] = t1

        addi  	a0, a0, 1			# increment a0 address by 1 byte
        jal     x0, 1b

halt:   jal	x0, halt			# enter the infinite loop

.section .rodata
msg:
     .string "boot"
