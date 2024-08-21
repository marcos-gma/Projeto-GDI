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

--FUNCTION
CREATE OR REPLACE FUNCTION calcular_salario_anual(salario_mensal IN NUMBER) 
RETURN NUMBER 
IS
    salario_anual NUMBER;
BEGIN
    salario_anual := salario_mensal * 13;
    RETURN salario_anual;
END;
--usando a function
DECLARE
    salario NUMBER := 3000;
    salario_total NUMBER;
BEGIN
    salario_total := calcular_salario_anual(salario);
    DBMS_OUTPUT.PUT_LINE('Salário anual: ' || salario_total);
END;

--%TYPE
DECLARE
    v_nome       Funcionario.nome%TYPE;
    v_salario    Funcionario.salario%TYPE;
BEGIN
    SELECT nome, salario 
    INTO v_nome, v_salario 
    FROM Funcionario 
    WHERE cpf = '23456789012';
    
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Salário: ' || v_salario);
END;

--%ROWTYPE
DECLARE
    -- Declara uma variável para armazenar uma linha da tabela Funcionario
    v_fun Funcionario%ROWTYPE;
BEGIN
    -- Seleciona todos os campos da tabela Funcionario para o CPF fornecido
    SELECT * INTO v_fun 
    FROM Funcionario 
    WHERE cpf = '23456789012';
    
    -- Exibe as informações do funcionário selecionado
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_fun.nome);
    DBMS_OUTPUT.PUT_LINE('Salário: ' || v_fun.salario);
    DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || TO_CHAR(v_fun.data_nasc, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Sexo: ' || v_fun.sexo);
    DBMS_OUTPUT.PUT_LINE('Data de Admissão: ' || TO_CHAR(v_fun.data_admi, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('CEP: ' || v_fun.cep);
EXCEPTION
    -- Trata o caso em que nenhum registro é encontrado
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionário encontrado com o CPF informado.');
    -- Trata outros possíveis erros
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;

--IF-ELSE
CREATE OR REPLACE FUNCTION categoria_salarial(salario IN NUMBER)
RETURN VARCHAR2
IS
    categoria VARCHAR2(20);
BEGIN
    IF salario < 2000 THEN
        categoria := 'Abaixo da média';
    ELSIF salario BETWEEN 2000 AND 4000 THEN
        categoria := 'Na média';
    ELSE
        categoria := 'Acima da média';
    END IF;
    RETURN categoria;
END;
DECLARE
    salario NUMBER := 2500;
    resultado VARCHAR2(20);
BEGIN
    resultado := categoria_salarial(salario);
    DBMS_OUTPUT.PUT_LINE('Categoria salarial: ' || resultado);
END;

--CURSOR
DECLARE
    CURSOR funcionario_cursor IS
        SELECT cpf, nome, salario
        FROM Funcionario;
    
    v_funcionario funcionario_cursor%ROWTYPE;
    v_categoria VARCHAR2(20);
BEGIN
    -- Abrir o cursor para ler os dados da tabela Funcionario
    OPEN funcionario_cursor;
    
    -- Loop para processar cada registro do cursor
    LOOP
        FETCH funcionario_cursor INTO v_funcionario;
        EXIT WHEN funcionario_cursor%NOTFOUND;
        
        -- Determina a categoria salarial usando a função
        v_categoria := categoria_salarial(v_funcionario.salario);
        
        -- Exibe as informações do funcionário e sua categoria salarial
        DBMS_OUTPUT.PUT_LINE('CPF: ' || v_funcionario.cpf);
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_funcionario.nome);
        DBMS_OUTPUT.PUT_LINE('Salário: ' || v_funcionario.salario);
        DBMS_OUTPUT.PUT_LINE('Categoria salarial: ' || v_categoria);
        DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    END LOOP;   
    -- Fechar o cursor após o processamento
    CLOSE funcionario_cursor;
END;


--CASE WHEN
DECLARE
    v_tipo VARCHAR2(15);
    v_mensagem VARCHAR2(100);
BEGIN
    SELECT tipo INTO v_tipo FROM Cela WHERE id_cela = 49; -- Exemplo com cela de ID 1

    v_mensagem := CASE 
                    WHEN v_tipo = 'SOLITARIA' THEN 'Cela de isolamento para criminosos que apresentaram comportamento violento, Protocolo X401087@.'
                    WHEN v_tipo = 'REGULAR' THEN 'Cela regular, Protocolo 99#.'
                    ELSE 'Tipo de cela desconhecido.'
                  END;

    DBMS_OUTPUT.PUT_LINE(v_mensagem);
END;

--LOOP EXIT WHEN
DECLARE
    v_comportamento VARCHAR2(35);
    v_nome Detento.nome%TYPE;
BEGIN
    FOR r IN (SELECT nome, comportamento FROM Detento) LOOP
        IF r.comportamento = 'Bom' THEN
            v_nome := r.nome;
            EXIT; -- Sai do loop ao encontrar o primeiro detento com comportamento 'Bom'
        END IF;
    END LOOP;

    IF v_nome IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('presidiario apresentado bom comportamento: ' || v_nome);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum detento com comportamento Bom encontrado.');
    END IF;
END;

--WHILE LOOP
DECLARE
    v_avg_salary NUMBER;
    v_increment NUMBER := 100; -- Valor do incremento do salário
BEGIN
    -- Calcula o salário médio inicial
    SELECT AVG(salario) INTO v_avg_salary FROM Funcionario;

    -- Enquanto o salário médio for menor que 3000, continue incrementando
    WHILE v_avg_salary < 3000 LOOP
        -- Incrementa os salários
        IF (v_avg_salary < 1800) THEN
            UPDATE Funcionario
            SET salario = salario + v_increment;
            
            -- Recalcula o salário médio
            SELECT AVG(salario) INTO v_avg_salary FROM Funcionario;
            DBMS_OUTPUT.PUT_LINE('Novo salário médio: ' || v_avg_salary);
		ELSE 
            v_avg_salary := 3000;
		END IF;
    END LOOP;
END;

--FOR LOOP
DECLARE 
BEGIN
    FOR r IN (SELECT crime, cpf_detento FROM Sentenca) LOOP
        DBMS_OUTPUT.PUT_LINE('Crime: ' || r.crime || ' | CPF Detento: ' || r.cpf_detento);
    END LOOP;
END;

--SELECT INTO
DECLARE
    v_nome Detento.nome%TYPE;
    v_cpf Detento.cpf%TYPE;
    v_comportamento Detento.comportamento%TYPE;
BEGIN
    SELECT nome, cpf, comportamento 
    INTO v_nome, v_cpf, v_comportamento
    FROM Detento
    WHERE ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('CPF: ' || v_cpf);
    DBMS_OUTPUT.PUT_LINE('Comportamento: ' || v_comportamento);
END;

--EXCEPTION WHEN
DECLARE
    v_cpf Detento.cpf%TYPE := '12345678901';
    v_nome Detento.nome%TYPE := 'João Silva';
BEGIN
    -- Tentativa de inserção de um detento
    INSERT INTO Detento (cpf, nome, sexo, data_nasc, data_ent)
    VALUES (v_cpf, v_nome, 'M', TO_DATE('1990-01-01', 'YYYY-MM-DD'), SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Detento inserido com sucesso!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erro: CPF já cadastrado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;

--IN, OUT
CREATE OR REPLACE PROCEDURE obter_dados_detento (
    p_cpf IN Detento.cpf%TYPE,
    p_nome OUT Detento.nome%TYPE,
    p_comportamento OUT Detento.comportamento%TYPE
)
IS
BEGIN
    SELECT nome, comportamento
    INTO p_nome, p_comportamento
    FROM Detento
    WHERE cpf = p_cpf;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nenhum detento encontrado com o CPF: ' || p_cpf);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;

--PACKAGES
CREATE OR REPLACE PACKAGE detento_pkg AS
    PROCEDURE inserir_detento(
        p_cpf IN Detento.cpf%TYPE,
        p_nome IN Detento.nome%TYPE,
        p_sexo IN Detento.sexo%TYPE,
        p_data_nasc IN Detento.data_nasc%TYPE,
        p_data_ent IN Detento.data_ent%TYPE
    );

    FUNCTION obter_nome_detento(p_cpf IN Detento.cpf%TYPE) RETURN Detento.nome%TYPE;
END detento_pkg;

CREATE OR REPLACE PACKAGE BODY detento_pkg AS
    PROCEDURE inserir_detento(
        p_cpf IN Detento.cpf%TYPE,
        p_nome IN Detento.nome%TYPE,
        p_sexo IN Detento.sexo%TYPE,
        p_data_nasc IN Detento.data_nasc%TYPE,
        p_data_ent IN Detento.data_ent%TYPE
    ) IS
    BEGIN
        INSERT INTO Detento (cpf, nome, sexo, data_nasc, data_ent)
        VALUES (p_cpf, p_nome, p_sexo, p_data_nasc, p_data_ent);

        DBMS_OUTPUT.PUT_LINE('Detento inserido com sucesso!');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Erro: CPF já cadastrado.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
    END inserir_detento;

    FUNCTION obter_nome_detento(p_cpf IN Detento.cpf%TYPE) RETURN Detento.nome%TYPE IS
        v_nome Detento.nome%TYPE;
    BEGIN
        SELECT nome INTO v_nome FROM Detento WHERE cpf = p_cpf;
        RETURN v_nome;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nenhum detento encontrado com o CPF: ' || p_cpf);
            RETURN NULL;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
            RETURN NULL;
    END obter_nome_detento;
END detento_pkg;

--TRIGGERS
CREATE OR REPLACE TRIGGER trg_limite_cela
BEFORE INSERT ON Possui
DECLARE
    v_capacidade NUMBER;
    v_ocupantes NUMBER;
    v_cela Possui.cela%TYPE;
BEGIN
    -- Cursor para iterar sobre as novas inserções
    FOR r IN (SELECT cela FROM Possui WHERE ROWID IN (SELECT ROWID FROM Possui WHERE ROWNUM = 1)) LOOP
        v_cela := r.cela;

        SELECT capacidade INTO v_capacidade 
        FROM Tipo_Cela 
        WHERE tipo_cela = (SELECT tipo FROM Cela WHERE id_cela = v_cela);

        SELECT COUNT(*) INTO v_ocupantes 
        FROM Possui 
        WHERE cela = v_cela;

        -- Verificar se a capacidade será excedida
        IF v_ocupantes >= v_capacidade THEN
            RAISE_APPLICATION_ERROR(-20001, 'A cela ' || v_cela || ' já atingiu sua capacidade máxima.');
        END IF;
    END LOOP;
END trg_limite_cela;

CREATE OR REPLACE TRIGGER trg_limite_cela_linha
BEFORE INSERT ON Possui
FOR EACH ROW
DECLARE
    v_capacidade NUMBER;
    v_ocupantes NUMBER;
BEGIN
    -- Obter a capacidade da cela
    SELECT capacidade INTO v_capacidade 
    FROM Tipo_Cela 
    WHERE tipo_cela = (SELECT tipo FROM Cela WHERE id_cela = :NEW.cela);

    -- Contar o número de detentos na cela
    SELECT COUNT(*) INTO v_ocupantes 
    FROM Possui 
    WHERE cela = :NEW.cela;

    -- Verificar se a capacidade foi excedida
    IF v_ocupantes >= v_capacidade THEN
        RAISE_APPLICATION_ERROR(-20001, 'A cela já atingiu sua capacidade máxima.');
    END IF;
END trg_limite_cela_linha;
