-- DROP TABLES
DROP TABLE TB_TELEFONES;
DROP TABLE TB_ENDERECO;
DROP TABLE TB_FUNCIONARIO;
DROP TABLE TB_DIRETOR;
DROP TABLE TB_GUARDA;
DROP TABLE TB_SUPERINTENDENTE;
DROP TABLE TB_LISTA_DE_CELAS;
DROP TABLE TB_ALA;
DROP TABLE TB_DETENTO;
DROP TABLE TB_VISITA;
DROP TABLE TB_CELA;
DROP TABLE TB_POSSUI;
DROP TABLE TB_TIPO_CELA;
DROP TABLE TB_SALA;
DROP TABLE TB_VISITANTE;
DROP TABLE TB_ENTRADA;
DROP TABLE TB_LOCAL;
DROP TABLE TB_CRIME;
DROP TABLE TB_SENTENCA;

-- tenta criar as tabelas e imprime o erro caso ocorra
BEGIN
    -- Tentar criar as tabelas e imprimir o status

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_TELEFONES OF TELEFONES_NESTED (
            COLUMN_VALUE VARCHAR2(15) -- CHECAR
        ) NESTED TABLE TELEFONES STORE AS TB_TELEFONES;
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_TELEFONES criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_TELEFONES: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_ENDERECO OF TP_ENDERECO (
                CEP PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_ENDERECO criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_ENDERECO: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_FUNCIONARIOS OF TP_FUNCIONARIO (
            CONSTRAINT pk_funcionario PRIMARY KEY (CPF)
        ) NESTED TABLE TELEFONES STORE AS TB_TELEFONES;
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_FUNCIONARIO criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_FUNCIONARIO: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_DIRETOR OF TP_DIRETOR (
                CPF PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_DIRETOR criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_DIRETOR: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_GUARDA OF TP_GUARDA (
                CPF PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_GUARDA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_GUARDA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_SUPERINTENDENTE OF TP_SUPERINTENDENTE (
                CPF PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_SUPERINTENDENTE criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_SUPERINTENDENTE: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_LISTA_DE_CELAS OF LISTA_DE_CELAS ()
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_LISTA_DE_CELAS criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_LISTA_DE_CELAS: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_ALA OF TP_ALA (
                ID PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_ALA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_ALA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_DETENTO OF TP_DETENTO (
                CPF PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_DETENTO criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_DETENTO: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_VISITA OF TP_VISITA (
                DETENTO PRIMARY KEY REFERENCES TB_DETENTO(CPF)
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_VISITA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_VISITA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_CELA OF TP_CELA (
                ID PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_CELA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_CELA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_POSSUI OF TP_POSSUI (
                DETENTO PRIMARY KEY REFERENCES TB_DETENTO(CPF),
                ALA PRIMARY KEY REFERENCES TB_ALA(ID),
                CELA PRIMARY KEY REFERENCES TB_CELA(ID)
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_POSSUI criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_POSSUI: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_TIPO_CELA OF TP_TIPO_CELA (
                TIPO_CELA PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_TIPO_CELA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_TIPO_CELA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_SALA OF TP_SALA (
                ID PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_SALA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_SALA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_VISITANTE OF TP_VISITANTE (
                CPF PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_VISITANTE criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_VISITANTE: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_ENTRADA OF TP_ENTRADA (
                DETENTO PRIMARY KEY REFERENCES TB_DETENTO(CPF),
                VISITANTE PRIMARY KEY REFERENCES TB_VISITANTE(CPF),
                DATA_HORA PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_ENTRADA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_ENTRADA: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_LOCAL OF TP_LOCAL (
                DATA_HORA PRIMARY KEY,
                SALA REFERENCES TB_SALA(ID)
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_LOCAL criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_LOCAL: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_CRIME OF TP_CRIME (
                ID_CRIME PRIMARY KEY
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_CRIME criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_CRIME: ' || SQLERRM || CHR(10));
    END;

    BEGIN
        EXECUTE IMMEDIATE '
            CREATE TABLE TB_SENTENCA OF TP_SENTENCA (
                DETENTO PRIMARY KEY REFERENCES TB_DETENTO(CPF),
                CRIME PRIMARY KEY REFERENCES TB_CRIME(ID_CRIME)
            )
        ';
        DBMS_OUTPUT.PUT_LINE('Tabela TB_SENTENCA criada com sucesso.' || CHR(10));
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao criar a tabela TB_SENTENCA: ' || SQLERRM || CHR(10));
    END;
END;
/
