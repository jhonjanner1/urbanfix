-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-07-2025 a las 09:55:51
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
-- Estructura de tabla para la tabla `archivos_reporte`
--

CREATE TABLE `archivos_reporte` (
  `id` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `nombre_archivo` varchar(255) DEFAULT NULL,
  `ruta_archivo` varchar(500) DEFAULT NULL,
  `tipo_archivo` varchar(50) DEFAULT NULL,
  `fecha_subida` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_comentario` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_estado_reporte`
--

CREATE TABLE `historial_estado_reporte` (
  `id` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `fecha_cambio` datetime DEFAULT current_timestamp(),
  `observacion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `juntas_accion_comunal`
--

CREATE TABLE `juntas_accion_comunal` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `juntas_accion_comunal`
--

INSERT INTO `juntas_accion_comunal` (`id`, `nombre`, `localidad`, `direccion`, `telefono`, `correo`) VALUES
(1, 'Junta Acción Comunal Centro', 'Centro', 'Calle 10 #5-20', '3101234567', 'centro@jacbogota.gov.co'),
(2, 'Junta Acción Comunal Norte', 'Norte', 'Carrera 15 #30-40', '3102345678', 'norte@jacbogota.gov.co'),
(3, 'Junta Acción Comunal Sur', 'Sur', 'Avenida 1 #50-60', '3103456789', 'sur@jacbogota.gov.co'),
(4, 'Junta Acción Comunal Chapinero', 'Chapinero', 'Calle 59 #12-34', '3104567890', 'chapinero@jacbogota.gov.co'),
(5, 'Junta Acción Comunal Suba', 'Suba', 'Carrera 90 #140-22', '3105678901', 'suba@jacbogota.gov.co'),
(6, 'Junta Acción Comunal Usaquén', 'Usaquén', 'Avenida 15 #120-15', '3106789012', 'usaquen@jacbogota.gov.co'),
(7, 'Junta Acción Comunal Kennedy', 'Kennedy', 'Calle 44 #80-10', '3107890123', 'kennedy@jacbogota.gov.co'),
(8, 'Junta Acción Comunal Teusaquillo', 'Teusaquillo', 'Carrera 24 #45-20', '3108901234', 'teusaquillo@jacbogota.gov.co'),
(9, 'Junta Acción Comunal Fontibón', 'Fontibón', 'Avenida 68 #100-33', '3109012345', 'fontibon@jacbogota.gov.co'),
(10, 'Junta Acción Comunal Engativá', 'Engativá', 'Calle 80 #70-50', '3110123456', 'engativa@jacbogota.gov.co');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `likes_reporte`
--

CREATE TABLE `likes_reporte` (
  `id` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_like` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mediciones_bache`
--

CREATE TABLE `mediciones_bache` (
  `id` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `tipo_medicion` varchar(100) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `fecha_medicion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int(11) NOT NULL,
  `id_emisor` int(11) NOT NULL,
  `id_receptor` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_tipo_bache` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_reporte` datetime DEFAULT current_timestamp(),
  `ubicacion` varchar(255) NOT NULL,
  `estado` varchar(50) DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_bache`
--

CREATE TABLE `tipos_bache` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `tipo_usuario` enum('jac','ciudadano','admin') NOT NULL DEFAULT 'ciudadano',
  `id_junta_accion_comunal` int(11) DEFAULT NULL,
  `contrasena` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `correo`, `telefono`, `tipo_usuario`, `id_junta_accion_comunal`, `contrasena`) VALUES
(17, 'skibidi', 'skibidi@gmail.com', '12345678', 'ciudadano', NULL, 'hola1234'),
(18, 'holaaaa', 'hola@gmail.com', '1231231132', 'ciudadano', NULL, 'hola12345678');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `archivos_reporte`
--
ALTER TABLE `archivos_reporte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_reporte` (`id_reporte`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `historial_estado_reporte`
--
ALTER TABLE `historial_estado_reporte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `juntas_accion_comunal`
--
ALTER TABLE `juntas_accion_comunal`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `likes_reporte`
--
ALTER TABLE `likes_reporte`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`id_reporte`,`id_usuario`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `mediciones_bache`
--
ALTER TABLE `mediciones_bache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_reporte` (`id_reporte`);

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_emisor` (`id_emisor`),
  ADD KEY `id_receptor` (`id_receptor`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_tipo_bache` (`id_tipo_bache`);

--
-- Indices de la tabla `tipos_bache`
--
ALTER TABLE `tipos_bache`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `id_junta_accion_comunal` (`id_junta_accion_comunal`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `archivos_reporte`
--
ALTER TABLE `archivos_reporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial_estado_reporte`
--
ALTER TABLE `historial_estado_reporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `juntas_accion_comunal`
--
ALTER TABLE `juntas_accion_comunal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `likes_reporte`
--
ALTER TABLE `likes_reporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mediciones_bache`
--
ALTER TABLE `mediciones_bache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipos_bache`
--
ALTER TABLE `tipos_bache`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivos_reporte`
--
ALTER TABLE `archivos_reporte`
  ADD CONSTRAINT `archivos_reporte_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`);

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`),
  ADD CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `historial_estado_reporte`
--
ALTER TABLE `historial_estado_reporte`
  ADD CONSTRAINT `historial_estado_reporte_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`);

--
-- Filtros para la tabla `likes_reporte`
--
ALTER TABLE `likes_reporte`
  ADD CONSTRAINT `likes_reporte_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`),
  ADD CONSTRAINT `likes_reporte_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `mediciones_bache`
--
ALTER TABLE `mediciones_bache`
  ADD CONSTRAINT `mediciones_bache_ibfk_1` FOREIGN KEY (`id_reporte`) REFERENCES `reportes` (`id`);

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `mensajes_ibfk_1` FOREIGN KEY (`id_emisor`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `mensajes_ibfk_2` FOREIGN KEY (`id_receptor`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reportes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `reportes_ibfk_2` FOREIGN KEY (`id_tipo_bache`) REFERENCES `tipos_bache` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_junta_accion_comunal`) REFERENCES `juntas_accion_comunal` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
