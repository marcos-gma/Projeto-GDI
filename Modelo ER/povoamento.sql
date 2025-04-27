-- Sequência de números para serem usados como chave primária (id)
DROP SEQUENCE Sequencia_Geral;
DROP SEQUENCE Sequencia_Sala;

CREATE SEQUENCE Sequencia_Geral
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE Sequencia_Sala
START WITH 101
INCREMENT BY 1;

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('12345678', 'Rua Machu Pichu', 100, 'Centro');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('23456789', 'Rua Cristo Redentor', 200, 'Jardins');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('34567890', 'Rua Torre Eiffel', 300, 'Vila Nova');
INSERT INTO Endereco (cep, rua, numero, bairro) VALUES ('45678901', 'Rua Estátua da Liberdade', 400, 'Centro Histórico');

-- Inserindo dados na tabela Tipo_Cela
INSERT INTO Tipo_Cela (tipo_cela, capacidade) VALUES ('REGULAR', 4);
INSERT INTO Tipo_Cela (tipo_cela, capacidade) VALUES ('SOLITARIA', 1);
INSERT INTO Tipo_Cela (tipo_cela, capacidade) VALUES ('DUPLA', 2);

-- Inserindo dados na tabela Cela
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'DUPLA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'REGULAR');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');
INSERT INTO Cela (id_cela, tipo) VALUES (Sequencia_Geral.NEXTVAL, 'SOLITARIA');

-- Inserindo dados na tabela Sala_visita
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);
INSERT INTO Sala_visita (id) VALUES (Sequencia_Sala.NEXTVAL);

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) 
VALUES ('12222222222', 'João Silva', TO_DATE('1980-01-01', 'YYYY-MM-DD'), 'M', 3000, TO_DATE('2010-05-15', 'YYYY-MM-DD'), '12345678');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep) 
VALUES ('13333333333', 'Maria Oliveira', TO_DATE('1985-03-10', 'YYYY-MM-DD'), 'F', 3500, TO_DATE('2015-07-20', 'YYYY-MM-DD'), '23456789');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep)
VALUES ('14444444444', 'José Santos', TO_DATE('1975-07-20', 'YYYY-MM-DD'), 'M', 4000, TO_DATE('2005-10-25', 'YYYY-MM-DD'), '34567890');
INSERT INTO Funcionario (cpf, nome, data_nasc, sexo, salario, data_admi, cep)
VALUES ('15555555555', 'Ana Souza', TO_DATE('1990-11-30', 'YYYY-MM-DD'), 'F', 3200, TO_DATE('2018-12-01', 'YYYY-MM-DD'), '45678901');


-- Inserindo dados na tabela Diretor
INSERT INTO Diretor (cpf_f, codigo, data_inicio) 
VALUES ('12222222222', 1, TO_DATE('2020-01-10', 'YYYY-MM-DD'));
INSERT INTO Diretor (cpf_f, codigo, data_inicio) 
VALUES ('13333333333', 2, TO_DATE('2021-06-15', 'YYYY-MM-DD'));

-- Inserindo dados na tabela Superintendente
INSERT INTO Superintendente (cpf_f, bonificacao, diretor) 
VALUES ('14444444444', 500, 1);
INSERT INTO Superintendente (cpf_f, bonificacao, diretor) 
VALUES ('15555555555', 600, 2);


-- Inserindo dados na tabela Guarda
INSERT INTO Guarda (cpf_f, turno, supervisionado)
VALUES ('12222222222', 'NOTURNO', NULL);
INSERT INTO Guarda (cpf_f, turno, supervisionado)
VALUES ('14444444444', 'MATUTINO', '12222222222');
INSERT INTO Guarda (cpf_f, turno, supervisionado)
VALUES ('13333333333', 'NOTURNO', NULL);
INSERT INTO Guarda (cpf_f, turno, supervisionado)
VALUES ('15555555555', 'VESPERTINO', '13333333333');


-- Inserindo dados na tabela Ala
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) 
VALUES (Sequencia_Geral.NEXTVAL, 'M', 'MAXIMA', '12222222222');
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) 
VALUES (Sequencia_Geral.NEXTVAL, 'F', 'MEDIA', '13333333333');

-- Inserindo dados na tabela Telefone
INSERT INTO Telefone (id, telefone, funcionario) 
VALUES (Sequencia_Geral.NEXTVAL, '11987654321', '12222222222');
INSERT INTO Telefone (id, telefone, funcionario) 
VALUES (Sequencia_Geral.NEXTVAL, '11912345678', '13333333333');

-- Inserindo dados na tabela Detento
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('98876543210', 'Bom', TO_DATE('2023-01-10', 'YYYY-MM-DD'), NULL, 'M', TO_DATE('1990-02-15', 'YYYY-MM-DD'), 'Carlos Eduardo');
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('97765432109', 'Regular', TO_DATE('2022-05-20', 'YYYY-MM-DD'), NULL, 'F', TO_DATE('1988-07-25', 'YYYY-MM-DD'), 'Ana Paula');
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('96654321098', 'Ótimo', TO_DATE('2021-03-15', 'YYYY-MM-DD'), NULL, 'M', TO_DATE('1985-09-10', 'YYYY-MM-DD'), 'João Pedro');
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('95543210987', 'Ruim', TO_DATE('2020-12-01', 'YYYY-MM-DD'), NULL, 'F', TO_DATE('1992-06-30', 'YYYY-MM-DD'), 'Mariana Silva');
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('94432109876', 'Bom', TO_DATE('2023-07-20', 'YYYY-MM-DD'), NULL, 'M', TO_DATE('1995-04-18', 'YYYY-MM-DD'), 'Lucas Almeida');
INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome) 
VALUES ('93321098765', 'Regular', TO_DATE('2021-11-05', 'YYYY-MM-DD'), NULL, 'F', TO_DATE('1987-01-22', 'YYYY-MM-DD'), 'Fernanda Costa');

-- Inserindo dados na tabela Sentenca
INSERT INTO Sentenca (crime, cpf_detento, duracao) 
VALUES ('Roubo', '98876543210', 5);
INSERT INTO Sentenca (crime, cpf_detento, duracao) 
VALUES ('Furto', '97765432109', 3);

-- Inserindo dados na tabela Visitante
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) 
VALUES ('Fiona Rocha', 'F', TO_DATE('1990-05-10', 'YYYY-MM-DD'), '98876543210');
INSERT INTO Visitante (nome, sexo, data_nasc, malfeitor) 
VALUES ('Pedro Santos', 'M', TO_DATE('1985-11-15', 'YYYY-MM-DD'), '97765432109');

-- Inserindo dados na tabela Visita
INSERT INTO Visita (motivo, malfeitor, data_hora, visitante, sala_visita) 
VALUES ('Parente', '98876543210', TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Fiona Rocha', 101);
INSERT INTO Visita (motivo, malfeitor, data_hora, visitante, sala_visita)
VALUES ('Amigo(a)', '97765432109', TO_DATE('2024-08-10 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pedro Santos', 102);

-- Inserindo dados na tabela Possui
INSERT INTO Possui (malfeitor, cela, ala) 
VALUES ('98876543210', 21, 4);
INSERT INTO Possui (malfeitor, cela, ala) 
VALUES ('97765432109', 22, 5);

-- Inserindo dados na tabela Sentenca
INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Homicídio', '98876543210', 10); -- 10 anos de sentença
INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Tráfico', '98876543210', 4); -- +4 anos = total de 14 anos de sentença
INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Homicídio', '97765432109', 8); -- 8 anos de sentença

-- Inserindo para teste de consulta 3
-- Inserindo um detento
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) 
VALUES ('12345678901', 'Bom', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'M', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'João Silva');

-- Inserindo uma cela
INSERT INTO Cela (id_cela, tipo) 
VALUES (35, 'REGULAR');

-- Inserindo uma ala
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) 
VALUES (1, 'M', 'MEDIA', '98765432101');

-- Associando o detento à cela e à ala
INSERT INTO Possui (malfeitor, cela, ala) 
VALUES ('12345678901', 35, 1);

-- Inserindo uma sentença para o detento
INSERT INTO Sentenca (crime, cpf_detento, duracao) 
VALUES ('Assalto a banco', '12345678901', 10);

-- Inserindo um detento
INSERT INTO Detento (cpf, comportamento, data_ent, sexo, data_nasc, nome) 
VALUES ('12345678901', 'Bom', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'M', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'João Silva');

-- Inserindo uma cela
INSERT INTO Cela (id_cela, tipo) 
VALUES (35, 'REGULAR');

-- Inserindo uma ala
INSERT INTO Ala (id, tipo, nivel_seg, autoridade) 
VALUES (1, 'M', 'MEDIA', '98765432101');

-- Associando o detento à cela e à ala
INSERT INTO Possui (malfeitor, cela, ala) 
VALUES ('12345678901', 35, 1);

-- Inserindo uma sentença para o detento
INSERT INTO Sentenca (crime, cpf_detento, duracao) 
VALUES ('Assalto a banco', '12345678901', 10);


