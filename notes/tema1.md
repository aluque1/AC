# AC - Tema 1

## Evolución y tendencias

### Ley de Moore

la observación de que el número de transistores en un circuito integrado denso se duplica aproximadamente cada dos años.

### Final del escalado de Dennard

Se refiere a la situación en la que la reducción del tamaño de los transistores en los chips ya no conlleva una disminución proporcional en el consumo de energía. Esto se debe a que, a medida que los transistores se hacen más pequeños, la corriente de fuga aumenta, lo que significa que se pierde más energía en forma de calor incluso cuando el transistor está inactivo.

## Rendimiento

MIPS: **M**illones de **I**nstrucciones **P**or **S**egundo
MFLOP/s: **M**illones de **O**peraciones(FP) **P**or **S**egundo

### Rendimiento del procesador

#### Tiempo de exe de un programa

$$ T_CPU = Ciclos * t = \frac{Ciclos}{f} $$

donde: 

$Ciclos$: # total de ciclos de reloj empleados
$t$: período de reloj
$f$: frecuencia de reloj $= \frac{1}{t}$

#### Ciclos promedio por instr

$$CPI = \frac{Ciclos}{NI}$$

donde:

$NI$: # de instr exe

Con las 2 formulas anteriores operamos y sustituimos y obtenemos lo siguiente:

$$T_CPU = NI * CPI * t = NI * \frac{CPI}{f}$$

### Ley de Amdahl

Establece que la mejora en el rendimiento de un sistema debido a una mejora en uno de sus componentes está limitada por la fracción de tiempo que ese componente se utiliza.
