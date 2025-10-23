    .section .data
a:  .float 1.0, 2.0, 3.0, 4.0, 5.0, 5.0, 4.0, 3.0, 2.0, 1.0     # Vector a
b:  .float 5.0, 4.0, 3.0, 2.0, 1.0, 1.0, 2.0, 3.0, 4.0, 5.0     # Vector b
c:  .space 40                                                   # Vector c (10 floats)

    .section .text
    .globl main

main:
    li a0, 10                   # Load the number of elements (10) into a0
    la a1, a                    # Load address of vector a into a1
    la a2, b                    # Load address of vector b into a2
    la a3, c                    # Load address of vector c into a3

.addVec:
    vsetvli     a4, a0, e32, m2 # a4: VL ; a0 = N = ALV; sew = 32; lmul = 2 => a4 = min(vlmax, a0)
    vle32.v     v1, (a1)        # v1-v2 <- a[0]-a[7]
    vle32.v     v3, (a2)        # v3-v4 <- b[0]-b[7]
    sub         a0, a0, a4      # a0 = a0 - a4 => a0 = AVL - VL : 1era iter : 10 - 8
    slli        a4, a4, 2       # a4 = a4 << 2 = a4 = a4 * 4    : 1era iter : 8 * 4 = 32
                                # un float son 4 bytes. Para incrementar puntero en 8 elems
                                # de 4 bytes => 8 * 4. En ASM si queremos incrementar el puntero
                                # en i elementos hay que hacer i * x donde x es el tam del dato
                                # en bytes 
    add         a1, a1, a4      # a1 = *a[0] + 32 => a1 = *a[8]
    add         a2, a2, a4      # a2 = *b[0] + 32 => a2 = *b[8]
    vfadd.vv    v3, v3, v1      # v3-v4 = a[0]-a[7] + b[0]-b[7]
    vse32.v     v3, (a3)        # *c[0] <- v3-v4 => guardamos en c[0]-c[7] <- a[0]-a[7] + b[0]-b[7]
    add         a3, a3, a4      # a3 = *c[0] + 32 => a3 = *c[8]
    bnez        a0, .addVec     # branch to .addVec if a0 != 0

