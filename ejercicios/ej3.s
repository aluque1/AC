.section .data
x:  .word  0, 1, 1, 0, 1, 0, 0, 1, 0, 1                         # vector x
a:  .float 1.0, 2.0, 3.0, 4.0, 5.0, 5.0, 4.0, 3.0, 2.0, 1.0     # Vector a
b:  .float 5.0, 4.0, 3.0, 2.0, 1.0, 1.0, 2.0, 3.0, 4.0, 5.0     # Vector b
c:  .space 40                                                   # Vector c (10 floats)

    .section .text
    .globl main

main:
    li a0, 10                   # Load the number of elements (10) into a0
    la a1, x                    # Load address of vector x into a1
    la a2, a                    # Load address of vector a into a2
    la a3, b                    # Load address of vector b into a3
    la a4, c                    # Load address of vector c into a4

.addVec2:
    vsetvli     a4, a0, e32, m2 # a4: VL ; a0 = N = ALV; sew = 32; lmul = 2 => a4 = min(vlmax, a0)
    vle32.v     v2, (a0)        # v2-v3 <- x[0]-x[7]
    vmsne.vi    v0, v8, 0       # create mask (1 if x[i] != 0)
    vle32.v     v4, (a1), v0.t  # masked v4-v5 <- a[0]-a[7]
    vle32.v     v6, (a2), v0.t  # masked v6-v7 <- b[0]-b[7]
    sub         a0, a0, a4      # a0 = a0 - a4 => a0 = AVL - VL : 1era iter : 10 - 8
    slli        a4, a4, 2       # a4 = a4 << 2 = a4 = a4 * 4    : 1era iter : 8 * 4 = 32
                                # ver explicacion ej2.s
    add         a1, a1, a4      # a1 = *x[0] + 32 => a1 = *x[8]
    add         a2, a2, a4      # a2 = *a[0] + 32 => a2 = *a[8]
    add         a3, a3, a4      # a3 = *b[0] + 32 => a3 = *b[8]
    vfadd.vv    v6, v6, v4      # v6-v7 = a[0]-a[7] + b[0]-b[7]
    vse32.v     v3, (a3), v0.t  # masked *c[0] <- v3-v4 => 
                                # guardamos en c[0]-c[7] <- a[0]-a[7] + b[0]-b[7]
    add         a4, a4, a4      # a3 = *c[0] + 32 => a3 = *c[8]
    bnez        a0, .addVec     # branch to .addVec if a0 != 0

