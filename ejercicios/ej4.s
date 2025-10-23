;int min(int * vec, int len){
;   if(len <= 0) return -1 
;   int min = vec[0];
;}
;
; Suponemos que la direccion de memoria en la que reside la componente vec[0]
; esta en reg a0
;
; Tambien supongo que el vector esta formado por len componentes y el valor de 
; len reside en el reg a1
;
; Asimismo supongo que en a2, que councide con vec[0], esta almacenado un num
; lo suficientemente grande de manera que el resto de las componentes del vec
; sean menores que dicho num

; No sabemos el tamaño entonces la agrupacion da "más igual"

li a3, 0                                ; escribir 0 en a3, a3 = i
vsetvli a4, zero, e32, m2, ta, ma       ; a4 = vlmax = (128/32) * 2 = 8
vmv.v.x v8, a2                          ; copy scalar (a2) in all elements of v8-v9
addi a1, a1, -1                         ; a1 = a1 - 1 = len - 1

.loop:
vsetvli a2, a1, e32, m2, ta, ma         ; 
