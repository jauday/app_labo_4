# SpotyLand - Simulación Spotify App

Aplicación móvil desarrollada en Flutter que simula las funcionalidades básicas de Spotify, 
conectándose a una API REST en Node.js.

## 📋 Información de Entrega

- **Materia:** TUP - Laboratorio 4
- **Docente:** Sebastian Gañan (sganan81@gmail.com)
- **Fecha límite:** 10 de Febrero de 2025

---

## 🚀 Requisitos Previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.3.0
- [Visual Studio Code](https://code.visualstudio.com/) o Android Studio
- [Git](https://git-scm.com/)
- API Node.js del primer práctico ejecutándose

---

## ⚙️ Instalación

1. **Clonar el repositorio:**
```bash
git clone <url-del-repositorio>
cd flutter_labo_4
```

2. **Configurar variables de entorno:**
```bash
# Crear archivo .env en la raíz del proyecto
cp .env.example .env
```

3. **Editar el archivo `.env`:**
```env
# Para emulador Android:
API_URL=http://10.0.2.2:3000/api

# Para dispositivo físico (usar IP de tu PC):
API_URL=http://192.168.x.x:3000/api

# Para Chrome/Web:
API_URL=http://localhost:3000/api
```

4. **Instalar dependencias:**
```bash
flutter pub get
```

5. **Ejecutar la aplicación:**
```bash
flutter run
```

---

## 📁 Estructura del Proyecto

```
lib/
├── helpers/
│   └── preferences.dart        # SharedPreferences para persistencia
├── mocks/
│   ├── albums_mock.dart        # Datos mock de álbumes
│   ├── artistas_mock.dart      # Datos mock de artistas
│   ├── canciones_mock.dart     # Datos mock de canciones
│   └── playlist_mock.dart      # Datos mock de playlists
├── providers/
│   └── theme_provider.dart     # Provider para manejo de temas
├── screens/
│   ├── album.dart              # Modelo de datos Album (quicktype.io)
│   ├── albumsService.dart      # Servicio HTTP para álbumes
│   ├── albums_screen.dart      # Pantalla listado de álbumes
│   ├── albums_screen_item.dart # Pantalla detalle de álbum
│   ├── cancion.dart            # Modelo de datos Canción (quicktype.io)
│   ├── cancionesService.dart   # Servicio HTTP para canciones
│   ├── canciones_screen.dart   # Pantalla listado de canciones
│   ├── canciones_screen_item.dart # Pantalla detalle de canción
│   ├── playlist.dart           # Modelo de datos Playlist (quicktype.io)
│   ├── playlistService.dart    # Servicio HTTP para playlists
│   ├── screen_playlists.dart   # Pantalla listado de playlists
│   ├── playlist_item_card.dart # Pantalla detalle de playlist
│   ├── artistas_screen.dart    # Pantalla listado de artistas
│   ├── artistas_screen_item.dart # Pantalla detalle de artista
│   ├── configuracion_screen.dart # Pantalla de configuración
│   ├── home_screen.dart        # Pantalla principal con reproductor
│   └── screens.dart            # Exports centralizados
├── services/
│   └── AudioPlayerService.dart # Servicio de reproducción de audio
├── themes/
│   └── default_theme.dart      # Temas claro y oscuro
├── widgets/
│   └── drawer_menu.dart        # Menú lateral de navegación
└── main.dart                   # Punto de entrada de la aplicación
```

---

## ✅ Widgets y Requisitos Implementados

| Requisito | Implementación | Ubicación |
|-----------|---------------|-----------|
| **FutureBuilder** | Carga asíncrona de datos desde API | `albums_screen.dart` (línea 24), `canciones_screen.dart`, `screen_playlists.dart` |
| **Provider** | Manejo de estado para temas | `theme_provider.dart`, usado en `main.dart` |
| **Modelos quicktype.io** | Clases de datos con fromJson/toJson | `album.dart`, `cancion.dart`, `playlist.dart` |
| **Variables de entorno** | Configuración de API_URL | `.env` + `flutter_dotenv` en `main.dart` |
| **Peticiones HTTP** | Consumo de API REST | `albumsService.dart`, `cancionesService.dart`, `playlistService.dart` |
| **SharedPreferences** | Persistencia de preferencias | `preferences.dart` (darkmode, nombre, email, teléfono) |

---

## 🔗 Conexión con API Node.js

La aplicación consume los siguientes endpoints de la API:

| Endpoint | Descripción | Servicio Flutter |
|----------|-------------|------------------|
| `GET /api/albumes` | Obtener todos los álbumes | `AlbumsService.fetchAlbumes()` |
| `GET /api/albumes/:id` | Obtener álbum por ID | `AlbumsService.fetchAlbumById()` |
| `GET /api/canciones` | Obtener todas las canciones | `CancionesService.fetchCanciones()` |
| `GET /api/playlists` | Obtener todas las playlists | `PlaylistService.fetchPlaylists()` |

### Configuración de red para emulador Android

Si usas emulador Android, la IP `10.0.2.2` redirecciona al `localhost` de tu PC.

```env
API_URL=http://10.0.2.2:3000/api
```

---

## 🎨 Funcionalidades

- **Home:** Reproductor de música con controles de play/pause
- **Álbumes:** Listado y detalle de álbumes desde API
- **Canciones:** Listado y detalle de canciones desde API
- **Playlists:** Listado y detalle de playlists desde API
- **Artistas:** Listado y detalle de artistas (datos locales)
- **Configuración:** Cambio de tema (claro/oscuro) y datos de usuario
- **Persistencia:** Las preferencias se guardan con SharedPreferences

---

## 📱 Capturas de Pantalla

### Pantalla Home
![home_example](https://github.com/user-attachments/assets/eb4b8ae0-6f20-4c5f-9709-6f9f42cf1280)

### Menú de Navegación
![home_menu_example](https://github.com/user-attachments/assets/f09a3cff-6e22-4774-a712-eeac93fc1bd2)

---

## 🛠️ Dependencias Principales

```yaml
dependencies:
  flutter_dotenv: ^5.2.1    # Variables de entorno
  provider: ^6.1.2          # Manejo de estado
  shared_preferences: ^2.3.2 # Persistencia local
  http: ^1.2.2              # Peticiones HTTP
  audioplayers: ^6.1.0      # Reproducción de audio
```

---

## 📝 Notas Importantes

1. El archivo `.env` NO está incluido en el repositorio por seguridad
2. Crear el archivo `.env` basándose en `.env.example`
3. La API Node.js debe estar ejecutándose antes de iniciar la app
4. Para pruebas en Chrome: usar `http://localhost:3000/api`

---

## 👤 Autor

Desarrollado para la materia Laboratorio 4 - TUP
