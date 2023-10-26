-- CreateTable
CREATE TABLE `usuarios` (
    `id` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `celular` VARCHAR(191) NOT NULL,
    `cpf` VARCHAR(191) NOT NULL,
    `grupo` ENUM('ADMINISTRADOR', 'ATENDENTE', 'PRESTADOR', 'PACIENTE') NOT NULL DEFAULT 'PACIENTE',
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `perfil` (
    `id` VARCHAR(191) NOT NULL,
    `usuario_id` VARCHAR(191) NOT NULL,
    `conselho` VARCHAR(191) NULL,
    `uf_conselho` VARCHAR(191) NULL,
    `num_conselho` VARCHAR(191) NULL,
    `foto` VARCHAR(191) NULL,
    `logradouro` VARCHAR(191) NULL,
    `numero` INTEGER NULL,
    `complemento` VARCHAR(191) NULL,
    `bairro` VARCHAR(191) NULL,
    `cidade` VARCHAR(191) NULL,
    `cep` VARCHAR(191) NULL,
    `uf` VARCHAR(191) NULL,

    UNIQUE INDEX `perfil_usuario_id_key`(`usuario_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `expedientes` (
    `id` VARCHAR(191) NOT NULL,
    `prestador_id` VARCHAR(191) NOT NULL,
    `semana` VARCHAR(191) NOT NULL,
    `dataInicio` DATETIME(3) NOT NULL,
    `dataFim` DATETIME(3) NOT NULL,
    `horarioInicio` DATETIME(3) NOT NULL,
    `horarioFim` DATETIME(3) NOT NULL,
    `horarioAlmocoInicio` DATETIME(3) NOT NULL,
    `horarioAlmocoFim` DATETIME(3) NOT NULL,
    `intervalo` INTEGER NOT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `agendas` (
    `id` VARCHAR(191) NOT NULL,
    `expediente_id` VARCHAR(191) NOT NULL,
    `medico_id` VARCHAR(191) NOT NULL,
    `paciente_id` VARCHAR(191) NULL,
    `status` ENUM('LIVRE', 'AGENDADO', 'CANCELADO', 'BLOQUEADO') NULL DEFAULT 'LIVRE',
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prontuario` (
    `id` VARCHAR(191) NOT NULL,
    `medico_id` VARCHAR(191) NOT NULL,
    `paciente_id` VARCHAR(191) NOT NULL,
    `data` DATETIME(3) NOT NULL,
    `queixa` TEXT NULL,
    `historiaMedicamentosa` TEXT NULL,
    `molestiaAtual` TEXT NULL,
    `alergias` TEXT NULL,
    `doencaInfectoContagiosa` TEXT NULL,
    `outrasInformacoes` TEXT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comparecimentos` (
    `id` VARCHAR(191) NOT NULL,
    `prontuario_id` VARCHAR(191) NOT NULL,
    `data` DATETIME(3) NOT NULL,
    `horaInicial` DATETIME(3) NOT NULL,
    `horaFinal` DATETIME(3) NOT NULL,
    `outrasInformacoes` TEXT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `atestados` (
    `id` VARCHAR(191) NOT NULL,
    `prontuario_id` VARCHAR(191) NOT NULL,
    `data` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `quantidadeDias` INTEGER NOT NULL,
    `outrasInformacoes` TEXT NULL,
    `created_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `perfil` ADD CONSTRAINT `perfil_usuario_id_fkey` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `expedientes` ADD CONSTRAINT `expedientes_prestador_id_fkey` FOREIGN KEY (`prestador_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `agendas` ADD CONSTRAINT `agendas_expediente_id_fkey` FOREIGN KEY (`expediente_id`) REFERENCES `expedientes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `agendas` ADD CONSTRAINT `agendas_medico_id_fkey` FOREIGN KEY (`medico_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `agendas` ADD CONSTRAINT `agendas_paciente_id_fkey` FOREIGN KEY (`paciente_id`) REFERENCES `usuarios`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `prontuario` ADD CONSTRAINT `prontuario_medico_id_fkey` FOREIGN KEY (`medico_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `prontuario` ADD CONSTRAINT `prontuario_paciente_id_fkey` FOREIGN KEY (`paciente_id`) REFERENCES `usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `comparecimentos` ADD CONSTRAINT `comparecimentos_prontuario_id_fkey` FOREIGN KEY (`prontuario_id`) REFERENCES `prontuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `atestados` ADD CONSTRAINT `atestados_prontuario_id_fkey` FOREIGN KEY (`prontuario_id`) REFERENCES `prontuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
