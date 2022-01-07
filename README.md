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

Usado en este caso para poder reproducir las URL previws entregadas por la API SPOTIFY, estas funcionan en background y con el movil bloqueado.
PLUS A AGREGAR: En estos casos trabajar con ISOLATES, puede ayudar mucho en el performance, por falta de tiempo no lo he implementado.

## GetIt e Inyector

Utilizados para registrar dependencias e hacer inyeccion de estas, a traves de logica con singleton, la implementacion de esta la he planteado por entornos, dado que en diferentes proyectos se puede querer hacer cambios modulares, ejmeplo: Pasar de usar Google a revisar MapBox por temas de costos, simplemente en una rama creamos ese ambiente y probamos, si para el dia de salida a tienda no tenemos aun completa la implementacion de Mapbox, solo se cambia al ambiente release y listo, esto normalmente se maneja por ramasde git, pero si varios devs trabajaran sobre ese nuevo modulo, no es bueno que todos trabajen sobre una misma linea de ramas.

## Animationes

se implementaron animaciones teniendo como principio Transform, Transition, AnimanionSize, Animations Opacity y demas widget nativos del Frameword.

## Firebase

Se usa este servicio de google en la nube para login con Google, Facebook y correo mas contraseña, registro de igual modo.

# SPOTIFY APP

 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/7.jpeg?alt=media&token=c37b3308-9263-47a9-a426-f12d2c79e142" width="250"> |
 

 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/8.jpeg?alt=media&token=e698dd94-7903-4bd7-8f52-67b8e469562b" width="250"> |


|  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/5.jpeg?alt=media&token=6ffa2606-9144-44c9-a47e-4050b363e451" width="250"> |


 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/1.jpeg?alt=media&token=77922232-8449-4794-96e0-7849c01d2cad" width="250"> |
 

|  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/2.jpeg?alt=media&token=4deb147c-bd73-424d-af63-1711d4ae0a01" width="250"> |


 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/4.jpeg?alt=media&token=ca6cd30a-c2cc-4483-ad4a-0723d8c01597" width="250"> |
 


|  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/6.jpeg?alt=media&token=48073908-94fe-4780-863b-4e974bbeac61" width="250"> |


 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/3.jpeg?alt=media&token=d288799b-d526-4abd-8b52-52c845efc5f4" width="250"> |

# Flutter

Escojo flutter como Framework para trabajar, dada su fácil integración, velocidad de compilación y rápido aprendizaje, la forma de programar en este permite que los devs puedan entender y simplificar muchas cosas que en otros Framework y lenguaje será más complejo, el solo hecho de controlar estados de forma global es un ejemplo de esto, la calidad de los apps desarrolladas en este se sienten como nativas, dado que uno de los PROS de flutter es su compilación a nativo, su core como lenguaje (dart), esta muy bien estructurado, realmente considero que Flutter y Dart tienen mucho por entregar por ello en el tiempo que ya tienen cada vez logramos ver mejores ofertas y más evolución en el Framework, ya tenemos soporte mínimo para web y desktop, y una de las promesas de Google es poder incluirlo en TV, y vehículos.
