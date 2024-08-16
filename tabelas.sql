-- Criação da tabela Detento
CREATE TABLE Detento (
    cpf VARCHAR2(11) PRIMARY KEY,
    comportamento VARCHAR2(30),
    data_ent DATE,
    sexo char(1),
    data_nasc DATE,
    nome VARCHAR2(30),
    CHECK (sexo IN ('F', 'M'))--Adição checagem ENUM
);

-- Criação da tabela Sentença
CREATE TABLE Sentenca (
    crime VARCHAR2(30),
    cpf_detento VARCHAR2(11),
    PRIMARY KEY (crime, cpf_detento),
    CONSTRAINT fk_malfeitor FOREIGN KEY (cpf_detento) REFERENCES Detento(cpf)
);

-- Criação da tabela Crime
CREATE TABLE Crime (
	id_crime NUMBER PRIMARY KEY,
    crime VARCHAR2(30),
	cpf_detento VARCHAR2(11),
    duracao NUMBER,
    CONSTRAINT fk_crime FOREIGN KEY (crime, cpf_detento) REFERENCES Sentenca(crime, cpf_detento),
    CHECK (duracao BETWEEN 1 AND 30)--Adição checagem INTERVALO
);

-- Criação da tabela Visitante
CREATE TABLE Visitante (
    nome VARCHAR2(30),
    sexo CHAR(1),
    data_nasc DATE,
    malfeitor VARCHAR2(11),
    PRIMARY KEY (nome, malfeitor),
    CONSTRAINT fk_malfeitor_visitante FOREIGN KEY (malfeitor) REFERENCES Detento(cpf),
    CHECK (sexo IN ('F', 'M'))--Adição checagem ENUM
);

-- Criação da tabela Tipo_Cela
CREATE TABLE Tipo_Cela (
    tipo_cela VARCHAR2(30) PRIMARY KEY,
    capacidade NUMBER,
    CHECK (capacidade BETWEEN 1 AND 10) --Adição checagem INTERVALO
);

-- Criação da tabela Cela
CREATE TABLE Cela (
    id_cela NUMBER PRIMARY KEY,
    tipo VARCHAR2(15), --Mudança SIZEType
    CONSTRAINT fk_tipo FOREIGN KEY (tipo) REFERENCES Tipo_Cela(tipo_cela),
    CHECK (tipo IN ('SOLITARIA', 'REGULAR')) --Adição checagem ENUM
);

-- Criação da tabela Endereço
CREATE TABLE Endereco (
    cep VARCHAR2(10) PRIMARY KEY,
    rua VARCHAR2(30),
    numero NUMBER,
    bairro VARCHAR2(30)
);

-- Criação da tabela Funcionário
CREATE TABLE Funcionario (
    cpf VARCHAR2(11) PRIMARY KEY,
    nome VARCHAR2(30),
    data_nasc DATE,
    sexo CHAR(1),
    salario NUMBER,
    data_admi DATE,
    cep VARCHAR2(10),
    CONSTRAINT fk_endereco FOREIGN KEY (cep) REFERENCES Endereco(cep),
    CHECK (sexo IN ('F', 'M')) --Adição checagem ENUM
);

-- Criação da tabela Diretor
CREATE TABLE Diretor (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    codigo NUMBER,
    data_inicio DATE,																		-- Diretor especialização de funcionario
    CONSTRAINT unico_diretor FOREIGN KEY (cpf_f) REFERENCES Funcionario (cpf)
);

-- Criação da tabela Superintendente
CREATE TABLE Superintendente (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    bonificacao NUMBER,
    diretor VARCHAR2(11),
    CONSTRAINT fk_funcionario FOREIGN KEY (cpf_f) REFERENCES Funcionario(cpf),
    CONSTRAINT fk_diretor FOREIGN KEY (diretor) REFERENCES Diretor(cpf_f)
    
);

-- Criação da tabela Ala
CREATE TABLE Ala (
    id NUMBER PRIMARY KEY,
    tipo CHAR(1), --Mudança type
    nivel_seg VARCHAR2(15), --Mudança type
    autoridade VARCHAR2(11),
    CONSTRAINT fk_superintendente FOREIGN KEY (autoridade) REFERENCES Superintendente(cpf_f),
    CHECK (tipo IN ('F', 'M')), --Adição checagem ENUM
    CHECK (nivel_seg IN ('MAXIMA', 'MEDIA', 'PADRAO')) --Adição checagem ENUM
    
);

-- Criação da tabela Telefone
CREATE TABLE Telefone (
    id NUMBER PRIMARY KEY,
    telefone VARCHAR2(15),
    funcionario VARCHAR2(11),
    CONSTRAINT fk_funcionario_telefone FOREIGN KEY (funcionario) REFERENCES Funcionario(cpf)
);


-- Criação da tabela Guarda
CREATE TABLE Guarda (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    turno VARCHAR2(11),
    supervisionado VARCHAR2(11),
    CONSTRAINT fk_supervisionado FOREIGN KEY (supervisionado) REFERENCES Guarda(cpf_f),
    CHECK (turno IN ('NOTURNO', 'MATUTINO', 'VESPERTINO')) --Adição checagem ENUM
);

-- Criação da tabela Sala_visita
CREATE TABLE Sala_visita (
    id NUMBER PRIMARY KEY
);

-- Criação da tabela Visita
CREATE TABLE Visita (
    motivo VARCHAR2(30),
    malfeitor VARCHAR2(11) PRIMARY KEY,
    data_hora DATE,
    CONSTRAINT fk_malfeitor_visita FOREIGN KEY (malfeitor) REFERENCES Detento(cpf),
    CHECK (motivo IN ('Amigo(a)', 'Parente', 'Conjuge', 'Companheiro(a)')) --Adição checagem ENUM
);

-- Criação da tabela Entrada
CREATE TABLE Entrada (
    visitante VARCHAR2(30),
    data_hora DATE,
	nome VARCHAR2(30), 
	malfeitor VARCHAR2(11),
    PRIMARY KEY (visitante, data_hora),
    CONSTRAINT fk_visitante_entrada FOREIGN KEY (nome, malfeitor) REFERENCES Visitante(nome, malfeitor)
);

-- Criação da tabela Local
CREATE TABLE Lugar (
    data_hora DATE PRIMARY KEY,
    sala NUMBER,
    CONSTRAINT fk_sala FOREIGN KEY (sala) REFERENCES Sala_visita(id),
    CHECK (sala BETWEEN 100 AND 208) --Adição checagem INTERVALO
);

-- Criação da tabela Possui
CREATE TABLE Possui (
    malfeitor VARCHAR2(11) PRIMARY KEY,
    cela NUMBER,
    ala NUMBER,
    CONSTRAINT fk_malfeitor_possui FOREIGN KEY (malfeitor) REFERENCES Detento(cpf),
    CONSTRAINT fk_cela FOREIGN KEY (cela) REFERENCES Cela(id),
    CONSTRAINT fk_ala FOREIGN KEY (ala) REFERENCES Ala(id)
);

CREATE SEQUENCE Sequencia_Geral
START WITH 1
INCREMENT BY 1;
