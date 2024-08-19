-- Reseta o esquema
DROP TABLE Possui CASCADE CONSTRAINTS;
DROP TABLE Lugar CASCADE CONSTRAINTS;
DROP TABLE Entrada CASCADE CONSTRAINTS;
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
DROP TABLE Crime CASCADE CONSTRAINTS;
DROP TABLE Sentenca CASCADE CONSTRAINTS;
DROP TABLE Detento CASCADE CONSTRAINTS;
DROP SEQUENCE Sequencia_Geral;

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
    CONSTRAINT fk_diretor FOREIGN KEY (diretor) REFERENCES Diretor(codigo)
    
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
CREATE TABLE Entrada ( --Atualização retirar atributo nome.
    visitante VARCHAR2(30),
    data_hora DATE,
    malfeitor VARCHAR2(11),
    PRIMARY KEY (visitante, data_hora),
    CONSTRAINT fk_visitante_entrada FOREIGN KEY (visitante, malfeitor) REFERENCES Visitante(nome, malfeitor)
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
    CONSTRAINT fk_cela FOREIGN KEY (cela) REFERENCES Cela(id_cela),
    CONSTRAINT fk_ala FOREIGN KEY (ala) REFERENCES Ala(id)
);

CREATE SEQUENCE Sequencia_Geral
START WITH 1
INCREMENT BY 1;

-- CREATE SEQUENCE Sequencia_Sala
-- START WITH 100
-- INCREMENT BY 1;

-- -- Limpar todas as tabelas
-- DELETE FROM Visita;
-- DELETE FROM Entrada;
-- DELETE FROM Guarda;
-- DELETE FROM Sala_visita;
-- DELETE FROM Funcionario;
-- DELETE FROM Diretor;
-- DELETE FROM Superintendente;
-- DELETE FROM Detento;
-- DELETE FROM Sentenca;
-- DELETE FROM Crime;
-- DELETE FROM Visitante;
-- DELETE FROM Tipo_Cela;
-- DELETE FROM Cela;
-- DELETE FROM Endereco;
-- DELETE FROM Ala;
-- DELETE FROM Telefone;
-- DELETE FROM Lugar;
-- DELETE FROM Possui;




/*
1. INDEPENDENTES
	Endereco - Não depende de nenhuma outra tabela.
    Sala_visita - Não depende de nenhuma outra tabela.

2. DEPENDENTES
	Funcionario - Depende de Endereco.
    Diretor - Depende de Funcionario.
    Superintendente - Depende de Funcionario e Diretor.
    Ala - Depende de Superintendente.
    Telefone - Depende de Funcionario.
    Guarda - Depende de Funcionario (para supervisão, se aplicável).
    Detento - Não depende de nenhuma outra tabela.
    Sentenca - Depende de Detento.
    Crime - Depende de Sentenca.
    Visitante - Depende de Detento.
    Cela - Depende de Tipo_Cela.
    Visita - Depende de Detento.
    Entrada - Depende de Visitante.
    Lugar - Depende de Sala_visita.
    Possui - Depende de Detento, Cela, e Ala.
*/
-- Inserindo 20 dados na tabela Endereco
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('12345678', 'Rua Machu Pichu', 100, 'Centro');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('23456789', 'Rua Cristo Redentor', 200, 'Jardins');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('34567890', 'Rua Petra', 300, 'Zona Sul');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('17234567', 'Rua Dejardins', 87, 'Zona Leste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('15012345', 'Rua Bet do Paquetá', 30, 'Zona Oeste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('16123456', 'Avenida Brasil', 3, 'Zona Sudeste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('14901234', 'Avenida Atlântico', 12, 'Zona Nordeste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('07234567', 'Avenida Recife', 1, 'Zona Noroeste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('08345678', 'Avenida Beira Rio', 121, 'Zona Sudoeste');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('09456789', 'Avenida Grea Marcos', 254, 'Zona Norte');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('10567890', 'Avenida Iasmin Santos', 545, 'Centro');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('11678901', 'Avenida Matheus Pinheiro', 110, 'Novo');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('12789012', 'Avenida Atleta Gabriel', 330, 'Vila Olímpica');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('13890123', 'Avenida Guilherme Lopes', 440, 'Vila Universitária');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('01001000', 'Rua da Hora', 143, 'Curado I');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('02134456', 'Rua do Cin', 67, 'Curado IV');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('03456789', 'Rua 1', 79, 'Ipanema');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('05098123', 'Rua 2', 900, 'Copacabana');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('06123456', 'Rua Coliseu', 111, 'Zona Norte');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('78787878', 'Rua Big Ben', 299, 'Zona Sul');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('42315678', 'Rua Joquinha', 170, 'Jardins');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('78965410', 'Rua Obelisco', 4010, 'Centro');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('91247819', 'Rua Acropolis', 81, 'Plaka');


-- Inserindo dados na tabela Tipo_Cela
INSERT INTO Tipo_Cela (tipo_cela, capacidade) VALUES ('REGULAR', 4);
INSERT INTO Tipo_Cela (tipo_cela, capacidade) VALUES ('SOLITARIA', 1);

-- Inserindo dados na tabela Sala_visita
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);





-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('12222222222', 'João Silva', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'M', 3000 , TO_DATE('2010-05-15', 'YYYY-MM-DD'), '12345678');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('02222222220', 'Maria Souza', TO_DATE('1985-02-20', 'YYYY-MM-DD'), 'F', 3200, TO_DATE('2011-06-10', 'YYYY-MM-DD'), '23456789');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('12345678901', 'João Gomes', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'M', 15000, TO_DATE('2010-01-10', 'YYYY-MM-DD'), '01001000');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('23456789012', 'Maria Lucinda', TO_DATE('1992-03-22', 'YYYY-MM-DD'), 'F', 1500, TO_DATE('2008-02-15', 'YYYY-MM-DD'), '03456789');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('34567890123', 'Anderson Silva', TO_DATE('1985-07-09', 'YYYY-MM-DD'), 'M', 1900, TO_DATE('2012-03-20', 'YYYY-MM-DD'), '05098123');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('45678901234', 'Gisele Bundchen', TO_DATE('1988-09-12', 'YYYY-MM-DD'), 'F', 5000, TO_DATE('2014-05-30', 'YYYY-MM-DD'), '06123456');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('56789012345', 'Antonio Cruzeiro', TO_DATE('1991-12-05', 'YYYY-MM-DD'), 'M', 8000, TO_DATE('2015-06-05', 'YYYY-MM-DD'), '07234567');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('67890123456', 'Isabela Herminia', TO_DATE('1983-02-17', 'YYYY-MM-DD'), 'F', 6700, TO_DATE('2016-07-10', 'YYYY-MM-DD'), '08345678');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('78901234567', 'Alvaro Jorge', TO_DATE('1996-06-29', 'YYYY-MM-DD'), 'M', 3200, TO_DATE('2017-08-15', 'YYYY-MM-DD'), '09456789');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('89012345678', 'Pamela Wizacky', TO_DATE('1999-10-13', 'YYYY-MM-DD'), 'F', 3000, TO_DATE('2018-09-20', 'YYYY-MM-DD'), '10567890');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('90123456789', 'Prometheus Pinto', TO_DATE('2001-04-18', 'YYYY-MM-DD'), 'M', 2000, TO_DATE('2019-10-25', 'YYYY-MM-DD'), '11678901');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('01234567890', 'Virginia Leal', TO_DATE('1982-12-14', 'YYYY-MM-DD'), 'F', 25000, TO_DATE('2020-11-30', 'YYYY-MM-DD'), '12789012');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('10987654321', 'Dedalo Feitosa', TO_DATE('1989-07-19', 'YYYY-MM-DD'), 'M', 20000, TO_DATE('2021-12-05', 'YYYY-MM-DD'), '13890123');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('21987654321', 'Maria Pinto', TO_DATE('2003-05-23', 'YYYY-MM-DD'), 'F', 18000, TO_DATE('2016-03-20', 'YYYY-MM-DD'), '14901234');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('32987654321', 'Arnold Silvino', TO_DATE('1981-06-10', 'YYYY-MM-DD'), 'M', 7000, TO_DATE('2017-04-25', 'YYYY-MM-DD'), '15012345');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('43987654321', 'Jessica Farias', TO_DATE('1997-03-14', 'YYYY-MM-DD'), 'F', 12000, TO_DATE('2018-05-30', 'YYYY-MM-DD'), '16123456');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('54987654321', 'Vicente Silva', TO_DATE('1986-07-27', 'YYYY-MM-DD'), 'M', 15100, TO_DATE('2019-06-05', 'YYYY-MM-DD'), '17234567');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('65987654321', 'Luana Souza', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'F', 8000, TO_DATE('2023-02-15', 'YYYY-MM-DD'), '42315678');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('76987654321', 'Neymar Queiroz', TO_DATE('1980-08-22', 'YYYY-MM-DD'), 'M', 1500, TO_DATE('2022-01-10', 'YYYY-MM-DD'), '78965410');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) VALUES ('87987654321', 'Jessica Feitosa', TO_DATE('1978-06-19', 'YYYY-MM-DD'), 'F', 3000, TO_DATE('1999-08-01', 'YYYY-MM-DD'), '91247819');

-- Inserindo dados na tabela Diretor
INSERT INTO Diretor (cpf_f, codigo, data_inicio) VALUES ('12345678901', 1, TO_DATE('2020-01-10', 'YYYY-MM-DD'));
INSERT INTO Diretor (cpf_f, codigo, data_inicio) VALUES ('45678901234', 2, TO_DATE('2019-02-01', 'YYYY-MM-DD'));
INSERT INTO Diretor (cpf_f, codigo, data_inicio) VALUES ('56789012345', 3, TO_DATE('2015-06-05', 'YYYY-MM-DD'));
INSERT INTO Diretor (cpf_f, codigo, data_inicio) VALUES ('67890123456', 4, TO_DATE('2016-07-10', 'YYYY-MM-DD'));

-- Inserindo dados na tabela Superintendente
INSERT INTO Superintendente (cpf_f, bonificacao, diretor) VALUES ('45678901234', 500, 2);
INSERT INTO Superintendente (cpf_f, bonificacao, diretor) VALUES ('12345678901', 500, 1);

-- Inserindo dados na tabela Ala
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'M', 'MAXIMA', '45678901234');
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'M', 'MEDIA', '45678901234');
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'M', 'PADRAO', '45678901234');

INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'F', 'MEDIA', '12345678901');
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'F', 'MAXIMA', '12345678901');
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'F', 'PADRAO', '12345678901');

-- Inserindo dados na tabela Telefone
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11987654321', '12222222222');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11987654322', '12222222222');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '21987654323', '02222222220');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '21987654324', '02222222220');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '31987654325', '12345678901');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '31987654326', '12345678901');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '41987654327', '23456789012');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '41987654328', '23456789012');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '51987654329', '34567890123');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '51987654330', '34567890123');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '61987654331', '45678901234');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '61987654332', '45678901234');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '71987654333', '56789012345');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '71987654334', '56789012345');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '81987654335', '67890123456');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '81987654336', '67890123456');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '91987654337', '78901234567');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '91987654338', '78901234567');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '10198765439', '89012345678');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '10198765440', '89012345678');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11998765441', '90123456789');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11999765442', '90123456789');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '12198765443', '01234567890');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '12198765444', '01234567890');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '13198765445', '10987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '13198765446', '10987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '14198765447', '21987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '14198765448', '21987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '15198765449', '32987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '15198765450', '32987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '16198765451', '43987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '16198765452', '43987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '17198765453', '54987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '17198765454', '54987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '18198765455', '65987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '18198765456', '65987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '19198765457', '76987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '19198765458', '76987654321');

INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '20198765459', '87987654321');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '20198765460', '87987654321');

-- Inserindo dados na tabela Detento
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('98876543210', 'Bom', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'M', TO_DATE('1990-02-15', 'YYYY-MM-DD'), 'Carlos Eduardo');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('97765432109', 'Moderado', TO_DATE('2022-03-20', 'YYYY-MM-DD'), 'F', TO_DATE('1985-06-25', 'YYYY-MM-DD'), 'Mariana Costa');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('96654321098', 'Ruim', TO_DATE('2021-05-05', 'YYYY-MM-DD'), 'M', TO_DATE('1992-11-13', 'YYYY-MM-DD'), 'Pedro Santos');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('95543210987', 'Bom', TO_DATE('2020-07-12', 'YYYY-MM-DD'), 'F', TO_DATE('1988-09-22', 'YYYY-MM-DD'), 'Ana Paula');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('94432109876', 'Moderado', TO_DATE('2019-09-28', 'YYYY-MM-DD'), 'M', TO_DATE('1980-04-01', 'YYYY-MM-DD'), 'José Carlos');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('93321098765', 'Ruim', TO_DATE('2018-11-15', 'YYYY-MM-DD'), 'F', TO_DATE('1991-02-07', 'YYYY-MM-DD'), 'Fernanda Oliveira');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('92210987654', 'Bom', TO_DATE('2017-01-03', 'YYYY-MM-DD'), 'M', TO_DATE('1993-05-19', 'YYYY-MM-DD'), 'Lucas Pereira');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('91109876543', 'Moderado', TO_DATE('2016-02-20', 'YYYY-MM-DD'), 'F', TO_DATE('1989-07-04', 'YYYY-MM-DD'), 'Juliana Lima');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('90098765432', 'Ruim', TO_DATE('2015-04-14', 'YYYY-MM-DD'), 'M', TO_DATE('1987-12-25', 'YYYY-MM-DD'), 'Anderson Silva');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('89987654321', 'Bom', TO_DATE('2014-06-06', 'YYYY-MM-DD'), 'F', TO_DATE('1994-10-10', 'YYYY-MM-DD'), 'Bianca Torres');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('88876543210', 'Moderado', TO_DATE('2013-08-25', 'YYYY-MM-DD'), 'M', TO_DATE('1995-01-15', 'YYYY-MM-DD'), 'Rafael Almeida');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('87765432109', 'Ruim', TO_DATE('2012-10-31', 'YYYY-MM-DD'), 'F', TO_DATE('1990-03-30', 'YYYY-MM-DD'), 'Camila Rocha');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('86654321098', 'Bom', TO_DATE('2011-12-22', 'YYYY-MM-DD'), 'M', TO_DATE('1996-07-25', 'YYYY-MM-DD'), 'Felipe Souza');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('85543210987', 'Moderado', TO_DATE('2010-02-15', 'YYYY-MM-DD'), 'F', TO_DATE('1993-11-02', 'YYYY-MM-DD'), 'Leticia Azevedo');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('84432109876', 'Ruim', TO_DATE('2009-03-27', 'YYYY-MM-DD'), 'M', TO_DATE('1981-08-17', 'YYYY-MM-DD'), 'Gabriel Mendes');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('83321098765', 'Bom', TO_DATE('2008-05-30', 'YYYY-MM-DD'), 'F', TO_DATE('1992-09-09', 'YYYY-MM-DD'), 'Vanessa Ribeiro');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('82210987654', 'Moderado', TO_DATE('2007-07-11', 'YYYY-MM-DD'), 'M', TO_DATE('1997-02-21', 'YYYY-MM-DD'), 'Thiago Oliveira');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('81109876543', 'Ruim', TO_DATE('2006-09-18', 'YYYY-MM-DD'), 'F', TO_DATE('1986-10-16', 'YYYY-MM-DD'), 'Isabela Fernandes');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('80098765432', 'Bom', TO_DATE('2005-11-03', 'YYYY-MM-DD'), 'M', TO_DATE('1982-01-30', 'YYYY-MM-DD'), 'Ricardo Duarte');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('79987654321', 'Moderado', TO_DATE('2004-01-21', 'YYYY-MM-DD'), 'F', TO_DATE('1989-04-12', 'YYYY-MM-DD'), 'Patricia Lima');

-- Inserindo dados na tabela Guarda
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('12222222222', 'MATUTINO', '98876543210');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('23456789012', 'NOTURNO', '79987654321');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('34567890123', 'VESPERTINO', '80098765432');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('56789012345', 'NOTURNO', '81109876543');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('67890123456', 'VESPERTINO', '82210987654');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('78901234567', 'MATUTINO', '83321098765');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('89012345678', 'NOTURNO', '84432109876');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('90123456789', 'VESPERTINO', '85543210987');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('01234567890', 'MATUTINO', '86654321098');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('10987654321', 'NOTURNO', '87765432109');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('21987654321', 'VESPERTINO', '88876543210');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('32987654321', 'MATUTINO', '89987654321');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('43987654321', 'NOTURNO', '90098765432');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('54987654321', 'VESPERTINO', '91109876543');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('65987654321', 'MATUTINO', '92210987654');


-- Inserindo dados na tabela Detento

-- Inserindo dados na tabela Sentenca
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Roubo', '98876543210');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Assalto', '79987654321');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Roubo', '98876543210');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Lavagem de Dinheiro', '97765432109');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Homícidio', '96654321098');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Furto', '9665432109');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Assalto', '94432109876');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Tentativa de homicídio', '93321098765');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Latrocinio', '92210987654');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Roubo', '91109876543');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Tráfico', '90098765432');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Furto', '89987654321');

-- Inserindo dados na tabela Crime
INSERT INTO Crime (id_crime, crime, cpf_detento, duracao) VALUES (Sequencia_Geral.NEXTVAL, 'Roubo', '98876543210', 5);
INSERT INTO Crime (id_crime, crime, cpf_detento, duracao) VALUES (Sequencia_Geral.NEXTVAL, 'Assalto', '79987654321', 10);

-- Inserindo dados na tabela Visitante
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) VALUES ('Fiona Rocha', 'F', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '87765432109');
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) VALUES ('Vicente Pereira', 'M', TO_DATE('1985-11-25', 'YYYY-MM-DD'), '92210987654');



-- Inserindo dados na tabela Cela
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');


-- Inserindo dados na tabela Visita
INSERT INTO Visita (motivo, malfeitor, data_hora) VALUES ('Parente', '87765432109', TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Visita (motivo, malfeitor, data_hora) VALUES ('Conjuge', '92210987654', TO_DATE('2024-08-11 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Entrada
INSERT INTO Entrada (visitante, data_hora, nome, malfeitor) VALUES ('Fiona Rocha', TO_DATE('2024-08-10 13:50:00', 'YYYY-MM-DD HH24:MI:SS') '87765432109');
INSERT INTO Entrada (visitante, data_hora, nome, malfeitor) VALUES ('Vicente Pereira', TO_DATE('2024-08-11 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), '92210987654');

-- Inserindo dados na tabela Lugar
INSERT INTO Lugar (data_hora, sala) VALUES (TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 101);
INSERT INTO Lugar (data_hora, sala) VALUES (TO_DATE('2024-08-11 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 102);

-- Inserindo dados na tabela Possui
INSERT INTO Possui (malfeitor, cela, ala) VALUES ('87765432109', 1, 1);
INSERT INTO Possui (malfeitor, cela, ala) VALUES ('92210987654', 2, 1);
