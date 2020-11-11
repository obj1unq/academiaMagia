# Guardando cosas en la academia de magia

En una academia de magia siempre hay lío para encontrar las cosas que se guardan, 
tanto es así que han decidido hacer un software que ayude a la administración de los muebles 
y cosas guardadas


## Parte 1:  Muebles y cosas

De las cosas que se pueden guardar interesa conocer el volumen, 
si es un elemento mágico, y si es una reliquia. Todas estas son cosas que se conocen.


La academia tiene varios muebles donde se pueden guardar cosas, para esta primera versión
solamente se utilizarán armarios convencionales, gabinetes mágicos y baules

Se puede guardar una cosa en la academia siempre y cuando haya al menos un mueble donde se pueda guardar:
- Un baúl tiene una capacidad máxima de volumen. La capacidad usada es la suma de los volumenes de todas 
  las cosas guardas en él. Puede guardar un nuevo elemento siempre y cuando la capacidad usada más el volumen
  de la cosa a guardar no superan la capacidad máxima. 
- En un gabinete mágico se puede guardar una cosa cualquier cosa que sea mágica, sin límites
- En un armario convencional se puede guardar una cantidad máxima de elementos 
  (no importa el volumen de las cosas, solo la cantidad)

*IMPORTANTE: Tampoco se puede guardar algo que ya está guardado!*
  
# Escenario de pruebas

Cosas:
-  una pelota de fútbol: tiene 3 de volumen, no es mágica y no es una reliquia
-  una escoba gastada: tiene 4 de volumen, sí es mágica y es una reliquia
-  una varita mágica: tiene 1 de volumen, es mágico y no es una reliquia 
-  la pava de mate del director: tiene 2 de volumen, no es mágica y sí es una reliquia
-  la lampara de aladino: tiene 3 de volumen,  es mágica y  es una reliquia


Muebles:
   La academia tiene un baúl de 5 litros de volumen máximo, adentro tiene solamente la escoba gastada.
   Tiene un gabinete magico donde está guardada la varita mágica
   Tiene un armario convencional con la pelota de fútbol y puede contener hasta 2 elementos en total (incluyendo la pelota) .

Nota: Tener en cuenta que éste es solo un escenario posible. Podría haber otro donde haya por ejemplo, otro baúl más de otra capacidad,
más gabinetes, etc.

# Requerimientos:

1. Saber si una cosa está guardada o no en la academia. 
 
  En este ejemplo la pelota, la escoba y la varita sí están guardados. Mientras que la pava y la lampara no

2. Saber en que mueble está guardada una cosa.
   En este ejemplo la escoba está en el baúl, mientras que la pelota está en el armario y la varita está en el gabinete mágico

3. Saber si una cosa se puede guardar en la academia.
 En este ejemplo la pava se puede guardar ya que entra en el armario.
 Si configuramos el sistema para que el armario tenga solo 1 de capacidad, entonces 
 ya no se puede guardar.
 
 La lámpara tambien se puede guardar,ya que entra tanto en el baúl como en el gabinete mágico
 
 La pelota, la escoba y la varita no se pueden guardar debido a que ya están guardados
 
4. Saber en que muebles se podría guardar una cosa.
  En nuestro caso la pava de mate se puede guardar en el armario, mientras que la lámpara de aladino
  entra tanto en el armario como en el gabinete mágico 
        
5. Guardar algo en la academia: Si la cosa se puede guardar entonces se busca un mueble donde se pueda guardar
y se agrega ahí. Tener en cuenta que si la cosa no cumple con el punto 3 (que no se puede guardar porque no hay mueble
en que entre o porque ya estaba guardada) entonces no se está cumpliendo con la responsabilidad del mensaje!

En nuestro caso la pava se guardaría en el armario, mientras que la lámpara de aladino se guarda en el 
armario o en el gabinete mágico. La escoba, la pava y la varita no se pueden guardar.

Tip: En el test alcanza con verificar que está en la academia usando lo resuelto en el punto 1

## Parte 2:  Utilidad y precio


La utilidad de un mueble es un número que sirve como indicador para saber si un mueble está siendo bien usando o no
Se calcula como la dividisión entre la sumatoria de la utilidad de las cosas que se guardan, sobre
el precio del mueble. La utilidad de una cosa es el volumen más 3 si es mágia más 5 si es reliquia.

El precio de un armario se calcula como 5 por la cantidad que puede albergar
El precio de un baúl se calcula como  el volumen maximo + 1
El precio de un gabinete se define para cada gabinete

La utilidad del baul se calcula levemente distinto que para el resto de los muebles:
Además de la fórmula dada para los muebles, se suma un extra. Ese extra es de 2 si
todas las cosas que almacena son reliquias.

Existen también Baules Mágicos, el cual además de tener un extra de 2 en la utilidad si todas las
cosas que almacena son reliquias, también suma 1 por cada elemento mágico, pero vale el doble que 
un baul no mágico.


#Escenario de prueba.

Al mismo escenario de del punto 1 se le agrega la pava al armario y la lámpara de aladino al gabinete.
El gabinete tiene de precio de 5

Armar por fuera del gabinete un baul mágico de volumen 22, con la lampara de aladino y la escoba mágica.



#Requerimientos
1. Saber la utilidad de un mueble  
	
   La utilidad del armario (que tiene la pelota y la pava) es:  `(3 + 0 + 0) + (2 + 0 + 5) / (5 * 2) = 1`
   La utilidad del gabinete (que tiene la varita y la lampara) es:  `(1 + 3 + 0) + (3 + 3 + 5) / (5) = 3`
   La utilidad del baul (que tiene la escoba) es:  `((4 + 3 + 5)  / (5 + 1)) + 2 = 4`
   La utilidad del baul magico (que tiene la lampara y la escoba) es:  `((3 + 3 + 5) + (4 + 3 + 5) / (2*(22 + 1)) + 2 + 1 + 1 = 4.5`
 
2. Obtener el conjunto de las cosas menos útiles de los muebles de la academia. Es el conjunto que se forma con el elemento
menos útil de cada mueble.

En este caso sería la pelota (del armario), la varita (del gabinete) y la escoba (del baul). Asumir
que todos los muebles tienen al menos un elemento.

3. Remover de la academia aquellos elementos que pertenecen al conjunto de las cosas menos útiles 
(lo resuelto en el punto anterior 2.2) y que además no son mágicas.

Esta accion solo la puede realizar la academia si tiene al menos 3 muebles.

En este caso se debería remover solo la pelota. 

Pero con un escenario en el cual la academia tenga solo el armario y el baul no debería poder realizarse la accion



    


