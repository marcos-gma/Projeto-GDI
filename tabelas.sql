-- Criação da tabela Detento
CREATE TABLE Detento (
    cpf VARCHAR2(11) PRIMARY KEY,
    comportamento VARCHAR2(30),
    data_ent DATE,
    sexo CHAR(1),
    data_nasc DATE,
    nome VARCHAR2(30)
);

-- Criação da tabela Sentença
CREATE TABLE Sentenca (
    crime VARCHAR2(30),
    malfeitor VARCHAR2(11),
    PRIMARY KEY (crime, malfeitor),
    CONSTRAINT fk_malfeitor FOREIGN KEY (malfeitor) REFERENCES Detento(cpf)
);

-- Criação da tabela Crime
CREATE TABLE Crime (
    crime VARCHAR2(30) PRIMARY KEY,
    duracao NUMBER,
    CONSTRAINT fk_crime FOREIGN KEY (crime) REFERENCES Sentenca(crime),
);

-- Criação da tabela Visitante
CREATE TABLE Visitante (
    nome VARCHAR2(30),
    sexo CHAR(1),
    data_nasc DATE,
    malfeitor VARCHAR2(11),
    PRIMARY KEY (nome, malfeitor),
    CONSTRAINT fk_malfeitor_visitante FOREIGN KEY (malfeitor) REFERENCES Detento(cpf)
);

-- Criação da tabela Cela
CREATE TABLE Cela (
    id NUMBER PRIMARY KEY,
    tipo VARCHAR2(30),
    CONSTRAINT fk_tipo FOREIGN KEY (tipo) REFERENCES Tipo_Cela(tipo_cela)
);

-- Criação da tabela Tipo_Cela
CREATE TABLE Tipo_Cela (
    tipo_cela VARCHAR2(30) PRIMARY KEY,
    capacidade NUMBER
);

-- Criação da tabela Ala
CREATE TABLE Ala (
    id NUMBER PRIMARY KEY,
    tipo VARCHAR2(30),
    nivel_seg NUMBER,
    autoridade VARCHAR2(11),
    CONSTRAINT fk_superintendente FOREIGN KEY (autoridade) REFERENCES Superintendente(cpf)
);

-- Criação da tabela Superintendente
CREATE TABLE Superintendente (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    bonificacao NUMBER,
    diretor NUMBER,
    CONSTRAINT fk_funcionario FOREIGN KEY (cpf_f) REFERENCES Funcionario(cpf),
    CONSTRAINT fk_diretor FOREIGN KEY (diretor) REFERENCES Diretor(codigo)
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
    CONSTRAINT fk_endereco FOREIGN KEY (cep) REFERENCES Endereco(cep)
);

-- Criação da tabela Endereço
CREATE TABLE Endereco (
    cep VARCHAR2(10) PRIMARY KEY,
    rua VARCHAR2(30),
    numero NUMBER,
    bairro VARCHAR2(30)
);

-- Criação da tabela Telefone
CREATE TABLE Telefone (
    id NUMBER PRIMARY KEY,
    telefone VARCHAR2(15),
    funcionario VARCHAR2(11),
    CONSTRAINT fk_funcionario_telefone FOREIGN KEY (funcionario) REFERENCES Funcionario(cpf)
);

-- Criação da tabela Diretor
CREATE TABLE Diretor (
    superintendente VARCHAR2(11) PRIMARY KEY,
    codigo NUMBER,
    data_inicio DATE
	CONSTRAINT fk_superintendente FOREIGN KEY (superintendente) REFERENCES Superintendente(cpf_f),
    CONSTRAINT unico_diretor UNIQUE (FuncionarioID)
);

CREATE TABLE Diretor (
    FuncionarioID NUMBER PRIMARY KEY,
    CONSTRAINT fk_diretor_superintendente FOREIGN KEY (FuncionarioID)
    REFERENCES Superintendente(FuncionarioID),
    CONSTRAINT unico_diretor UNIQUE (FuncionarioID)
);

-- Criação da tabela Guarda
CREATE TABLE Guarda (
    cpf_f VARCHAR2(11) PRIMARY KEY,
    turno VARCHAR2(30),
    supervisionado VARCHAR2(30),
    CONSTRAINT fk_funcionario FOREIGN KEY (cpf_f) REFERENCES Funcionario(cpf),
    CONSTRAINT fk_supervisionado FOREIGN KEY (supervisionado) REFERENCES Guarda(cpf_f)
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
    CONSTRAINT fk_malfeitor_visita FOREIGN KEY (malfeitor) REFERENCES Detento(cpf)
);

-- Criação da tabela Entrada
CREATE TABLE Entrada (
    visitante VARCHAR2(30),
    data_hora DATE,
    PRIMARY KEY (visitante, data_hora),
    CONSTRAINT fk_visitante_entrada FOREIGN KEY (visitante) REFERENCES Visitante(nome)
);

-- Criação da tabela Local
CREATE TABLE Local (
    data_hora DATE PRIMARY KEY,
    sala NUMBER,
    CONSTRAINT fk_sala FOREIGN KEY (sala) REFERENCES Sala_visita(id)
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
