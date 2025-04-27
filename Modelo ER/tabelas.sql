-- Criação da tabela Detento
CREATE TABLE Detento (
    cpf VARCHAR2(11) PRIMARY KEY,
    comportamento VARCHAR2(30),
    data_ent DATE NOT NULL,
    data_saida DATE, -- data de saída será definida por um trigger
    sexo CHAR(1) NOT NULL,
    data_nasc DATE NOT NULL,
    nome VARCHAR2(30) NOT NULL,
    CHECK (sexo IN ('F', 'M')) -- checa se o valor inserido na coluna sexo é 'F' ou 'M' (tem que ser um dos dois) 
);


-- Criação da tabela Sentença
CREATE TABLE Sentenca (
    crime VARCHAR2(30) NOT NULL,
    cpf_detento VARCHAR2(11) NOT NULL,
    duracao NUMBER NOT NULL, -- atulizar automaticamente quando adicionar uma nova sentença ao mesmo cpf
    PRIMARY KEY (crime, cpf_detento),
    CONSTRAINT fk_malfeitor FOREIGN KEY (cpf_detento) REFERENCES Detento(cpf) -- constraint é uma restrição que impede a inserção de valores inválidos em uma coluna -> nesse caso, a coluna cpf_detento da tabela Sentenca só pode receber valores que existem na coluna cpf da tabela Detento
);

-- Criação da tabela Visitante -> entidade fraca pq depende de malfeitor (detento visitado) para existir
CREATE TABLE Visitante (
    nome VARCHAR2(30) NOT NULL,
    sexo CHAR(1) NOT NULL,
    data_nasc DATE NOT NULL,
    malfeitor VARCHAR2(11) NOT NULL, -- detento visitado
    PRIMARY KEY (nome, malfeitor),
    CONSTRAINT fk_malfeitor_visitante FOREIGN KEY (malfeitor) REFERENCES Detento(cpf),
    CHECK (sexo IN ('F', 'M'))
);

-- Criação da tabela Tipo_Cela
CREATE TABLE Tipo_Cela (
    tipo_cela VARCHAR2(30) PRIMARY KEY,
    capacidade NUMBER NOT NULL,
    CHECK (capacidade BETWEEN 1 AND 10) -- checa se a capacidade da cela está entre 1 e 10 (máximo)
);

-- Criação da tabela Cela
CREATE TABLE Cela (
    id_cela NUMBER PRIMARY KEY,
    tipo VARCHAR2(15) NOT NULL, 
    CONSTRAINT fk_tipo FOREIGN KEY (tipo) REFERENCES Tipo_Cela(tipo_cela),
    CHECK (tipo IN ('SOLITARIA', 'REGULAR')) -- checa se o tipo da cela é 'SOLITARIA' ou 'REGULAR'
);

-- Criação da tabela Endereço -> atributo composto
CREATE TABLE Endereco (
    cep VARCHAR2(10) PRIMARY KEY,
    rua VARCHAR2(30) NOT NULL,
    numero NUMBER NOT NULL,
    bairro VARCHAR2(30) NOT NULL
);

-- Criação da tabela Funcionário
CREATE TABLE Funcionario (
    cpf VARCHAR2(11) PRIMARY KEY,
    nome VARCHAR2(30) NOT NULL,
    data_nasc DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    salario NUMBER NOT NULL,
    data_admi DATE NOT NULL,
    cep VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_endereco FOREIGN KEY (cep) REFERENCES Endereco(cep),
    CHECK (sexo IN ('F', 'M')) 
);

-- Criação da tabela Diretor
CREATE TABLE Diretor (
    cpf_f VARCHAR2(11) NOT NULL UNIQUE, 
    codigo NUMBER PRIMARY KEY,
    data_inicio DATE NOT NULL,	
    CONSTRAINT unico_diretor FOREIGN KEY (cpf_f) REFERENCES Funcionario (cpf) -- especialização de funcionário
);

-- Criação da tabela Superintendente
CREATE TABLE Superintendente (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    bonificacao NUMBER NOT NULL,
    diretor NUMBER NOT NULL,
    CONSTRAINT fk_funcionario FOREIGN KEY (cpf_f) REFERENCES Funcionario(cpf), -- especialização de funcionário
    CONSTRAINT fk_diretor FOREIGN KEY (diretor) REFERENCES Diretor(codigo) -- diretor que coordena o superintendente
);

-- Criação da tabela Ala
CREATE TABLE Ala (
    id NUMBER PRIMARY KEY,
    tipo CHAR(1) NOT NULL, 
    nivel_seg VARCHAR2(15) NOT NULL, 
    autoridade VARCHAR2(11) NOT NULL UNIQUE,
    CONSTRAINT fk_superintendente FOREIGN KEY (autoridade) REFERENCES Superintendente(cpf_f), -- superintendente responsável pela ala (administra)
    CHECK (tipo IN ('F', 'M')),
    CHECK (nivel_seg IN ('MAXIMA', 'MEDIA', 'PADRAO')) -- checa se o nível de segurança da ala é 'MAXIMA', 'MEDIA' ou 'PADRAO'
);

-- Criação da tabela Telefone -> atributo multivalorado
CREATE TABLE Telefone (
    id NUMBER PRIMARY KEY,
    telefone VARCHAR2(15) NOT NULL UNIQUE,
    funcionario VARCHAR2(11) NOT NULL,
    CONSTRAINT fk_funcionario_telefone FOREIGN KEY (funcionario) REFERENCES Funcionario(cpf) -- telefone de funcionário
);

-- Criação da tabela Guarda
CREATE TABLE Guarda (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    turno VARCHAR2(11) NOT NULL,
    supervisionado VARCHAR2(11),
    CONSTRAINT fk_funcionario_guarda FOREIGN KEY (cpf_f) REFERENCES Funcionario(cpf), -- especialização de funcionário
    CONSTRAINT fk_supervisionado FOREIGN KEY (supervisionado) REFERENCES Guarda(cpf_f), -- guarda que supervisiona outro guarda
    CHECK (turno IN ('NOTURNO', 'MATUTINO', 'VESPERTINO')) -- checagem ENUM
);

-- Criação da tabela Sala_visita
CREATE TABLE Sala_visita (
    id NUMBER PRIMARY KEY
);

-- Criação da tabela Visita -> relacionamento que virou entidade
CREATE TABLE Visita (
    motivo VARCHAR2(30) NOT NULL,
    malfeitor VARCHAR2(11) PRIMARY KEY,
    data_hora DATE NOT NULL,
    visitante VARCHAR2(30) NOT NULL,
    sala_visita NUMBER NOT NULL,
    CONSTRAINT fk_sala_visita FOREIGN KEY (sala_visita) REFERENCES Sala_visita(id), -- sala de visita usada
    CONSTRAINT fk_visitante FOREIGN KEY (visitante, malfeitor) REFERENCES Visitante(nome, malfeitor), -- visitante que visita
    CONSTRAINT fk_malfeitor_visita FOREIGN KEY (malfeitor) REFERENCES Detento(cpf), -- detento visitado
    CHECK (motivo IN ('Amigo(a)', 'Parente', 'Conjuge', 'Outro(a)'))
);

-- Criação da tabela Possui -> relacionamento triplo
CREATE TABLE Possui (
    malfeitor VARCHAR2(11) PRIMARY KEY,
    cela NUMBER NOT NULL,
    ala NUMBER NOT NULL,
    CONSTRAINT fk_malfeitor_possui FOREIGN KEY (malfeitor) REFERENCES Detento(cpf), -- detento que possui ala e cela
    CONSTRAINT fk_cela FOREIGN KEY (cela) REFERENCES Cela(id_cela), -- cela que o detento pertence e está em uma ala
    CONSTRAINT fk_ala FOREIGN KEY (ala) REFERENCES Ala(id) -- ala que o detento pertence e que contém a cela
);


-- DROP DAS TABELAS ACIMA
DROP TABLE Possui CASCADE CONSTRAINTS;
DROP TABLE Visita CASCADE CONSTRAINTS;
DROP TABLE Sala_visita CASCADE CONSTRAINTS;
DROP TABLE Guarda CASCADE CONSTRAINTS;
DROP TABLE Telefone CASCADE CONSTRAINTS;
DROP TABLE Ala CASCADE CONSTRAINTS;
DROP TABLE Superintendente CASCADE CONSTRAINTS;
DROP TABLE Diretor CASCADE CONSTRAINTS;
DROP TABLE Funcionario CASCADE CONSTRAINTS;
DROP TABLE Endereco CASCADE CONSTRAINTS;
DROP TABLE Cela CASCADE CONSTRAINTS;
DROP TABLE Tipo_Cela CASCADE CONSTRAINTS;
DROP TABLE Visitante CASCADE CONSTRAINTS;
DROP TABLE Sentenca CASCADE CONSTRAINTS;
DROP TABLE Detento CASCADE CONSTRAINTS;


-- limpar os dados das tabelas e manter as tabelas
DELETE FROM Sentenca;
DELETE FROM Visitante;
DELETE FROM Possui;
DELETE FROM Visita;
DELETE FROM Guarda;
DELETE FROM Superintendente;
DELETE FROM Diretor;
DELETE FROM Funcionario;
DELETE FROM Ala;
DELETE FROM Cela;
DELETE FROM Tipo_Cela;
DELETE FROM Sala_visita;
DELETE FROM Telefone;
DELETE FROM Endereco;
DELETE FROM Detento;

COMMIT; -- Confirma a exclusão dos dados


-- selects das tabelas
select * from ala;
select * from cela;
select * from detento;
select * from diretor;
select * from endereco;
select * from funcionario;
select * from guarda;
select * from possui;
select * from sala_visita;
select * from setenca;
select * from superintendente;
select * from telefone;
select * from tipo_cela;
select * from visita;
select * from visitante;
