import 'package:flutter/material.dart';

import 'models.dart';

// =====================================================================
// AUTOPROTECCIÓN Y SEGURIDAD
// =====================================================================
const seguridad = Category(
  id: 'seguridad',
  name: 'Autoprotección y seguridad',
  icon: Icons.shield_outlined,
  summary: 'Estar alerta, casa segura, moverse sin riesgo, calmar conflictos, defensa personal y protección del cuerpo.',
  articles: [
    Article('seg_alerta', 'Estar alerta sin vivir con miedo', r'''
La mejor pelea es la que no ocurre. Casi siempre se evita viendo el peligro a tiempo.

## Los 4 estados de alerta
- Blanco: distraído (celular, audífonos). Evítalo en la calle.
- Amarillo: tranquilo pero atento. Es el estado normal fuera de casa.
- Naranja: algo raro (alguien te sigue, un grupo te mira). Piensa: ¿por dónde salgo?
- Rojo: peligro real. Actúa: aléjate, corre, pide ayuda.

## Hábitos
- Al entrar a un lugar, ubica dos salidas.
- Mira a la gente a las manos: el peligro está en lo que hacen, no en lo que dicen.
- Confía en tu intuición: si algo se siente mal, vete sin dar explicaciones.
- No muestres comida, dinero, baterías ni medicinas. Quien sabe que tienes, viene por ello.
- Pasa desapercibido: ropa sencilla, sin lujos, sin contar tus planes.
- De noche, luz solo la necesaria y tapada hacia afuera: una luz se ve a kilómetros.
* No publiques en redes dónde estás, qué tienes ni cuándo sales de casa.
'''),
    Article('seg_casa', 'Hacer tu casa más segura', r'''
## Lo básico
- Puertas sólidas con buena cerradura y una tranca o barra por dentro.
- Ventanas con rejas o, al menos, algo que haga ruido si las abren (latas colgadas).
- Luz o ruido de movimiento alrededor: un perro avisa mejor que cualquier alarma.
- Conoce a tus vecinos: una cuadra organizada se cuida sola (turnos de guardia, silbatos).

## Provisiones
- No guardes todo en un solo lugar: reparte en 2–3 escondites.
- Ten una "reserva para entregar" visible y pequeña; la principal, oculta.

## Cuarto seguro
- Elige un cuarto interior con puerta fuerte: agua, linterna, radio, botiquín y una forma de pedir ayuda.
- Si entran a robar y tú estás adentro: enciérrate, haz ruido, pide ayuda. Las cosas se reponen, tú no.

## Otros peligros en casa
- Detector de humo y un extintor o balde con arena cerca de la cocina.
- Revisa que el gas no tenga fugas (agua con jabón en las uniones: si hace burbujas, hay fuga).
- Nunca cocines ni uses planta eléctrica dentro de un cuarto cerrado: el monóxido mata sin olor.
'''),
    Article('seg_moverse', 'Moverse con seguridad', r'''
## Antes de salir
- Di a alguien a dónde vas, por qué ruta y a qué hora vuelves. Si no vuelves, sabrán dónde buscar.
- Lleva agua, linterna, silbato, celular cargado y algo de comer.
- Ve de día y en grupo de 3 o más cuando la situación esté difícil.

## En el camino
- Evita multitudes, filas de saqueo, puestos de control desconocidos y calles sin salida.
- Camina por el centro de la acera, lejos de puertas y esquinas oscuras.
- Si te siguen: cruza la calle, cambia de ritmo, entra a un lugar con gente. No vayas directo a casa.
- En grupo: uno adelante mira, uno atrás vigila, y todos conocen la señal para huir y el punto de reencuentro.

## En vehículo
- Puertas con seguro y ventanas arriba en semáforos.
- Deja espacio con el carro de adelante para poder salir.
- Tanque sobre la mitad siempre.
'''),
    Article('seg_conflicto', 'Calmar un conflicto (desescalar)', r'''
La mayoría de peleas empiezan por orgullo. Quien se calma primero gana.

## Cómo
- Distancia: al menos dos brazos. Cuerpo de lado, manos abiertas y visibles a la altura del pecho.
- Voz baja y lenta. Frases cortas: "Tranquilo", "No quiero problemas", "Te entiendo".
- No insultes, no te burles, no señales con el dedo, no lo toques.
- Escucha y repite lo que pide: la gente se calma cuando se siente escuchada.
- Dale una salida digna: "Ya está, cada uno sigue su camino".
- Si el grupo tiene un problema interno, que hable una sola persona por lado y con un tercero tranquilo.

## Si es un robo
! Entrega lo que pidan. Ningún celular, comida o dinero vale tu vida. Haz movimientos lentos y avisa antes de moverte ("voy a sacar la billetera").
- Mira detalles para después (ropa, tatuajes, hacia dónde se van), sin quedarte mirando la cara.
'''),
    Article('seg_defensa', 'Defensa personal básica: para escapar', r'''
El objetivo NO es ganar: es soltarte y huir hacia un lugar con gente.

## Postura
- Pies separados, uno adelante, rodillas un poco dobladas.
- Manos arriba, abiertas, frente a la cara (parece que pides calma, pero proteges tu cabeza).

## Si te agarran
- De la muñeca: gira el brazo hacia el pulgar de quien te agarra (el punto más débil) y jala con fuerza.
- Por detrás: baja el cuerpo, golpea con el talón el empeine o la espinilla, y empuja para soltarte.
- Del cuello: mete la barbilla, levanta los hombros y jala sus manos hacia abajo con todo tu peso.

## Si no hay otra salida
- Golpea fuerte y rápido a zonas que dan tiempo para escapar: ojos, nariz, entrepierna, rodilla.
- Grita "¡AYUDA!" o "¡FUEGO!": la gente reacciona más rápido.
- Apenas te sueltes: corre. No te quedes a pelear.
* Practica estos movimientos despacio con alguien de confianza. Bajo estrés, solo sale lo que ya practicaste.
! Las armas en manos sin entrenamiento suelen terminar usadas contra quien las lleva. Escapar casi siempre es mejor.
'''),
    Article('seg_cuerpo', 'Proteger tu cuerpo: humo, sol, insectos y escombros', r'''
## Respirar
- Humo, ceniza volcánica o polvo de escombros: mascarilla N95 bien ajustada a la nariz.
- Sin N95: tela húmeda doblada sobre nariz y boca (ayuda poco, pero algo).
- Gas o químicos: aléjate en dirección contraria al viento y hacia lo alto.

## Ojos, manos y pies
- Gafas (de sol o de natación) contra polvo, ceniza y astillas.
- Guantes de trabajo para escombros, vidrios y leña.
- Botas o zapatos cerrados siempre: una cortada en el pie puede incapacitarte días.
- Casco o gorra gruesa al entrar en edificios dañados.

## Sol y calor
- Sombra entre 11 a. m. y 3 p. m.; sombrero de ala ancha y manga larga clara.
- Bebe agua aunque no tengas sed. Orina oscura = falta agua.

## Insectos
- Mosquitero en la cama, ropa larga al atardecer y repelente.
- Vacía todo recipiente con agua quieta: ahí nacen los zancudos del dengue.

## Frío y lluvia
- Capas de ropa; lo de afuera, impermeable. Gorro y medias secas.
'''),
    Article('seg_vulnerables', 'Cuidar a niños, mayores y personas vulnerables', r'''
## Niños
- Que se sepan su nombre completo, el de sus padres y un número de teléfono. Escríbelo también en un papel dentro de la ropa.
- Punto de encuentro acordado si se pierden: "Si nos separamos, vamos a la iglesia" (o un lugar fijo).
- Palabra clave familiar: si alguien dice que lo mandaste a recogerlos y no sabe la palabra, no se van.
- Nunca solos en albergues, filas ni baños.

## Mayores y personas con discapacidad
- Lista de sus medicinas, dosis y enfermedades (usa la Ficha médica de la app).
- Quién se encarga de cada persona en una evacuación.
- Bastón, gafas, audífonos y cargadores en la mochila de emergencia.

## En albergues y campamentos
- Dormir en grupos familiares, nunca aislado.
- Baños y letrinas con luz, cerca y separados para mujeres y hombres.
- Ir acompañado al baño de noche.
! Si alguien sufre acoso o abuso, créele, ponlo a salvo y avisa a quien organiza el albergue o a las autoridades.
'''),
  ],
  quiz: [
    Question('Fuera de casa, el estado de alerta normal debe ser:', ['Blanco (distraído)', 'Amarillo (tranquilo pero atento)', 'Rojo siempre', 'No importa'], 1,
        'Atento sin vivir asustado: así ves el peligro a tiempo.'),
    Question('Si te roban con un arma, lo mejor es:', ['Pelear', 'Entregar lo que piden con movimientos lentos', 'Correr hacia el ladrón', 'Gritarle'], 1,
        'Las cosas se reponen; tu vida no.'),
    Question('En defensa personal el objetivo es:', ['Ganar la pelea', 'Soltarte y huir', 'Castigar al agresor', 'Quitarle el arma'], 1,
        'Escapar hacia un lugar con gente es lo más seguro.'),
    Question('Para que un niño no se vaya con un extraño, sirve:', ['Una palabra clave familiar', 'Darle dulces', 'Nada', 'Dejarlo solo'], 0,
        'Si quien lo recoge no sabe la palabra clave, no se va.'),
  ],
);
