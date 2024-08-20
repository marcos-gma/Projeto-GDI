ALTER TABLE Detento
rename to Presidiario;

ALTER TABLE Presidiario
rename to Detento;

CREATE INDEX idx_nome_visitante ON Visitante(nome);
  
UPDATE Detento
SET comportamento = 'Excelente'
WHERE cpf = '92210987654';
    
DELETE FROM Funcionario
WHERE nome = '01234567890';
    
SELECT * FROM Ala
WHERE nivel_seg = 'PADRAO';
    
SELECT id_crime, crime, duracao
FROM Crime
WHERE duracao BETWEEN 5 AND 10;

SELECT nome, cpf
FROM Detento
WHERE cpf IN ('12345678901', '80098765432', '92210987654');
    
SELECT nome, cpf
FROM Detento
WHERE nome LIKE 'Jo%';

    
SELECT cpf, nome
FROM Funcionario
WHERE cep IS NOT NULL;

    
SELECT D.nome, S.crime
FROM Detento D
INNER JOIN Sentenca S ON D.cpf = S.cpf_detento;

    
SELECT MAX(duracao) AS duracao_maxima
FROM Crime;

SELECT MIN(salario) AS salario_minimo
FROM Funcionario;

SELECT AVG(salario) AS salario_medio
FROM Funcionario;

SELECT AVG(salario) AS salario_medio
FROM Funcionario;
  
SELECT S.bonificacao, D.cpf_f 
FROM DIRETOR D
FULL OUTER JOIN Superintendente S ON S.cpf_f = D.cpf_f;
    
SELECT nome, cpf
FROM Detento
WHERE cpf IN (
    SELECT malfeitor
    FROM Possui
    WHERE cela = (
        SELECT MIN(id_cela)
        FROM Cela
    )
);

SELECT nome, cpf
FROM Detento
WHERE cpf IN (
    SELECT malfeitor
    FROM Visitante
);

SELECT nome, cpf
FROM Detento
WHERE cpf IN (
    SELECT cpf_detento
    FROM Crime
    WHERE duracao > ANY (
        SELECT AVG(duracao)
        FROM Crime
    )
);

SELECT nome, cpf
FROM Detento
WHERE cpf IN (
    SELECT cpf_detento
    FROM Crime
    WHERE duracao > ALL (
        SELECT duracao
        FROM Crime
        WHERE cpf_detento <> Crime.cpf_detento)
);


SELECT cpf, SUM(salario * 2) AS total_salario_dobrado 
FROM Funcionario 
GROUP BY cpf 
HAVING SUM(salario * 2) < 10000;

SELECT cpf, nome, NULL AS data_ent, NULL AS comportamento
FROM Detento
UNION
SELECT cpf, nome, NULL AS data_ent, NULL AS comportamento
FROM Funcionario;

CREATE VIEW visualizar_detentos AS 
SELECT NOME, CPF  
FROM DETENTO 
WHERE DATA_ENT BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') AND TO_DATE('2024-01-31', 'YYYY-MM-DD');
