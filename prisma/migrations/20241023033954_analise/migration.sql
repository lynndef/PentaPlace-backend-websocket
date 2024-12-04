-- CreateTable
CREATE TABLE "UsuarioCriativo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT,
    "username" TEXT,
    "senha" TEXT,
    "telefone" TEXT,
    "pais" TEXT,
    "estado" TEXT,
    "cidade" TEXT,
    "endereco" TEXT,
    "codigoPostal" TEXT,
    "fotoPerfil" BLOB,
    "banner" BLOB,
    "apelido" TEXT,
    "descricaoCurta" TEXT,
    "descricaoLonga" TEXT,
    "experiencia" INTEGER,
    "disponibilidade" TEXT,
    "colaboradorId" INTEGER,
    "numero" INTEGER,
    "complemento" TEXT,
    CONSTRAINT "UsuarioCriativo_colaboradorId_fkey" FOREIGN KEY ("colaboradorId") REFERENCES "Colaborador" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UsuarioOrg" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT,
    "username" TEXT,
    "senha" TEXT,
    "telefone" TEXT,
    "banner" BLOB,
    "nomeEmpresa" TEXT,
    "tipoEmpresa" TEXT,
    "pais" TEXT,
    "estado" TEXT,
    "cidade" TEXT,
    "endereco" TEXT,
    "codigoPostal" TEXT,
    "fotoPerfil" BLOB,
    "descricaoCurta" TEXT,
    "hashtag" TEXT,
    "descricaoEmpresa" TEXT,
    "pago" BOOLEAN
);

-- CreateTable
CREATE TABLE "Servicos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT,
    "descricao" TEXT,
    "banner" BLOB,
    "basicoTexto" TEXT,
    "basicoPreco" REAL,
    "intermediarioTexto" TEXT,
    "intermediarioPreco" REAL,
    "avancadoTexto" TEXT,
    "avancadoPreco" REAL,
    "usuarioCriativoId" TEXT NOT NULL,
    "pacoteId" INTEGER,
    CONSTRAINT "Servicos_usuarioCriativoId_fkey" FOREIGN KEY ("usuarioCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Servicos_pacoteId_fkey" FOREIGN KEY ("pacoteId") REFERENCES "Pacote" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Pacote" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "caracteristica" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "PacoteAtributo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "basico" TEXT NOT NULL,
    "intermediario" TEXT NOT NULL,
    "avancado" TEXT NOT NULL,
    "pacoteId" INTEGER,
    CONSTRAINT "PacoteAtributo_pacoteId_fkey" FOREIGN KEY ("pacoteId") REFERENCES "Pacote" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Projeto" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT,
    "banner" BLOB,
    "texto" TEXT,
    "likes" INTEGER,
    "views" INTEGER,
    "criadorId" TEXT,
    "usuarioOrgId" TEXT,
    CONSTRAINT "Projeto_criadorId_fkey" FOREIGN KEY ("criadorId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Projeto_usuarioOrgId_fkey" FOREIGN KEY ("usuarioOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Colaborador" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "projetoId" INTEGER,
    CONSTRAINT "Colaborador_projetoId_fkey" FOREIGN KEY ("projetoId") REFERENCES "Projeto" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "midiaImagem" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT,
    "img" BLOB,
    "projetoId" INTEGER,
    CONSTRAINT "midiaImagem_projetoId_fkey" FOREIGN KEY ("projetoId") REFERENCES "Projeto" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "midiaVideo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT,
    "video" BLOB,
    "projetoId" INTEGER,
    CONSTRAINT "midiaVideo_projetoId_fkey" FOREIGN KEY ("projetoId") REFERENCES "Projeto" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Comentarios" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "texto" TEXT NOT NULL,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "avaliacao" REAL NOT NULL,
    "usuarioCriativoId" TEXT,
    "usuarioOrgId" TEXT,
    "projetoId" INTEGER,
    "servicosId" INTEGER,
    "perfilCriativoId" TEXT,
    "perfilOrgId" TEXT,
    CONSTRAINT "Comentarios_usuarioCriativoId_fkey" FOREIGN KEY ("usuarioCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Comentarios_usuarioOrgId_fkey" FOREIGN KEY ("usuarioOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Comentarios_projetoId_fkey" FOREIGN KEY ("projetoId") REFERENCES "Projeto" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Comentarios_servicosId_fkey" FOREIGN KEY ("servicosId") REFERENCES "Servicos" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Comentarios_perfilCriativoId_fkey" FOREIGN KEY ("perfilCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Comentarios_perfilOrgId_fkey" FOREIGN KEY ("perfilOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Tags" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "projetoId" INTEGER,
    "usuarioOrgId" TEXT,
    "usuarioCriativoId" TEXT,
    "servicosId" INTEGER,
    CONSTRAINT "Tags_projetoId_fkey" FOREIGN KEY ("projetoId") REFERENCES "Projeto" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Tags_usuarioOrgId_fkey" FOREIGN KEY ("usuarioOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Tags_usuarioCriativoId_fkey" FOREIGN KEY ("usuarioCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Tags_servicosId_fkey" FOREIGN KEY ("servicosId") REFERENCES "Servicos" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Mensagens" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "usuarioTipo" TEXT NOT NULL,
    "mensagem" TEXT NOT NULL,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usuarioCriativoId" TEXT,
    "usuarioOrgId" TEXT,
    CONSTRAINT "Mensagens_usuarioCriativoId_fkey" FOREIGN KEY ("usuarioCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Mensagens_usuarioOrgId_fkey" FOREIGN KEY ("usuarioOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "avaliacao" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "avaliacaoNumero" REAL NOT NULL,
    "usuarioCriativoId" TEXT,
    "usuarioOrgId" TEXT,
    CONSTRAINT "avaliacao_usuarioCriativoId_fkey" FOREIGN KEY ("usuarioCriativoId") REFERENCES "UsuarioCriativo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "avaliacao_usuarioOrgId_fkey" FOREIGN KEY ("usuarioOrgId") REFERENCES "UsuarioOrg" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_UsuarioCriativoToUsuarioOrg" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_UsuarioCriativoToUsuarioOrg_A_fkey" FOREIGN KEY ("A") REFERENCES "UsuarioCriativo" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_UsuarioCriativoToUsuarioOrg_B_fkey" FOREIGN KEY ("B") REFERENCES "UsuarioOrg" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "UsuarioCriativo_email_key" ON "UsuarioCriativo"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UsuarioCriativo_username_key" ON "UsuarioCriativo"("username");

-- CreateIndex
CREATE UNIQUE INDEX "UsuarioOrg_email_key" ON "UsuarioOrg"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UsuarioOrg_username_key" ON "UsuarioOrg"("username");

-- CreateIndex
CREATE UNIQUE INDEX "_UsuarioCriativoToUsuarioOrg_AB_unique" ON "_UsuarioCriativoToUsuarioOrg"("A", "B");

-- CreateIndex
CREATE INDEX "_UsuarioCriativoToUsuarioOrg_B_index" ON "_UsuarioCriativoToUsuarioOrg"("B");
