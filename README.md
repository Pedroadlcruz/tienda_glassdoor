# 🛍️ Tienda Glassdoor - Flutter Challenge

Una aplicación móvil desarrollada con Flutter que permite gestionar un catálogo de productos, carrito de compras y autenticación de usuarios.

## 📋 Descripción del Proyecto

Esta aplicación fue desarrollada como parte del desafío técnico de Glassdoor, implementando todas las funcionalidades requeridas y los puntos extra opcionales.

## 🎬 Demo en Video

**Vista previa de la aplicación en funcionamiento:**

[![Demo Video](https://img.shields.io/badge/📹-Ver_Demo-00ADD8?style=for-the-badge&logo=loom)](https://www.loom.com/share/9be155c272cc414db5551410f8bb5993?sid=17da5ba8-f770-4045-9bc4-94c08bbd0065)

**Funcionalidades demostradas:**
- 🔐 Autenticación con Google y Email
- 🛍️ Catálogo de productos y navegación
- 🛒 Carrito de compras completo
- 💾 Persistencia de datos con Firebase
- 📱 UX/UI fluida y responsive

*Duración: 3 minutos*

## 🏗️ Arquitectura del Proyecto

El proyecto sigue los principios de **Clean Architecture** y **BLoC Pattern**:

```
lib/
├── core/                    # Configuraciones y utilidades
│   ├── config/             # Configuración de Firebase, Router, Theme
│   ├── extensions/         # Extensiones de Dart
│   ├── services/           # Servicios base (Network)
│   └── widgets/            # Widgets reutilizables
├── features/               # Características de la aplicación
│   ├── auth/              # Autenticación
│   ├── cart/              # Carrito de compras
│   └── products/          # Gestión de productos
└── main.dart              # Punto de entrada
```

### Patrones de Diseño Utilizados:
- **Clean Architecture**: Separación en capas (Data, Domain, Presentation)
- **BLoC Pattern**: Manejo de estado reactivo
- **Repository Pattern**: Abstracción de fuentes de datos
- **Dependency Injection**: Gestión de dependencias con GetIt

## 🚀 Instalación y Configuración

### Prerrequisitos
- Flutter SDK (versión 3.8.1 o superior)
- Dart SDK
- Android Studio / VS Code
- Cuenta de Firebase (para funcionalidades de autenticación y base de datos)

### Pasos de Instalación

1. **Clonar el repositorio**
   ```bash
   git clone [URL_DEL_REPOSITORIO]
   cd tienda_glassdoor
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase** (Opcional - para funcionalidades completas)
   - Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
   - Descargar `google-services.json` (Android) y `GoogleService-Info.plist` (iOS)
   - Colocar archivos en las carpetas correspondientes:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Generar modelos** (si es necesario)
   ```bash
   make model
   ```

5. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

### Comandos Útiles

```bash
# Limpiar y reinstalar dependencias
make clean

# Generar modelos de datos
make model

# Ejecutar tests
flutter test

# Construir APK de release
flutter build apk --release
```

## 📱 Funcionalidades de la Aplicación

### 🔐 Autenticación
- **Login con Google**: Integración con Google Sign-In
- **Registro/Login con Email**: Sistema tradicional de autenticación
- **Persistencia de sesión**: El usuario permanece logueado entre sesiones

### 🛍️ Gestión de Productos
- **Catálogo**: Lista de productos con imágenes y precios
- **Detalles**: Vista completa con descripción, especificaciones y galería
- **Búsqueda**: Filtrado y búsqueda de productos

### 🛒 Carrito de Compras
- **Agregar productos**: Desde la vista de detalles o catálogo
- **Modificar cantidades**: Incrementar/decrementar items
- **Eliminar productos**: Remover items del carrito
- **Persistencia**: Sincronización con Firebase Firestore
- **Cálculo automático**: Total y subtotales actualizados en tiempo real

## 🛠️ Tecnologías Utilizadas

### Frontend
- **Flutter**: Framework principal
- **Dart**: Lenguaje de programación
- **Material Design**: Sistema de diseño

### Backend & Servicios
- **Firebase Authentication**: Autenticación de usuarios
- **Firebase Firestore**: Base de datos NoSQL
- **Google Sign-In**: Autenticación social

### Estado y Arquitectura
- **flutter_bloc**: Manejo de estado
- **get_it**: Inyección de dependencias
- **go_router**: Navegación
- **equatable**: Comparación de objetos

### Utilidades
- **cached_network_image**: Caché de imágenes
- **google_fonts**: Tipografías personalizadas
- **connectivity_plus**: Detección de conectividad
- **json_annotation**: Serialización JSON

## 📊 Estructura de Datos

### Producto
```dart
{
  "id": "string",
  "name": "string",
  "description": "string",
  "price": "double",
  "imageUrl": "string",
  "category": "string"
}
```

### Carrito
```dart
{
  "userId": "string",
  "items": [
    {
      "productId": "string",
      "quantity": "int",
      "product": "Product"
    }
  ]
}
```

```

## 📦 Build y Deploy

### Android
```bash
# APK de debug
flutter build apk

# APK de release
flutter build apk --release

# Bundle de release
flutter build appbundle --release
```

### iOS
```bash
# Build para iOS
flutter build ios --release
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto fue desarrollado como parte del desafío técnico de Glassdoor.

## 👨‍💻 Autor

Desarrollado como prueba técnica para Glassdoor.

---

**Nota**: Esta aplicación demuestra el dominio de Flutter, arquitectura limpia, manejo de estado con BLoC, integración con Firebase y buenas prácticas de desarrollo móvil.
