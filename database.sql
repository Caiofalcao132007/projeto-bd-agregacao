-- =====================================================
-- PROJETO: AGREGAÇÃO E AUTORRELACIONAMENTO
-- PostgreSQL
-- =====================================================


-- =====================================================
-- TABELA FUNCIONARIO
-- Autorelacionamento:
-- um funcionário pode supervisionar outros
-- =====================================================

CREATE TABLE funcionario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,

    supervisor_id INTEGER,

    CONSTRAINT fk_supervisor
        FOREIGN KEY (supervisor_id)
        REFERENCES funcionario(id)
);


-- =====================================================
-- TABELA DEPENDENTE
-- Dependência de existência:
-- o dependente só existe se o funcionário existir
-- =====================================================

CREATE TABLE dependente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,

    funcionario_id INTEGER NOT NULL,

    CONSTRAINT fk_funcionario
        FOREIGN KEY (funcionario_id)
        REFERENCES funcionario(id)
        ON DELETE CASCADE
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
-- Representa a agregação entre
-- funcionário e projeto
-- =====================================================

CREATE TABLE alocacao (
    id SERIAL PRIMARY KEY,

    funcionario_id INTEGER NOT NULL,
    projeto_id INTEGER NOT NULL,

    CONSTRAINT fk_alocacao_funcionario
        FOREIGN KEY (funcionario_id)
        REFERENCES funcionario(id),

    CONSTRAINT fk_alocacao_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projeto(id)
);


-- =====================================================
-- TABELA EQUIPAMENTO
-- Equipamentos ligados à alocação
-- =====================================================

CREATE TABLE equipamento (
    id SERIAL PRIMARY KEY,

    nome_equipamento VARCHAR(100) NOT NULL,

    alocacao_id INTEGER NOT NULL,

    CONSTRAINT fk_equipamento_alocacao
        FOREIGN KEY (alocacao_id)
        REFERENCES alocacao(id)
);


-- =====================================================
-- INSERTS PARA TESTE
-- =====================================================

INSERT INTO funcionario(nome)
VALUES ('Carlos');

INSERT INTO funcionario(nome, supervisor_id)
VALUES ('Ana', 1);

INSERT INTO dependente(nome, funcionario_id)
VALUES ('Pedro', 1);

INSERT INTO projeto(nome_projeto)
VALUES ('Sistema RH');

INSERT INTO alocacao(funcionario_id, projeto_id)
VALUES (1, 1);

INSERT INTO equipamento(nome_equipamento, alocacao_id)
VALUES ('Notebook Dell', 1);


-- =====================================================
-- SELECT COM AUTORRELACIONAMENTO
-- =====================================================

SELECT 
    f.nome AS funcionario,
    s.nome AS supervisor
FROM funcionario f
LEFT JOIN funcionario s
ON f.supervisor_id = s.id;


-- =====================================================
-- SELECT DA AGREGAÇÃO
-- =====================================================

SELECT
    f.nome AS funcionario,
    p.nome_projeto,
    e.nome_equipamento
FROM equipamento e
JOIN alocacao a
    ON e.alocacao_id = a.id
JOIN funcionario f
    ON a.funcionario_id = f.id
JOIN projeto p
    ON a.projeto_id = p.id;