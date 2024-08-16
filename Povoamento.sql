CREATE SEQUENCE Sequencia_Geral
START WITH 1
INCREMENT BY 1;

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
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Geral.NEXTVAL);





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
INSERT INTO Diretor (cpf_f, codigo, data_inicio) VALUES ('11111111111', Sequencia_Geral.NEXTVAL, TO_DATE('2020-01-10', 'YYYY-MM-DD'));

-- Inserindo dados na tabela Superintendente
INSERT INTO Superintendente (cpf_f, bonificacao, diretor) VALUES ('22222222222', 500, '11111111111');

-- Inserindo dados na tabela Ala
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) VALUES (Sequencia_Geral.NEXTVAL, 'M', 'MAXIMA', '22222222222');

-- Inserindo dados na tabela Telefone
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11987654321', '11111111111');
INSERT INTO Telefone (id, telefone, funcionario) VALUES (Sequencia_Geral.NEXTVAL, '11976543210', '22222222222');

-- Inserindo dados na tabela Guarda
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('33333333333', 'NOTURNO', '22222222222');
INSERT INTO Guarda (cpf_f, turno, supervisionado) VALUES ('44444444444', 'MATUTINO', '11111111111');


-- Inserindo dados na tabela Detento
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('55555555555', 'Bom', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 'M', TO_DATE('1995-04-12', 'YYYY-MM-DD'), 'Carlos Alberto');
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) VALUES ('66666666666', 'Ruim', TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'F', TO_DATE('1988-07-25', 'YYYY-MM-DD'), 'Ana Maria');

-- Inserindo dados na tabela Sentenca
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Roubo', '55555555555');
INSERT INTO Sentenca (crime, cpf_detento) VALUES ('Assalto', '66666666666');

-- Inserindo dados na tabela Crime
INSERT INTO Crime (id_crime, crime, cpf_detento, duracao) VALUES (Sequencia_Geral.NEXTVAL, 'Roubo', '55555555555', 5);
INSERT INTO Crime (id_crime, crime, cpf_detento, duracao) VALUES (Sequencia_Geral.NEXTVAL, 'Assalto', '66666666666', 10);

-- Inserindo dados na tabela Visitante
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) VALUES ('Juliana Souza', 'F', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '55555555555');
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) VALUES ('Pedro Lima', 'M', TO_DATE('1985-11-25', 'YYYY-MM-DD'), '66666666666');



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
INSERT INTO Visita (motivo, malfeitor, data_hora) VALUES ('Família', '55555555555', TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO Visita (motivo, malfeitor, data_hora) VALUES ('Amigos', '66666666666', TO_DATE('2024-08-11 15:30:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Inserindo dados na tabela Entrada
INSERT INTO Entrada (visitante, data_hora, nome, malfeitor) VALUES ('Juliana Souza', TO_DATE('2024-08-10 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), 'Juliana Souza', '55555555555');
INSERT INTO Entrada (visitante, data_hora, nome, malfeitor) VALUES ('Pedro Lima', TO_DATE('2024-08-11 15:20:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pedro Lima', '66666666666');

-- Inserindo dados na tabela Lugar
INSERT INTO Lugar (data_hora, sala) VALUES (TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 101);
INSERT INTO Lugar (data_hora, sala) VALUES (TO_DATE('2024-08-11 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 102);

-- Inserindo dados na tabela Possui
INSERT INTO Possui (malfeitor, cela, ala) VALUES ('55555555555', 1, 1);
INSERT INTO Possui (malfeitor, cela, ala) VALUES ('66666666666', 2, 1);
