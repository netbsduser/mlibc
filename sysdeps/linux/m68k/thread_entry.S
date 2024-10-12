.section .text
.global __mlibc_spawn_thread
.type __mlibc_spawn_thread, "function"
__mlibc_spawn_thread:
	// __mlibc_spawn_thread(flags, stack, pid_out, child_tid, tls)
	//                       (sp), 4(sp),   8(sp),    12(sp), 16(sp)
	//           syscall(NR_clone, flags, stack, ptid, ctid, tls)
	//                         d0,    d1,    d2,   d3,   d4,  d5

	movem.l %d2-%d5, -(%sp)

	move.l #120, %d0
	movem.l 20(%sp), %d1-%d5
	addi.l #0x7048, %d5
	trap #0

	tst.l %d0
	beq .child

	movem.l (%sp)+,%d2-%d5
	rts

.child:
	jbsr __mlibc_enter_thread@PLTPC
	illegal

.section .note.GNU-stack,"",%progbits

