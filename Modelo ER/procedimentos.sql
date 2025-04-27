-- trigger para definir o valor padrão de data_saida como data_ent -> por causa do oracle
DROP TRIGGER trg_set_data_saida;

CREATE OR REPLACE TRIGGER trg_set_data_saida
BEFORE INSERT ON Detento
FOR EACH ROW
BEGIN
    IF :NEW.data_saida IS NULL THEN
        :NEW.data_saida := :NEW.data_ent;
    END IF;
END;
/

-- trigger para atualizar a data de saída: não dá erro da tabela mutante pq usa cursor para percorrer os detentos e não FOR EACH ROW
DROP TRIGGER atualizar_data_saida;

CREATE OR REPLACE TRIGGER atualizar_data_saida
AFTER INSERT OR UPDATE OR DELETE ON Sentenca
DECLARE
    -- cursor para obter todos os detentos com sentenças
    CURSOR c_detentos IS 
        SELECT DISTINCT cpf_detento FROM Sentenca; 
    v_duracao_total NUMBER; -- armazena duração total da sentença
BEGIN
    -- para cada detento com sentença retornado pelo cursor
    FOR detento IN c_detentos LOOP
        -- soma todas as sentenças do detento
        SELECT NVL(SUM(duracao), 0) INTO v_duracao_total -- NVL: se não houver sentenças, retorna 0
        FROM Sentenca
        WHERE cpf_detento = detento.cpf_detento;

        -- atualiza a data de saída no Detento
        UPDATE Detento
        SET data_saida = LEAST(ADD_MONTHS(data_ent, v_duracao_total * 12), ADD_MONTHS(data_ent, 30 * 12)) -- min entre 30 anos e data_ent + duracao_total
        WHERE cpf = detento.cpf_detento;
    END LOOP;
END;
/


-- teste: outro detento com sentenças diferentes
select * from Detento;

INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome)
VALUES ('98765432100', 'Excelente', TO_DATE('15-03-2021', 'DD-MM-YYYY'), NULL, 'M', TO_DATE('10-10-1990', 'DD-MM-YYYY'), 'Chicó');

select * from Detento;

INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Homicídio', '98765432100', 10); -- 10 anos de sentença

select * from Detento;

INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Tráfico', '98765432100', 4); -- +4 anos = total de 14 anos de sentença

select * from Detento;

INSERT INTO Sentenca (crime, cpf_detento, duracao)
VALUES ('Ser bonito demais', '98765432100', 29); -- +29 anos = total de 14 + 29 = 43

select * from Detento;

-- delete para testar trigger
DELETE FROM Sentenca
WHERE cpf_detento = (SELECT cpf FROM Detento WHERE nome = 'Chicó');

DELETE FROM Detento
WHERE nome = 'Chicó';

SELECT * FROM Detento;

-- Crie um procedimento armazenado que verifique se durante a alocação de um detento em uma cela se sua capacidade máxima já foi atingida;
CREATE OR REPLACE PROCEDURE verificar_capacidade_cela (
    p_id_cela IN NUMBER
) AS
    v_capacidade_max NUMBER;
    v_ocupacao_atual NUMBER;
BEGIN
    -- Obtém a capacidade máxima da cela
    SELECT capacidade INTO v_capacidade_max
    FROM Tipo_Cela tc
    JOIN Cela c ON tc.tipo_cela = c.tipo
    WHERE c.id_cela = p_id_cela;

    -- Conta o número de detentos atualmente alocados na cela
    SELECT COUNT(*) INTO v_ocupacao_atual
    FROM Possui
    WHERE cela = p_id_cela;

    -- Verifica se a capacidade máxima foi atingida
    IF v_ocupacao_atual >= v_capacidade_max THEN
        RAISE_APPLICATION_ERROR(-20001, 'Capacidade máxima da cela atingida.');
    END IF;
END;
/

-- teste: verificar capacidade da cela
-- Informações sobre as celas e sua ocupação atual
SELECT c.ID_CELA, c.tipo, tp_c.capacidade, NVL(ocupacao_atual, 0) AS ocupacao_atual
FROM cela c
JOIN tipo_cela tp_c ON c.tipo = tp_c.tipo_cela
JOIN (
    -- Contar quantos detentos tem em cada cela
    SELECT cela, COUNT(*) AS ocupacao_atual
    FROM Possui
    ) ocupacao ON c.ID_CELA = ocupacao.cela;
    
-- Inserindo novos detentos na cela pra testar a capacidade
BEGIN
    INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome)
    VALUES ('11101129476', 'Bom', TO_DATE('01-01-2023', 'DD-MM-YYYY'), NULL, 'M', TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'Gabriel Rocha');

    INSERT INTO Possui (malfeitor, cela, ala)
    VALUES ('11101129476', 35, 1);

    INSERT INTO Detento (cpf, comportamento, data_ent, data_saida, sexo, data_nasc, nome)
    VALUES ('65889673491', 'Excelente', TO_DATE('02-02-2023', 'DD-MM-YYYY'), NULL, 'F', TO_DATE('02-02-1992', 'DD-MM-YYYY'), 'Duda lopes');

    INSERT INTO Possui (malfeitor, cela, ala)
    VALUES ('65889673491', 35, 1);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM); -- Exibe o erro caso a capacidade máxima seja atingida
END;
/

-- Removendo os comandos de inserção de detentos na cela para testar a capacidade
DELETE FROM Possui
WHERE malfeitor = '65889673491' AND cela = 35 AND ala = 1;

DELETE FROM Possui
WHERE malfeitor = '11101129476' AND cela = 35 AND ala = 1;
