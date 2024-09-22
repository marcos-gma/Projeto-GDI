SELECT REF(S)
FROM TB_SALA S
WHERE S.ID = 101; 

-- Usando DEREF para acessar os detalhes da relacionamento ternário a partir da referência
SELECT DEREF(P.DETENTO).nome AS PRESIDIARIO, 
       DEREF(P.ALA) AS localizacao
FROM TB_POSSUI P;

-- Acessando os elementos do VARRAY
SELECT C.TIPO, t.COLUMN_VALUE AS CELAS
FROM TB_CELAS C,
     TABLE(C.CELAS) t;


SELECT F.nome, T.COLUMN_VALUE AS TELEFONES
FROM TB_FUNCIONARIO F,
     TABLE(F.TELEFONES) T;
