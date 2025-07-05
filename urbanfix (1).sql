-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-07-2025 a las 08:58:05
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `urbanfix`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivos_adjuntos`
--

CREATE TABLE `archivos_adjuntos` (
  `id_archivo` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `url_archivo` varchar(255) NOT NULL,
  `tipo_archivo` varchar(20) DEFAULT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `barrios`
--

CREATE TABLE `barrios` (
  `id_barrio` int(11) NOT NULL,
  `id_localidad` int(11) NOT NULL,
  `nombre_barrio` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias_danio`
--

CREATE TABLE `categorias_danio` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `contenido` text NOT NULL,
  `fecha_comentario` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadisticas_reporte`
--

CREATE TABLE `estadisticas_reporte` (
  `id_estadistica` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `veces_visto` int(11) DEFAULT 0,
  `veces_comentado` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `junta_accion_comunal`
--

CREATE TABLE `junta_accion_comunal` (
  `id_junta` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `junta_accion_comunal`
--

INSERT INTO `junta_accion_comunal` (`id_junta`, `nombre`, `localidad`, `direccion`, `telefono`, `correo`) VALUES
(1, 'Junta Los Pinos', 'Localidad 1', 'Calle 45 # 23-10', '3101234567', 'junta.lospinos@example.com'),
(2, 'Junta La Esperanza', 'Localidad 2', 'Carrera 15 # 40-20', '3112345678', 'laesperanza@example.com'),
(3, 'Junta El Porvenir', 'Localidad 3', 'Calle 12 # 7-50', '3123456789', 'elporvenir@example.com'),
(4, 'Junta San Miguel', 'Localidad 1', 'Carrera 9 # 30-15', '3134567890', 'sanmiguel@example.com'),
(5, 'Junta Villa Nueva', 'Localidad 4', 'Calle 22 # 18-40', '3145678901', 'villanueva@example.com'),
(6, 'Junta La Paz', 'Localidad 3', 'Carrera 27 # 50-33', '3156789012', 'lapaz@example.com'),
(7, 'Junta Nueva Esperanza', 'Localidad 2', 'Calle 3 # 5-60', '3167890123', 'nuevaesperanza@example.com'),
(8, 'Junta El Recuerdo', 'Localidad 4', 'Carrera 11 # 44-22', '3178901234', 'elrecuerdo@example.com'),
(9, 'Junta San Rafael', 'Localidad 1', 'Calle 18 # 29-10', '3189012345', 'sanrafael@example.com'),
(10, 'Junta Buenavista', 'Localidad 3', 'Carrera 7 # 15-70', '3190123456', 'buenavista@example.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `id_localidad` int(11) NOT NULL,
  `nombre_localidad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id_notificacion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id_permiso` int(11) NOT NULL,
  `nombre_permiso` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `latitud` decimal(10,7) NOT NULL,
  `longitud` decimal(10,7) NOT NULL,
  `estado` enum('pendiente','en_proceso','resuelto') DEFAULT 'pendiente',
  `fecha_reporte` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario`
--

CREATE TABLE `rol_usuario` (
  `id_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

CREATE TABLE `seguimiento` (
  `id_seguimiento` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado_anterior` enum('pendiente','en_proceso','resuelto') DEFAULT NULL,
  `estado_nuevo` enum('pendiente','en_proceso','resuelto') DEFAULT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `endpoint` text NOT NULL,
  `p256dh` text NOT NULL,
  `auth` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `endpoint`, `p256dh`, `auth`, `created_at`) VALUES
(1, NULL, 'https://fcm.googleapis.com/fcm/send/fFQt0fpiVtk:APA91bGEcCCXMpCecSCyEh1tuD37jb3jmWZ35_dWmMmUJd_Lnbq7lyb5ugl78YcrbRqTTjVETeCICkIabsVvLDSG12ntDtneQcOJxQqNUGEuUdbk7aCU_igeAjVbY6cU9Dqek8WachSt', 'BCFu1GLVryVVUKnkLuLwY32tgNb4t9Q29iiFJNo8wJk6n0MVIURLv8Xoutc4iYL_Oah0_CEjHebFAWH0XRtF9gM', '8-TTJdATXqPIqSY99tdzkw', '2025-07-05 06:34:52'),
(2, NULL, 'https://fcm.googleapis.com/fcm/send/fFQt0fpiVtk:APA91bGEcCCXMpCecSCyEh1tuD37jb3jmWZ35_dWmMmUJd_Lnbq7lyb5ugl78YcrbRqTTjVETeCICkIabsVvLDSG12ntDtneQcOJxQqNUGEuUdbk7aCU_igeAjVbY6cU9Dqek8WachSt', 'BCFu1GLVryVVUKnkLuLwY32tgNb4t9Q29iiFJNo8wJk6n0MVIURLv8Xoutc4iYL_Oah0_CEjHebFAWH0XRtF9gM', '8-TTJdATXqPIqSY99tdzkw', '2025-07-05 06:42:08'),
(3, NULL, 'https://fcm.googleapis.com/fcm/send/dAd6AZB24x4:APA91bG0Fyyhg2y0RBOZt0NiKqPmPgkZSfEqkUM0ucJf-i_8AQduReQ1RKKvTczvQPAcu2ooCth75S4FqtD1_obliFYfSFgZX34bvFkX9uNzHDMGkZb-XPc1TsnOiRanBqqDDrGyjC3-', 'BOrANKHmx5UOyA8mJvfkS-g4Z9bB3gsAACJA_fxeRNPQw5GtOYMgO-LklHMT2ZdIfTgORk3O60U86dKiHKzFd6Q', '4G00WhgPs5BrWpqiySZc_g', '2025-07-05 06:55:53'),
(4, NULL, 'https://fcm.googleapis.com/fcm/send/dAd6AZB24x4:APA91bG0Fyyhg2y0RBOZt0NiKqPmPgkZSfEqkUM0ucJf-i_8AQduReQ1RKKvTczvQPAcu2ooCth75S4FqtD1_obliFYfSFgZX34bvFkX9uNzHDMGkZb-XPc1TsnOiRanBqqDDrGyjC3-', 'BOrANKHmx5UOyA8mJvfkS-g4Z9bB3gsAACJA_fxeRNPQw5GtOYMgO-LklHMT2ZdIfTgORk3O60U86dKiHKzFd6Q', '4G00WhgPs5BrWpqiySZc_g', '2025-07-05 06:55:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `tipo_usuario` enum('ciudadano','jac','admin') NOT NULL DEFAULT 'ciudadano',
  `id_junta` int(11) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `endpoint` text DEFAULT NULL,
  `p256dh` text DEFAULT NULL,
  `auth` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `correo`, `contrasena`, `telefono`, `tipo_usuario`, `id_junta`, `fecha_registro`, `endpoint`, `p256dh`, `auth`) VALUES
(1, 'brazzers', 'brazzers@gmail.com', '12312321', '3112332132', 'ciudadano', NULL, '2025-07-08 05:00:00', NULL, NULL, NULL),
(2, 'braulio', 'baulio@gmail.com', '12312321dsadasds', '133213213', 'jac', 8, '2025-07-08 05:00:00', NULL, NULL, NULL),
(3, 'laura', 'laura@gmail.com', 'laura12345', '12312312', 'ciudadano', NULL, '2012-03-08 05:00:00', NULL, NULL, NULL),
(4, 'amogus', 'amogus@gmail.com', 'amogus', '2131312', 'ciudadano', NULL, '0000-00-00 00:00:00', NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivos_adjuntos`
--
ALTER TABLE `archivos_adjuntos`
  ADD PRIMARY KEY (`id_archivo`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `barrios`
--
ALTER TABLE `barrios`
  ADD PRIMARY KEY (`id_barrio`),
  ADD KEY `id_localidad` (`id_localidad`);

--
-- Indices de la tabla `categorias_danio`
--
ALTER TABLE `categorias_danio`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_reporte` (`id_reporte`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `estadisticas_reporte`
--
ALTER TABLE `estadisticas_reporte`
  ADD PRIMARY KEY (`id_estadistica`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `junta_accion_comunal`
--
ALTER TABLE `junta_accion_comunal`
  ADD PRIMARY KEY (`id_junta`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id_localidad`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id_notificacion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id_permiso`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `rol_usuario`
--
ALTER TABLE `rol_usuario`
  ADD PRIMARY KEY (`id_usuario`,`id_rol`),
  ADD KEY `rol_usuario_ibfk_2` (`id_rol`);

--
-- Indices de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  ADD PRIMARY KEY (`id_seguimiento`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_junta` (`id_junta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `archivos_adjuntos`
--
ALTER TABLE `archivos_adjuntos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `barrios`
--
ALTER TABLE `barrios`
  MODIFY `id_barrio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categorias_danio`
--
ALTER TABLE `categorias_danio`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estadisticas_reporte`
--
ALTER TABLE `estadisticas_reporte`
  MODIFY `id_estadistica` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `junta_accion_comunal`
--
ALTER TABLE `junta_accion_comunal`
  MODIFY `id_junta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id_localidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id_notificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
  MODIFY `id_seguimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivos_adjuntos`
--
ALTER TABLE `archivos_adjuntos`
  ADD CONSTRAINT `archivos_adjuntos_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id_reporte`);

--
-- Filtros para la tabla `barrios`
--
ALTER TABLE `barrios`
  ADD CONSTRAINT `barrios_ibfk_1` FOREIGN KEY (`id_localidad`) REFERENCES `localidades` (`id_localidad`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id_reporte`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `estadisticas_reporte`
--
ALTER TABLE `estadisticas_reporte`
  ADD CONSTRAINT `estadisticas_reporte_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id_reporte`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_danio` (`id_categoria`);

--
-- Filtros para la tabla `rol_usuario`
--
ALTER TABLE `rol_usuario`
  ADD CONSTRAINT `rol_usuario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_junta`) REFERENCES `junta_accion_comunal` (`id_junta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
