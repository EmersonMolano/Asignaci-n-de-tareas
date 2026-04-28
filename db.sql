CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE usuario (
    usuario_id  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre      VARCHAR(100) NOT NULL,
    email       VARCHAR(150) UNIQUE NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tarea (
    tarea_id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    titulo      VARCHAR(200) NOT NULL,
    descripcion TEXT,
    estado      VARCHAR(50) DEFAULT 'PENDIENTE'
                CHECK (estado IN ('PENDIENTE', 'EN_PROGRESO', 'COMPLETADA', 'CANCELADA')),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuario_tarea (
    usuario_id  UUID NOT NULL,
    tarea_id    UUID NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (usuario_id, tarea_id),
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id)
        REFERENCES usuario(usuario_id) ON DELETE CASCADE,
    CONSTRAINT fk_tarea   FOREIGN KEY (tarea_id)
        REFERENCES tarea(tarea_id) ON DELETE CASCADE
);


-- Insertar usuarios
INSERT INTO usuario VALUES
(gen_random_uuid(), 'Juan Perez',     'juan@email.com',    NOW()),
(gen_random_uuid(), 'Maria Lopez',    'maria@email.com',   NOW()),
(gen_random_uuid(), 'Carlos Mendez',  'carlos@email.com',  NOW()),
(gen_random_uuid(), 'Ana Torres',     'ana@email.com',     NOW());

-- Insertar tareas
INSERT INTO tarea VALUES
(gen_random_uuid(), 'Aprender Docker',    'Estudiar contenedores y orquestación',  'PENDIENTE',    NOW()),
(gen_random_uuid(), 'Crear API REST',     'Desarrollar endpoints del backend',      'EN_PROGRESO',  NOW()),
(gen_random_uuid(), 'Diseñar base datos', 'Modelar esquema relacional',             'COMPLETADA',   NOW()),
(gen_random_uuid(), 'Revisar pruebas',    'Ejecutar suite de tests unitarios',      'PENDIENTE',    NOW());

