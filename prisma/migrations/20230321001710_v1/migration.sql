-- CreateTable
CREATE TABLE "TB_USUARIO" (
    "ID_USUARIO" SERIAL NOT NULL,
    "NM_USUARIO" VARCHAR(128) NOT NULL,
    "EM_USUARIO" VARCHAR(128) NOT NULL,
    "CN_USUARIO" VARCHAR(16) NOT NULL,
    "SN_USUARIO" VARCHAR(32) NOT NULL,
    "PH_USUARIO" VARCHAR(128),
    "DH_USUARIO_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DH_USUARIO_ATUALIZACAO" TIMESTAMP(3) NOT NULL,
    "DH_USUARIO_VERIFICACAO" TIMESTAMP(3),
    "DH_USUARIO_INATIVACAO" TIMESTAMP(3),

    CONSTRAINT "TB_USUARIO_pkey" PRIMARY KEY ("ID_USUARIO")
);

-- CreateTable
CREATE TABLE "TB_CLIENTE" (
    "ID_CLIENTE" SERIAL NOT NULL,
    "NM_CLIENTE" VARCHAR(128) NOT NULL,
    "CN_CLIENTE" VARCHAR(16) NOT NULL,
    "DT_CLIENTE_NASCIMENTO" DATE NOT NULL,
    "ID_BARBEARIA" INTEGER NOT NULL,
    "DH_CLIENTE_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TB_CLIENTE_pkey" PRIMARY KEY ("ID_CLIENTE")
);

-- CreateTable
CREATE TABLE "TB_FUNCIONARIO" (
    "ID_FUNCIONARIO" SERIAL NOT NULL,
    "NM_FUNCIONARIO" VARCHAR(128) NOT NULL,
    "CD_FUNCIONARIO_ACESSO" CHAR(6) NOT NULL,
    "SN_FUNCIONARIO_ACESSO" VARCHAR(32) NOT NULL,
    "ID_BARBEARIA" INTEGER NOT NULL,
    "DH_FUNCIONARIO_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DH_FUNCIONARIO_ATUALIZACAO" TIMESTAMP(3) NOT NULL,
    "DH_FUNCIONARIO_INATIVACAO" TIMESTAMP(3),

    CONSTRAINT "TB_FUNCIONARIO_pkey" PRIMARY KEY ("ID_FUNCIONARIO")
);

-- CreateTable
CREATE TABLE "TB_BARBEARIA" (
    "ID_BARBEARIA" SERIAL NOT NULL,
    "NM_BARBEARIA" VARCHAR(128) NOT NULL,
    "DC_BARBEARIA" VARCHAR(256) NOT NULL,
    "PH_BARBEARIA" VARCHAR(128),
    "ID_USUARIO" INTEGER NOT NULL,
    "DH_BARBEARIA_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DH_BARBEARIA_ATUALIZACAO" TIMESTAMP(3) NOT NULL,
    "DH_BARBEARIA_INATIVACAO" TIMESTAMP(3),

    CONSTRAINT "TB_BARBEARIA_pkey" PRIMARY KEY ("ID_BARBEARIA")
);

-- CreateTable
CREATE TABLE "TB_CATEGORIA" (
    "ID_CATEGORIA" SERIAL NOT NULL,
    "NM_CATEGORIA" VARCHAR(32) NOT NULL,
    "PH_CATEGORIA" VARCHAR(128) NOT NULL,
    "ID_BARBEARIA" INTEGER NOT NULL,
    "DH_CATEGORIA_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DH_CATEGORIA_ATUALIZACAO" TIMESTAMP(3) NOT NULL,
    "DH_CATEGORIA_INATIVACAO" TIMESTAMP(3),

    CONSTRAINT "TB_CATEGORIA_pkey" PRIMARY KEY ("ID_CATEGORIA")
);

-- CreateTable
CREATE TABLE "TB_SERVICO" (
    "ID_SERVICO" SERIAL NOT NULL,
    "VL_SERVICO" DECIMAL(10,2) NOT NULL,
    "NM_SERVICO" VARCHAR(128) NOT NULL,
    "DC_SERVICO" VARCHAR(256) NOT NULL,
    "PH_SERVICO" VARCHAR(128),
    "ID_CATEGORIA" INTEGER NOT NULL,
    "ID_BARBEARIA" INTEGER NOT NULL,
    "DH_SERVICO_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "DH_SERVICO_ATUALIZACAO" TIMESTAMP(3) NOT NULL,
    "DH_SERVICO_INATIVACAO" TIMESTAMP(3),

    CONSTRAINT "TB_SERVICO_pkey" PRIMARY KEY ("ID_SERVICO")
);

-- CreateTable
CREATE TABLE "TB_ATENDIMENTO" (
    "ID_ATENDIMENTO" SERIAL NOT NULL,
    "NM_ATENDIMENTO" VARCHAR(128) NOT NULL,
    "DC_ATENDIMENTO" VARCHAR(256) NOT NULL,
    "ID_BARBEARIA" INTEGER NOT NULL,
    "ID_FUNCIONARIO" INTEGER NOT NULL,
    "ID_CLIENTE" INTEGER NOT NULL,
    "DH_ATENDIMENTO_CRIACAO" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TB_ATENDIMENTO_pkey" PRIMARY KEY ("ID_ATENDIMENTO")
);

-- CreateTable
CREATE TABLE "_AttentionToService" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "TB_CLIENTE_CN_CLIENTE_ID_BARBEARIA_key" ON "TB_CLIENTE"("CN_CLIENTE", "ID_BARBEARIA");

-- CreateIndex
CREATE UNIQUE INDEX "TB_BARBEARIA_ID_USUARIO_key" ON "TB_BARBEARIA"("ID_USUARIO");

-- CreateIndex
CREATE UNIQUE INDEX "_AttentionToService_AB_unique" ON "_AttentionToService"("A", "B");

-- CreateIndex
CREATE INDEX "_AttentionToService_B_index" ON "_AttentionToService"("B");

-- AddForeignKey
ALTER TABLE "TB_CLIENTE" ADD CONSTRAINT "TB_CLIENTE_ID_BARBEARIA_fkey" FOREIGN KEY ("ID_BARBEARIA") REFERENCES "TB_BARBEARIA"("ID_BARBEARIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_FUNCIONARIO" ADD CONSTRAINT "TB_FUNCIONARIO_ID_BARBEARIA_fkey" FOREIGN KEY ("ID_BARBEARIA") REFERENCES "TB_BARBEARIA"("ID_BARBEARIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_BARBEARIA" ADD CONSTRAINT "TB_BARBEARIA_ID_USUARIO_fkey" FOREIGN KEY ("ID_USUARIO") REFERENCES "TB_USUARIO"("ID_USUARIO") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_CATEGORIA" ADD CONSTRAINT "TB_CATEGORIA_ID_BARBEARIA_fkey" FOREIGN KEY ("ID_BARBEARIA") REFERENCES "TB_BARBEARIA"("ID_BARBEARIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_SERVICO" ADD CONSTRAINT "TB_SERVICO_ID_CATEGORIA_fkey" FOREIGN KEY ("ID_CATEGORIA") REFERENCES "TB_CATEGORIA"("ID_CATEGORIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_SERVICO" ADD CONSTRAINT "TB_SERVICO_ID_BARBEARIA_fkey" FOREIGN KEY ("ID_BARBEARIA") REFERENCES "TB_BARBEARIA"("ID_BARBEARIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_ATENDIMENTO" ADD CONSTRAINT "TB_ATENDIMENTO_ID_BARBEARIA_fkey" FOREIGN KEY ("ID_BARBEARIA") REFERENCES "TB_BARBEARIA"("ID_BARBEARIA") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_ATENDIMENTO" ADD CONSTRAINT "TB_ATENDIMENTO_ID_FUNCIONARIO_fkey" FOREIGN KEY ("ID_FUNCIONARIO") REFERENCES "TB_FUNCIONARIO"("ID_FUNCIONARIO") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TB_ATENDIMENTO" ADD CONSTRAINT "TB_ATENDIMENTO_ID_CLIENTE_fkey" FOREIGN KEY ("ID_CLIENTE") REFERENCES "TB_CLIENTE"("ID_CLIENTE") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AttentionToService" ADD CONSTRAINT "_AttentionToService_A_fkey" FOREIGN KEY ("A") REFERENCES "TB_ATENDIMENTO"("ID_ATENDIMENTO") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AttentionToService" ADD CONSTRAINT "_AttentionToService_B_fkey" FOREIGN KEY ("B") REFERENCES "TB_SERVICO"("ID_SERVICO") ON DELETE CASCADE ON UPDATE CASCADE;
