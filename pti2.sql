DROP DATABASE IF EXISTS fazenda_bd;
CREATE DATABASE IF NOT EXISTS fazenda_bd;

USE fazenda_bd;

CREATE TABLE IF NOT EXISTS t_funcionarios (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome varchar(70) NOT NULL,
    cpf bigint NOT NULL,
    salario decimal(10,2) NOT NULL,
    CONSTRAINT uq_cpf UNIQUE(cpf)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_locais (
	codigo VARCHAR(5) NOT NULL PRIMARY KEY,
    nome VARCHAR(70) NOT NULL,
    maximo_armazenamento DECIMAL(7, 2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_unidade_medidas (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sigla CHAR(2) NOT NULL,
    descricao VARCHAR(25)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_produtos (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    unidade_medida_id INT NOT NULL,
    preco DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT t_unidade_medidas_id_produtos FOREIGN KEY (unidade_medida_id) REFERENCES t_unidade_medidas(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_animal_especies (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR (25) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_animais (
	id VARCHAR(10) NOT NULL PRIMARY KEY,
    produto_id INT NOT NULL,
    animal_especie_id INT NOT NULL,
	nome VARCHAR(25),
    peso DECIMAL(6, 2) NOT NULL,
    CONSTRAINT fk_t_animal_especies_id_animais FOREIGN KEY (animal_especie_id) REFERENCES t_animal_especies(id),
    CONSTRAINT fk_t_produtos_id_animais FOREIGN KEY (produto_id) REFERENCES t_produtos(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_produto_locais (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    local_codigo VARCHAR(5),
    quantidade_estoque DECIMAL(7, 2) DEFAULT 0.00,
    CONSTRAINT fk_t_locais_codigo FOREIGN KEY (local_codigo) REFERENCES t_locais(codigo),
    CONSTRAINT fk_t_produtos_id FOREIGN KEY (produto_id) REFERENCES t_produtos(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_producao_leite (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    animal_id VARCHAR(10) NOT NULL,
    data_ultima_ordenha DATETIME NOT NULL,
    temperatura DECIMAL (5,2) NOT NULL,
    houve_inseminacao TINYINT NOT NULL DEFAULT 0,
    secagem_esperada DATE,
    minutos_ruminacao_dia DECIMAL (5,2),
    CONSTRAINT fk_t_animais_id_producao_leite FOREIGN KEY (animal_id) REFERENCES t_animais(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_equipamentos (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_varejistas (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cnpj VARCHAR(14) NOT NULL,
    razao_social VARCHAR(80) NOT NULL,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_vendas (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    varejista_id INT NOT NULL,
	funcionario_id INT NOT NULL,
    status TINYINT DEFAULT 0,
    CONSTRAINT fk_t_varejista_id FOREIGN KEY (varejista_id) REFERENCES t_varejistas(id),
    CONSTRAINT fk_t_funcionarios_id FOREIGN KEY (funcionario_id) REFERENCES t_funcionarios(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS t_venda_produtos (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade DECIMAL(7,2) NOT NULL,
    valor_unitario_pago DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_t_produtos_id_vendas FOREIGN KEY (produto_id) REFERENCES t_produtos(id),
    CONSTRAINT fk_t_vendas_id FOREIGN KEY (venda_id) REFERENCES t_vendas(id)
) ENGINE=InnoDB;

INSERT INTO t_funcionarios (nome, cpf, salario) VALUES
('EDUARDO FERREIRA', 49150206818, 2500.00)
,('ALFRED JORDSON', 08035454013, 2940.50);

INSERT INTO t_equipamentos (nome, tipo) VALUES
('ORDENHADEIRA', 'ANIMAL'),
('PLANTADEIRA', 'PLANTA'),
('SEMEADEIRA',  'PLANTA');

INSERT INTO t_locais (codigo, nome, maximo_armazenamento) VALUES
('A1', 'CONFINAMENTO DE VACA - NORTE', 4),
('A2', 'CONFINAMENTO DE VACA - SUL', 4),
('A3', 'CONFINAMENTO DE VACA - LESTE', 4),
('A4', 'CONFINAMENTO DE VACA - OESTE', 4),
('B1', 'ARMAZEM - SUL', 1000);

INSERT INTO t_unidade_medidas (sigla, descricao) VALUES
('SC', 'SACA'),
('KG', 'QUILO'),
('UN', 'UNIDADE');

INSERT INTO t_produtos (nome, unidade_medida_id, preco) VALUES
('VACA LEITEIRA', 3, 4500.00),
('SOJA AMARELA',  2, 2.77),
('FEIJÂO CARIOCA 60KG', 1, 261.00);

INSERT INTO t_produto_locais (produto_id, local_codigo, quantidade_estoque) VALUES
(1, 'A4', 3),
(2, 'B1', 300),
(3, 'B1', 120);

INSERT INTO t_varejistas (cnpj, razao_social) VALUES
('67313130000155', 'BARILOCHE'),
('32449523000106', 'ASSAÍ');

INSERT INTO t_animal_especies (descricao) VALUES
('VACA LEITEIRA'),
('VACA EUROPEIA');

INSERT INTO t_animais (id, produto_id, animal_especie_id, nome, peso) VALUES
('V1', 1, 1, 'MIMOSA', 600.00);

INSERT INTO t_producao_leite (animal_id, data_ultima_ordenha, temperatura, houve_inseminacao, secagem_esperada, minutos_ruminacao_dia) VALUES
('V1', '2020-11-01 19:38:00', 38.5, 0, '2021-02-01', 320.00);

INSERT INTO t_vendas (varejista_id, funcionario_id, status) VALUES (1, 1, 1);

INSERT INTO t_venda_produtos (venda_id, produto_id, quantidade, valor_unitario_pago) VALUES
(1, 2, 100, 2.50);