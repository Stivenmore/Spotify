# SPOTIFY

Linkeding [@stivenmore](https://www.linkedin.com/in/stiven-morelo-barahona-61a9a11a5/)

## Patron Bloc y Clean Architecture

Utilizando el patron bloc para el planteamiento de la logica de la aplicacion, subdividiendo responsabilidades y creando entidades abstractas que controlan las peticiones a traves de consumo de servicios inyectados por dependencias, mientras que clean architecture entre sus grandes bondades nos entrega una forma clara de organizacion de proyectos e inyeccion de dependencias, entre otras bondades.

## Push Notification

Se realiza la implementacion de esta por medio del Messaging proporcionado por Firebase, estas notificaciones quedan atadas a la consola de Firebase, aun asi su implementacion esta completa.

PLUS A AGREGAR: Se pueden personalizar mucho mas si usamos paquetes como local_notification.

## Manejo de Estado

Para el control de la informacion en la aplicacion se emplea provider dada su rapida integración, tambien teniendo en cuenta que segun recomendaciones del equipo developer de Google que llevan Flutter, es una de las mejores opciones para APP con este tamaño e impacto.

## Shared Preference

Utilizado para guardar token y preferencias de usuario, entre estas poder alterar la app entre CO y AU.

## Exoplayer

Usado en este caso para poder reproducir las URL previws entregadas por la API SPOTIFY
PLUS A AGREGAR: En estos casos trabajar con ISOLATES, puede ayudar mucho en el performance, por falta de tiempo no lo he implementado.

## GetIt e Inyector

Utilizados para registrar dependencias e hacer inyeccion de estas, a traves de logica con singleton, la implementacion de esta la he planteado por entornos, dado que en diferentes proyectos se puede querer hacer cambios modulares, ejmeplo: Pasar de usar Google a revisar MapBox por temas de costos, simplemente en una rama creamos ese ambiente y probamos, si para el dia de salida a tienda no tenemos aun completa la implementacion de Mapbox, solo se cambia al ambiente release y listo, esto normalmente se maneja por ramasde git, pero si varios devs trabajaran sobre ese nuevo modulo, no es bueno que todos trabajen sobre una misma linea de ramas.

## Animationes

se implementaron animaciones teniendo como principio Transform, Transition, AnimanionSize, Animations Opacity y demas widget nativos del Frameword.

# Muestras de la app
![Screenshot](1.jpeg)
