DROP DATABASE IF EXISTS finances;

USE finances;

CREATE DATABASE finances;

CREATE TABLE usuario(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    cpf char(11) NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (id)
);

CREATE TABLE meta(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    dataFinal date NOT NULL,
    saldoFinal FLOAT NOT NULL,
    saldoAtual FLOAT NOT NULL,
    idUsuario INTEGER NOT NULL,
    CONSTRAINT pk_meta PRIMARY KEY (id),
    CONSTRAINT fk_usuario FOREIGN KEY (idUsuario)
);

CREATE TABLE notificacao(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    idMeta INTEGER NOT NULL,
    CONSTRAINT pk_notificacao PRIMARY KEY (id),
    CONSTRAINT fk_meta FOREIGN KEY (idMeta)
);

CREATE TABLE notificacao_usuario(
    idNotificacao INTEGER NOT NULL,
    idUsuario INTEGER NOT NULL,
    CONSTRAINT fk_notificacao FOREIGN KEY (idNotificacao),
    CONSTRAINT fk_usuario FOREIGN KEY (idUsuario),
    CONSTRAINT notificacao_unica UNIQUE(idNotificacao, idUsuario)
);

CREATE TABLE banco(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    codigo INTEGER NOT NULL,
    CONSTRAINT pk_banco PRIMARY KEY (id)
);

CREATE TABLE conta_bancaria(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    saldo FLOAT NOT NULL,
    idUsuario INTEGER NOT NULL,
    idBanco INTEGER NOT NULL,
    CONSTRAINT pk_conta_bancaria PRIMARY KEY (id),
    CONSTRAINT fk_usuario FOREIGN KEY (idUsuario),
    CONSTRAINT fk_banco FOREIGN KEY (idBanco)
);

CREATE TABLE cartao(
    id INTEGER NOT NULL AUTO_INCREMENT,
    numero CHAR(16) NOT NULL,
    idUsuario INTEGER NOT NULL,
    idContaBancaria INTEGER NOT NULL,
    validade DATE NOT NULL,
    codigoSeguranca CHAR(3) NOT NULL,
    CONSTRAINT pk_cartao PRIMARY KEY (id),
    CONSTRAINT fk_usuario FOREIGN KEY (idUsuario),
    CONSTRAINT fk_conta_bancaria FOREIGN KEY (idContaBancaria)
    
);

CREATE TABLE operacao(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    preco FLOAT NOT NULL,
    idContaBancaria INTEGER NOT NULL,
    CONSTRAINT pk_operacao PRIMARY KEY (id),
    CONSTRAINT fk_conta_bancaria FOREIGN KEY (idContaBancaria)
);

CREATE TABLE acesso(
    id INTEGER NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    idUsuario INTEGER NOT NULL,
    CONSTRAINT pk_acesso PRIMARY KEY (id),
    CONSTRAINT fk_usuario FOREIGN KEY (idUsuario)
);

-- JOINS --
SELECT a.id, a.nome, u.nome FROM acesso a INNER JOIN usuario u ON u.id = a.idUsuario;
SELECT o.id, o.nome, o.preco, cb.nome FROM operacao o INNER JOIN conta_bancaria cb ON cb.id = o.idContaBancaria;
