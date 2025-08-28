# Cat-Pedia (Prueba Técnica Flutter)

Cat-Pedia es una aplicación móvil desarrollada con Flutter que permite a los usuarios explorar diferentes razas de gatos, ver sus fotos y guardar sus favoritas. La app consume datos de [TheCatAPI](https://thecatapi.com/) y presenta la información en una interfaz moderna y fluida.

## 🎥 Video de la App en Funcionamiento

El siguiente video muestra el flujo completo de la aplicación, desde la pantalla de inicio (splash screen) hasta la navegación, búsqueda por razas, visualización de imágenes y gestión de favoritos.

[![Demostración de la App][https://firebasestorage.googleapis.com/v0/b/o-clan.firebasestorage.app/o/Screenshot_1.png?alt=media&token=9622d9a6-45da-48fa-b72c-a3469b103b83](https://firebasestorage.googleapis.com/v0/b/o-clan.firebasestorage.app/o/Screen_recording_20250828_005047.webm?alt=media&token=4ef70449-8abc-49c7-bbdb-1d39d4d1bca9)

*(Haz clic en la imagen para ver el video)*

## ✨ Funcionalidades Principales

* **Splash Screen Animado:** La aplicación inicia con una atractiva animación Lottie para una bienvenida más dinámica.
* **Exploración tipo TikTok:** La pantalla principal muestra las imágenes de los gatos en un carrusel vertical a pantalla completa, similar a la experiencia de TikTok.
* **Búsqueda por Raza:** Un menú desplegable permite seleccionar una raza específica para ver sus imágenes e información detallada.
* **Información Detallada:** Cada tarjeta de gato muestra su nombre, origen, descripción, esperanza de vida e inteligencia.
* **Ajustes Personalizables:**
    * **Límite de Imágenes:** El usuario puede configurar cuántas imágenes cargar por raza (de 10 a 100).
    * **Modo de Visualización:** Se puede elegir entre una vista a pantalla completa (`cover`) o una vista centrada con fondo desenfocado (`contain with blur`), similar a las historias de Instagram.
* **Gestión de Favoritos:**
    * Los usuarios pueden marcar sus gatos preferidos con un ícono de corazón.
    * Los favoritos se guardan localmente en el dispositivo, persistiendo incluso después de cerrar la app.
* **Sección de Favoritos:** Una segunda pantalla, accesible desde el menú inferior, muestra todos los gatos guardados.

## 🏗️ Arquitectura del Proyecto

Para garantizar un código limpio, desacoplado y escalable, se implementó una arquitectura por capas inspirada en **MVVM (Model-View-ViewModel)**.

![Diagrama de Arquitectura](https://firebasestorage.googleapis.com/v0/b/o-clan.firebasestorage.app/o/Imagen%20de%20WhatsApp%202025-08-28%20a%20las%2000.48.23_b2adf92c.jpg?alt=media&token=0a2bb5d5-fd9b-4bab-8676-54d82c749660)

* **Model:** Contiene las clases de datos (`CatBreed`, `CatImage`) que estructuran la información obtenida de la API.
* **Data (Datos):**
    * **Services:** Clases responsables de obtener datos de fuentes externas.
        * `CatApiService`: Gestiona todas las llamadas HTTP a TheCatAPI.
        * `FavoritesService`: Administra el guardado y la lectura de los favoritos en el almacenamiento local (`SharedPreferences`).
* **Presentation (UI + Lógica de Vista):**
    * **Providers (ViewModels):** Actúan como el "cerebro" de cada pantalla, manejando el estado y la lógica de negocio. Se utiliza el paquete `Provider` para la gestión de estado.
        * `HomeProvider`: Maneja el estado de la pantalla principal (lista de razas, imágenes actuales, estado de carga).
        * `FavoritesProvider`: Gestiona la lista de gatos favoritos.
        * `SettingsProvider`: Administra y persiste las configuraciones del usuario.
    * **Screens (Vistas):** Son los widgets que componen la interfaz de usuario, responsables únicamente de mostrar los datos que les proporcionan los *Providers*.
    * **Widgets:** Componentes reutilizables de la UI, como la tarjeta de información de cada gato (`CardCatWidget`).

Esta separación de responsabilidades asegura que la UI no se mezcle con la lógica de negocio, y la lógica de negocio no sepa de dónde vienen los datos, haciendo el código más fácil de mantener y probar.

## 🛠️ Flujo de Trabajo y Control de Versiones (GitFlow)

El desarrollo del proyecto siguió el modelo de **GitFlow**. Este enfoque utiliza ramas específicas para distintas funcionalidades y etapas del desarrollo, lo que permite un trabajo organizado y colaborativo.

![Modelo de Ramas GitFlow](https://firebasestorage.googleapis.com/v0/b/o-clan.firebasestorage.app/o/Imagen%20de%20WhatsApp%202025-08-28%20a%20las%2000.46.13_31f8cba1.jpg?alt=media&token=45d2a9ff-2e0d-40ab-91ce-cba52deabbac)

* **`main` (o `master`):** Contiene el código de producción estable.
* **`develop`:** Es la rama principal de desarrollo, donde se integran todas las funcionalidades completadas.
* **Ramas de `feature` (Ej: `feature/favorites`, `feature/settings`):** Cada nueva funcionalidad se desarrolla en su propia rama a partir de `develop`. Una vez terminada y probada, se fusiona de nuevo en `develop`.

Este flujo de trabajo garantiza que la rama `main` siempre esté en un estado desplegable y permite desarrollar múltiples funcionalidades en paralelo sin conflictos.

---

Este README proporciona una visión completa de la aplicación, su funcionamiento, la arquitectura subyacente y las metodologías de desarrollo empleadas.