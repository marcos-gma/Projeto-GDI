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

--CONSULTAS PL/SQL

--RECORD
DECLARE
    TYPE r_detento_type 
    IS 
    RECORD (
        nome Detento.nome%TYPE,
        cpf Detento.cpf%TYPE
    );
    r_detento_info r_detento_type;
BEGIN
    SELECT nome, cpf INTO r_detento_info
    FROM Detento
    WHERE cpf = '95543210987';
    
    DBMS_OUTPUT.PUT_LINE('Nome: ' || r_detento_info.nome || ' CPF: ' || r_detento_info.cpf);
END;

--TABELA ASSOCIATIVA
DECLARE
    TYPE tabela_nome IS TABLE OF Detento.nome%TYPE INDEX BY PLS_INTEGER;
    nomes tabela_nome;
    i PLS_INTEGER := 1;
BEGIN
    FOR pessoa IN (SELECT nome FROM Detento) LOOP
        nomes(i) := pessoa.nome;
        i := i + 1;
    END LOOP;
    
    FOR presidiario IN 1..nomes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: ' || nomes(presidiario));
    END LOOP;
END;

--BLOCO ANÔNIMO
BEGIN
    DBMS_OUTPUT.PUT_LINE('Bloco anônimo criado.');
END;

--PROCEDURE
CREATE OR REPLACE PROCEDURE imprimir_salas (
    id_Sala_visita NUMBER
)     
IS
    r_salas Sala_visita%ROWTYPE;
BEGIN
  -- Buscando os dados da sala especificada
  SELECT *
  INTO r_salas
  FROM Sala_visita
  WHERE id = id_Sala_visita;

  -- Exibindo os valores dos campos
  dbms_output.put_line('ID da Sala: ' || r_salas.id);

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('Nenhuma sala encontrada com esse ID. Lembre que só existem salas de 101 - 110');
   WHEN OTHERS THEN
      dbms_output.put_line('Erro: ' || SQLERRM);
END;

