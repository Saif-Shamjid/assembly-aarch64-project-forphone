.global _start

.section .data
list: .word 4,2
buf: .space 20

.section .text
_start:

        ldr x0, =list
        ldr x1,[x0,#4]

        //print number
        mov x2,x1
        bl printn



        // Exit the program (Linux syscall)
        mov x8, #93
        mov x0, #0            // syscall: exit
        svc #0


// function int to str

int_to_str:
        mov x4, #10 // Base 10
        mov x5, x3
        add x5, x5, #20

        strb wzr, [x5], #-1 //Null-terminate the string

convert_loop:

    udiv x6, x2, x4     // Divide x2 by 10, quotient in x6
    msub x7, x6, x4, x2 // Remainder in x7
    add w7, w7, #'0'   // Convert remainder to ASCII
    strb w7, [x5], #-1 // Store character in buffer
    mov x2, x6          // Update x2 with quotient
    cmp x2, #0          // Check if quotient is zero
    bne convert_loop    // If not zero, continue loop

    ret

// printn function
printn:
        //convert num to str
        //arg: mov x2,x0
        ldr x3,=buf
        bl int_to_str

        //print string sys write
        mov x0, #1
        ldr x1, =buf
        mov x2,#20
        mov x8, #64
        svc #0

        ret

