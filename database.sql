-- =====================================================
-- BANCO DE DADOS: EMPRESA
-- PostgreSQL
-- =====================================================


-- =====================================================
-- TABELA PESSOA
-- =====================================================

CREATE TABLE pessoa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);


-- =====================================================
-- TABELA SETOR
-- Cada setor deve possuir supervisores
-- =====================================================

CREATE TABLE setor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE
);


-- =====================================================
-- TABELA FUNCIONARIO
-- Todo funcionário pertence a um setor
-- e possui um supervisor
-- =====================================================

CREATE TABLE funcionario (
    id SERIAL PRIMARY KEY,

    pessoa_id INT UNIQUE NOT NULL,

    setor_id INT NOT NULL,

    supervisor_id INT NOT NULL,

    cargo VARCHAR(100),
    salario NUMERIC(10,2),
    data_admissao DATE,

    CONSTRAINT fk_funcionario_pessoa
        FOREIGN KEY (pessoa_id)
        REFERENCES pessoa(id),

    CONSTRAINT fk_funcionario_setor
        FOREIGN KEY (setor_id)
        REFERENCES setor(id),

    CONSTRAINT fk_supervisor
        FOREIGN KEY (supervisor_id)
        REFERENCES funcionario(id)
);


-- =====================================================
-- TABELA DEPENDENTE
-- =====================================================

CREATE TABLE dependente (
    id SERIAL PRIMARY KEY,

    pessoa_id INT NOT NULL,
    funcionario_id INT NOT NULL,

    parentesco VARCHAR(50),

    CONSTRAINT fk_dependente_pessoa
        FOREIGN KEY (pessoa_id)
        REFERENCES pessoa(id),

    CONSTRAINT fk_dependente_funcionario
        FOREIGN KEY (funcionario_id)
        REFERENCES funcionario(id)
);


-- =====================================================
-- TABELA PROJETO
-- =====================================================

CREATE TABLE projeto (
    id SERIAL PRIMARY KEY,
    nome_projeto VARCHAR(100) NOT NULL
);


-- =====================================================
-- TABELA ALOCACAO
-- =====================================================

CREATE TABLE alocacao (
    id SERIAL PRIMARY KEY,

    funcionario_id INT NOT NULL,
    projeto_id INT NOT NULL,

    CONSTRAINT fk_alocacao_funcionario
        FOREIGN KEY (funcionario_id)
        REFERENCES funcionario(id),

    CONSTRAINT fk_alocacao_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projeto(id)
);


-- =====================================================
-- TABELA EQUIPAMENTO
-- =====================================================

CREATE TABLE equipamento (
    id SERIAL PRIMARY KEY,

    nome_equipamento VARCHAR(100) NOT NULL,

    alocacao_id INT,

    CONSTRAINT fk_equipamento_alocacao
        FOREIGN KEY (alocacao_id)
        REFERENCES alocacao(id)
);