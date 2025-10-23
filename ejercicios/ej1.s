    .text
    .balign 4
    .global ej1

# void ld_stride(){
#   int j = 1;
#   float A[16][64]
#   
#   for(i = 0; i < 16; ++i){
#       A[i,j] = (A[i,j - 1] + 3*A[i,j] + A[i, j+1]) / 5
#   }

# La idea es cargar con un load las componentes verticales de A[i, j]
# En una arquitectura vect de VLEN = 128, caben 4 elems de 32b en cada 
# reg vect. Como tenemos que calcular 16 elems de A una opcion eficiente 
# es agrupar los regs vect de 4 en 4 -> LMUL = 4

# Suponemos que *A[0,0], *A[0,1], *A[0,2] estan almacenados en los regs
# x2, x3 y x4 respectivamente

# Las constantes estan almacenadas en los regs f0 = 3.0, f1 = 5.0

# El desplazamiento entre 2 elementos de la misma columna en filas consecutivas
# es el tamaño en butes de una fila: 64x4 = 256. suponemos que este valor
# esta almacenado en x1 -> el stride para ir de columna en columna

# El codigo es sin bucles porque como ya hemos visto nos caben en los registros
# vectoriales que tenemos

vsetvli x0, 16, e32, m4 ; SEW = 32 ; LMUL = 4; AVL 0 16 -> VL = 16
vlse32.v v0, (x3), x1   ; leo de A[0, 1]-A[15, 1] y guardo en v0-v3 (A[i,j])
vlse32.v v4, (x2), x1   ; leo de A[0, 0]-A[15, 0] y guardo en v4-v7 (A[i, j-1])
vfmul.vf v0, v0, f0     ; mult A[0, 1]-A[15, 1] * 3
vfadd.vv v4, v0, v4     ; add A[0, 0]-A[15,0] + 3*(A[0,1]-A[0,15])
vlse32.v v8, (x4), x1   ; leo de A[0, 2]-A[15, 2] y guardo en v8-v11 (A[i,j+1])
vfadd.vv v8, v8, v4
vfdiv.vf v8, v8, f1 
vsse32.v v8, (x3), x1
