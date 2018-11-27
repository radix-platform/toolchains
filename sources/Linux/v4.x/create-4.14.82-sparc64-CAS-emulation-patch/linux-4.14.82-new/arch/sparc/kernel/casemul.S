#include <asm/asi.h>
#include <asm/thread_info.h>
#include <asm/trap_block.h>
#include <asm/ptrace.h>
#include <asm/head.h>

	.text
	.align	128
	.globl	emulate_cas
	.type	emulate_cas,#function
emulate_cas: 
	casa	[%o0] ASI_AIUP, %o1, %o2
	done 
	nop; nop; nop; nop; nop; nop;
	nop; nop; nop; nop; nop; nop; nop; nop
	nop; nop; nop; nop; nop; nop; nop; nop
	nop; nop; nop; nop; nop;
	ba,a,pt	%xcc, 3f
	ba,a,pt	%xcc, 2f
	ba,a,pt	%xcc, 1f
	.size	emulate_cas,.-emulate_cas

	/* Fault */
1:	TRAP_LOAD_THREAD_REG(%g6, %g1)
	stb	%g4, [%g6 + TI_FAULT_CODE]
	stx	%g5, [%g6 + TI_FAULT_ADDR]
	ba,pt	%xcc, etrap
	rd	%pc, %g7
	call	do_sparc64_fault
	add	%sp, PTREGS_OFF, %o0
	ba,a,pt	%xcc, rtrap

	/* Memory address unaligned */
2:	ba,pt	%xcc, etrap
	rd	%pc, %g7
	sethi	%hi(tlb_type), %g1
	lduw	[%g1 + %lo(tlb_type)], %g1
	cmp	%g1, 3
	bne,pt	%icc, 1f
	add	%sp, PTREGS_OFF, %o0
	mov	%l4, %o2
	call	sun4v_do_mna
	mov	%l5, %o1
	ba,a,pt	%xcc, rtrap
1:	mov	%l4, %o1
	mov	%l5, %o2
	call	mem_address_unaligned
	nop
	ba,a,pt	%xcc, rtrap

	/* Data access exception */
3:	ba,pt	%xcc, etrap
	rd	%pc, %g7
	sethi	%hi(tlb_type), %g1
	mov	%l4, %o1
	lduw	[%g1 + %lo(tlb_type)], %g1
	mov	%l5, %o2
	cmp	%g1, 3
	bne,pt	%icc, 1f
	add	%sp, PTREGS_OFF, %o0
	call	sun4v_data_access_exception
	nop
	ba,a,pt	%xcc, rtrap
1:	call	spitfire_data_access_exception
	nop
	ba,a,pt	%xcc, rtrap
