# Aplicación de Gestión de Usuarios

## 📋 Descripción del Proyecto

Esta es una **Aplicación de Gestión de Usuarios** desarrollada con Flutter. La app permite a los usuarios crear, editar, eliminar y listar perfiles de usuarios con detalles como nombre, fecha de nacimiento y direcciones. Proporciona una interfaz limpia e intuitiva para gestionar datos de usuarios, siguiendo las mejores prácticas de diseño de software.

---

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework para desarrollar aplicaciones multiplataforma.
- **Dart**: Lenguaje de programación utilizado con Flutter.
- **Hive**: Base de datos NoSQL ligera y rápida para Flutter.
- **Bloc/Cubit**: Librería de gestión de estado para manejar el estado de la aplicación de manera eficiente.
- **Intl**: Librería para formateo de fechas e internacionalización.
- **Clean Architecture**: Garantiza la separación de responsabilidades y facilita el mantenimiento del código.

---

## 🏗️ Arquitectura

La aplicación está estructurada utilizando los principios de **Arquitectura Limpia**. Esto divide el código en capas distintas para mejorar el mantenimiento y las pruebas:

1. **Capa de Dominio (Domain)**:
   - Contiene la lógica central de negocio.
   - Incluye `Entidades`, `Repositorios (Interfaces)` y `Casos de Uso`.

2. **Capa de Datos (Data)**:
   - Administra las fuentes de datos (Hive, APIs, etc.).
   - Incluye `Modelos`, `Implementaciones de Repositorios` y `Fuentes de Datos`.

3. **Capa de Presentación (Presentation)**:
   - Administra la interfaz de usuario y la gestión de estado.
   - Incluye `Widgets`, `Pantallas` y `Cubit/Bloc`.

4. **Core**:
   - Contiene utilidades compartidas, como formato y diálogos comunes.

---

## ⚙️ Tener en cuenta se debe usar el comando antes de usar la aplicacion
flutter pub run build_runner build
