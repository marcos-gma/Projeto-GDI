SELECT REF(S)
FROM TB_SALA S
WHERE S.ID = 101; 

-- Usando DEREF para acessar os detalhes da relacionamento ternário a partir da referência
SELECT DEREF(P.DETENTO).nome AS PRESIDIARIO, 
       DEREF(P.ALA) AS localizacao
FROM TB_POSSUI P;
