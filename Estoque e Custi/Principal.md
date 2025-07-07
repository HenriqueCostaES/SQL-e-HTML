```sql
--PRINCIPAL
SELECT
    CODEMP,
    NOMEFANTASIA,
    SUM(ESTOQUE_TOT) AS ESTOQUE_TOT,
    SUM(DISPONIVEL) AS DISPONIVEL,
    SUM(CUSTO_TOTAL) AS CUSTO_TOTAL
FROM (
SELECT
    EST.CODEMP,
    EMP.NOMEFANTASIA,
    LOC.DESCRLOCAL, 
    PRO.CODPROD, 
    PRO.DESCRPROD, 
    PRO.CODVOL, 
    PRO.REFERENCIA, 
    PRO.NCM,
    PRO.AD_CDORIGEM,
    SUM(EST.RESERVADO) AS RESERVADO, 
    SUM(EST.ESTOQUE) - SUM(EST.RESERVADO) AS DISPONIVEL, 
    SUM(EST.ESTOQUE) AS ESTOQUE_TOT, 
    CASE 
      WHEN (
           SELECT CUSREP
           FROM TGFCUS
           WHERE CODPROD = PRO.CODPROD
             AND CODEMP = (CASE 
                             WHEN EXISTS (
                                  SELECT 1
                                  FROM TGFCUS T
                                  WHERE T.CODPROD = PRO.CODPROD
                                    AND T.CODEMP = '2'
                                    AND T.DTATUAL <= TRUNC(SYSDATE)
                             )
                             THEN '2'
                             ELSE '1'
                           END)
             AND DTATUAL <= TRUNC(SYSDATE)
             AND DTATUAL = (
                 SELECT MAX(DTATUAL)
                 FROM TGFCUS CN
                 WHERE CODPROD = PRO.CODPROD
                   AND DTATUAL <= TRUNC(SYSDATE)
                   AND CODEMP = (CASE 
                                   WHEN EXISTS (
                                        SELECT 1
                                        FROM TGFCUS T
                                        WHERE T.CODPROD = PRO.CODPROD
                                          AND T.CODEMP = '2'
                                          AND T.DTATUAL <= TRUNC(SYSDATE)
                                   )
                                   THEN '2'
                                   ELSE '1'
                                 END)
             )
      ) IS NULL 
      THEN OBTEMCUSTONE(
             PRO.CODPROD, 
             'S', 
             (CASE 
                WHEN EXISTS (
                     SELECT 1
                     FROM TGFCUS T
                     WHERE T.CODPROD = PRO.CODPROD
                       AND T.CODEMP = '2'
                       AND T.DTATUAL <= TRUNC(SYSDATE)
                )
                THEN '2'
                ELSE '1'
              END),
             'N', 
             NULL, 
             'N', 
             'N', 
             TRUNC(SYSDATE), 
             0
           )
      ELSE OBTEMCUSTONE(
             PRO.CODPROD, 
             'S', 
             (CASE 
                WHEN EXISTS (
                     SELECT 1
                     FROM TGFCUS T
                     WHERE T.CODPROD = PRO.CODPROD
                       AND T.CODEMP = '2'
                       AND T.DTATUAL <= TRUNC(SYSDATE)
                )
                THEN '2'
                ELSE '1'
              END),
             'N', 
             NULL, 
             'N', 
             'N', 
             TRUNC(SYSDATE), 
             0
           )
    END AS CUSREP,
        
    CASE 
        WHEN SUM(EST.ESTOQUE) < 0 
             OR SUM(EST.ESTOQUE) - SUM(EST.RESERVADO) < 0 
        THEN 0
        ELSE 
          CASE 
            WHEN ((SUM(EST.ESTOQUE) - SUM(EST.RESERVADO)) * 
                  CASE 
                    WHEN (
                        SELECT COUNT(*) 
                        FROM TGFCUS C 
                        WHERE C.CODPROD = PRO.CODPROD 
                          AND C.CODEMP = (CASE 
                                           WHEN EXISTS (
                                                SELECT 1
                                                FROM TGFCUS T
                                                WHERE T.CODPROD = PRO.CODPROD
                                                  AND T.CODEMP = '2'
                                                  AND T.DTATUAL <= TRUNC(SYSDATE)
                                           )
                                           THEN '2'
                                           ELSE '1'
                                         END)
                    ) > 0 
                    THEN OBTEMCUSTONE(
                           PRO.CODPROD, 
                           'S', 
                           (CASE 
                              WHEN EXISTS (
                                   SELECT 1
                                   FROM TGFCUS T
                                   WHERE T.CODPROD = PRO.CODPROD
                                     AND T.CODEMP = '2'
                                     AND T.DTATUAL <= TRUNC(SYSDATE)
                              )
                              THEN '2'
                              ELSE '1'
                            END),
                           'N', 
                           NULL, 
                           'N', 
                           'N', 
                           TRUNC(SYSDATE), 
                           0
                         )
                    ELSE 0 
                  END) < 0 
            THEN 0
            ELSE 
              ((SUM(EST.ESTOQUE) - SUM(EST.RESERVADO)) *
                 CASE 
                    WHEN (
                        SELECT COUNT(*) 
                        FROM TGFCUS C 
                        WHERE C.CODPROD = PRO.CODPROD 
                          AND C.CODEMP = (CASE 
                                           WHEN EXISTS (
                                                SELECT 1
                                                FROM TGFCUS T
                                                WHERE T.CODPROD = PRO.CODPROD
                                                  AND T.CODEMP = '2'
                                                  AND T.DTATUAL <= TRUNC(SYSDATE)
                                           )
                                           THEN '2'
                                           ELSE '1'
                                         END)
                    ) > 0 
                    THEN OBTEMCUSTONE(
                           PRO.CODPROD, 
                           'S', 
                           (CASE 
                              WHEN EXISTS (
                                   SELECT 1
                                   FROM TGFCUS T
                                   WHERE T.CODPROD = PRO.CODPROD
                                     AND T.CODEMP = '2'
                                     AND T.DTATUAL <= TRUNC(SYSDATE)
                              )
                              THEN '2'
                              ELSE '1'
                            END),
                           'N', 
                           NULL, 
                           'N', 
                           'N', 
                           TRUNC(SYSDATE), 
                           0
                         )
                    ELSE 0 
                 END
              )
          END
    END AS CUSTO_TOTAL


FROM 
  TGFPRO PRO 
  INNER JOIN TGFEST EST ON PRO.CODPROD = EST.CODPROD 
  INNER JOIN TGFLOC LOC ON EST.CODLOCAL = LOC.CODLOCAL
  INNER JOIN TSIEMP EMP ON EMP.CODEMP = EST.CODEMP 
WHERE 
    ((PRO.CODPROD = :PRODUTO)OR :PRODUTO IS NULL) 
    AND (EST.CODEMP IN :EMPRESA)
    AND (PRO.AD_ESTADO IN :ESTADO)
    AND ((EST.CODLOCAL = 500100000) OR 
         (EST.CODLOCAL = 100000000 AND EST.CODEMP IN (1,2)))
    AND (PRO.CODGRUPOPROD IN (SELECT TGFGRU.CODGRUPOPROD
                                      FROM TGFGRU 
                                      INNER JOIN TGFGRU PAI ON PAI.CODGRUPOPROD = TGFGRU.CODGRUPAI
                                      WHERE PAI.CODGRUPAI IN :GRUPO))  
    AND (PRO.CODGRUPOPROD = :GrupoProduto OR :GrupoProduto IS NULL)
GROUP BY LOC.DESCRLOCAL, PRO.CODPROD, PRO.DESCRPROD, 
  PRO.CODVOL, PRO.NCM,PRO.AD_CDORIGEM, PRO.REFERENCIA, EST.CODEMP, EMP.NOMEFANTASIA
)
GROUP BY CODEMP, NOMEFANTASIA
ORDER BY CODEMP

```
