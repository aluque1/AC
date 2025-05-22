#import "@preview/ilm:1.4.1": *

#set text(lang: "es")

#show: ilm.with(
  title: [Entregable 1 AC],
  author: "Alejandro Luque Villegas",
  date: datetime(year: 2025, month: 05, day: 05),
  abstract: [
    Análisis del procesador de mi portátil donde se explorara la micro-arquitectura con la mayor precisión posible e incidiendo en aquellos aspectos que tengan que ver con ILP y los contenidos dados en la asignatura. El sistema operativo que se esta usando es Arch Linux así que todos los comandos correspondientes serán específicos para este sistema. ],
  figure-index: (enabled: false),
  table-index: (enabled: false),
  listing-index: (enabled: false),
  table-of-contents: none,
  chapter-pagebreak: false,
  bibliography: bibliography("refs.bib"),
)
)

= Identificación del procesador

Para identificar el procesador se ha usado el comando dado en la entrega del ejercicio:
```
 $ lscpu
```

#figure(
  image("proc_info.jpg", width: 90%),
  caption: [
    Salida del comando lscpu de mi maquina.
  ],
)

En la imagen se puede observar información relevante que se comentara mas adelante. Cabe destacar que hay algunas curiosidades que no creo que merezcan mayor exploración pero me gustaría comentar aquí brevemente. Se muestra que tipo de Endianness usa el procesador, en nuestro caso Little Endian. También se muestra el tamaño de direcciones, tanto virtual como física.

= Datos relevantes

- *Nombre del CPU:* Intel Core i7-1165G7 \@ 2.80GHz
- *Cores (núcleos):* 4
- *Threads (hilos):* 8 (Hyper-Threading)
- *CPU(s) disponibles:* 8 (0–7)
- *Familia:* 6
- *Frecuencia base:* 2.80 GHz
- *Frecuencia máxima (turbo):* 4.70 GHz
- *L1d (datos):* 128 KiB (4× 32 KiB)
- *L1i (instrucciones):* 192 KiB (4× 48 KiB)
- *L2:* 5 MiB (4× 1.25 MiB)
- *L3:* 12 MiB (compartido)

Al tener 4 cores y que cada core sea capaz de llevar 2 hilos, las CPUs disponibles son 8, ya que estas son CPUs *lógicas* disponibles.

= Cache

En cuanto a las unidades de memoria caché cabe destacar lo siguiente. La caché de Nivel 1 (L1), con 80 KB por núcleo (48 KB para datos y 32 KB para instrucciones), es la que ofrece un acceso más rápido y cada núcleo tiene su propia caché L1. Esta caché  almacena la información que el núcleo está utilizando de manera más inmediata. La caché de Nivel 2 (L2) de 1.25 MB por núcleo y es más lenta que la L1, pero más rápida que la L3 y actúa como buffer entre la caché L1 y memoria principal. Por último, la caché de Nivel 3 (L3) es un bloque de 12 MB compartido por todos los núcleos del procesador. Su propósito principal es mejorar la coherencia de los datos que comparten los diferentes núcleos y facilitar una comunicación más eficiente entre ellos, optimizando el rendimiento en tareas multihilo. 

== Coherencia

En cuanto a los algoritmos para mantener coherencia, no se ha podido encontrar con exactitud que algoritmo usa esta familia de procesadores, pero se puede asumir que entre las cachés L1 y L2 se utiliza algún algoritmo de snooping. También es posible que se utilice algún mecanismo parecido a MESIF @kanter_csi5 que es una variación del protocolo MESI.

= Interconexión

En cuanto a interconexión, en la familia de TigerLake se utiliza un _dual ring bus_ que conecta los núcleos de la CPU, los gráficos integrados, la caché de último nivel (LLC), el controlador de memoria y el agente del sistema. Cada uno de estos componentes ("agentes") tiene su propia interfaz con el anillo, permitiendo una comunicación eficiente.@intel_gen11_architecture
