SELECT -- detalhes
    CODEMP,
    NOMECID,
    NOMEBAI,
    COUNT(NUNOTA) AS "NOTASEMITIDAS",
    SUM((SELECT ITENS_CONTA FROM DUAL)) AS "ITENS_CONTA",
    SUM(MOVEIS) MOVEIS,
    SUM(ELETRO) ELETRO,
    SUM(GARANTIA) GARANTIA,
    SUM(PRESTAMISTA) PRESTAMISTA,
    SUM(CAMINHAO) CAMINHAO, -- NOTA
    SUM(FRETE) FRETE,
    SUM(ITENS + FRETE) AS TOTAL_VENDAS
FROM
(
        SELECT DISTINCT
            'VENDA' AS TIPO,
            CAB.NUNOTA,
            CID.NOMECID,
            BAI.NOMEBAI,
            CAB.VLRNOTA,
            VEN.APELIDO,
            VEN.CODVEND,
            DESCROPER,
            CAB.CODTIPOPER,
            CAB.CODEMP, --50195019
			(SUM(ITE.QTDNEG) OVER (PARTITION BY ITE.NUNOTA)) AS ITENS_CONTA,
            CAB.VLRFRETE AS FRETE,
            SUM(
                CASE
                    WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
                    AND AD_GRUPOGERENCIAL = 'M' THEN ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
                        ITE.NUNOTA,
                        ITE.VLRTOT,
                        AD_GRUPOGERENCIAL,
                        CAB.VLRDESCTOT
                    )
                    ELSE 0
                END
            ) OVER (
                PARTITION BY
                    CAB.NUNOTA
            ) AS MOVEIS,
            SUM(
                CASE
                    WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
                    AND AD_GRUPOGERENCIAL = 'E' THEN ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
                        ITE.NUNOTA,
                        ITE.VLRTOT,
                        AD_GRUPOGERENCIAL,
                        CAB.VLRDESCTOT
                    )
                    ELSE 0
                END
            ) OVER (
                PARTITION BY
                    CAB.NUNOTA
            ) AS ELETRO,
            SUM(
                CASE
                    WHEN CAB.CODTIPOPER = 1134 THEN ITE.VLRTOT - ITE.VLRDESC
                    ELSE 0
                END
            ) OVER (
                PARTITION BY
                    CAB.NUNOTA
            ) AS GARANTIA,
            SUM(
                CASE
                    WHEN CAB.CODTIPOPER = 1137 THEN ITE.VLRTOT - ITE.VLRDESC
                    ELSE 0
                END
            ) OVER (
                PARTITION BY
                    CAB.NUNOTA
            ) AS PRESTAMISTA,
            SUM(
                CASE
                    WHEN CAB.CODTIPOPER = 1136 THEN ITE.VLRTOT - ITE.VLRDESC
                    ELSE 0
                END
            ) OVER (
                PARTITION BY
                    CAB.NUNOTA
            ) AS CAMINHAO,
            (
                SUM(
                    ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
                        ITE.NUNOTA,
                        ITE.VLRTOT,
                        AD_GRUPOGERENCIAL,
                        CAB.VLRDESCTOT
                    )
                ) OVER (
                    PARTITION BY
                        CAB.NUNOTA
                )
            ) AS ITENS
        FROM
            TGFCAB CAB
            LEFT JOIN TSIEMP EMP ON EMP.CODEMP = CAB.CODEMP
            LEFT JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
            LEFT JOIN TGFCTT CTT ON CTT.CODPARC = PAR.CODPARC
            LEFT JOIN TSIBAI BAI ON BAI.CODBAI = CTT.CODBAI            
            LEFT JOIN TSICID CID ON CID.CODCID = CTT.CODCID
            LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
            LEFT JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
            LEFT JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
            LEFT JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER
            AND CAB.DHTIPOPER = TPO.DHALTER --LEFT JOIN  VGFCAB VCAB ON VCAB.NUNOTA= CAB.NUNOTA
            LEFT JOIN TGFVEN VEN ON CAB.CODVEND = VEN.CODVEND
            LEFT JOIN TGFVOA VOA ON (
                VOA.CODPROD = ITE.CODPROD
                AND VOA.CODVOL = ITE.CODVOL
                AND (
                    (
                        ITE.CONTROLE IS NULL
                        AND VOA.CONTROLE = ' '
                    )
                    OR (
                        ITE.CONTROLE IS NOT NULL
                        AND ITE.CONTROLE = VOA.CONTROLE
                    )
                )
            )
        WHERE
            CTT.ATIVO = 'S'
            AND (
                  :P_PARCEIRO IS NULL
                  OR CAB.CODPARCTRANSP = :P_PARCEIRO
                )
            AND CAB.STATUSNOTA = 'L'
            AND (CAB.CODEMP IN :EMPRESA)
            AND (
                (
                    (:AD_PAGAROYALTIES = 1)
                    AND (EMP.AD_PAGAROYALTIES = 'S')
                )
                OR (
                    (:AD_PAGAROYALTIES = 2)
                    AND (EMP.AD_PAGAROYALTIES = 'N')
                )
                OR (:AD_PAGAROYALTIES = 3)
            )
            AND CAB.CODTIPOPER in (SELECT CODTIPOPER FROM AD_VW_TIPOPERREG)
            AND ((
                :PERIODO_FT IS NOT NULL
                AND CAB.DTNEG >= CASE TO_CHAR(:PERIODO_FT)
                    WHEN '0' THEN TRUNC(SYSDATE) -- Hoje
                    WHEN '1' THEN TRUNC(SYSDATE - 1) -- Dia Anterior
                    WHEN '2' THEN TRUNC(SYSDATE, 'MM') -- Mês Atual
                    WHEN '3' THEN TRUNC(ADD_MONTHS(SYSDATE, -1), 'MM') -- Primeiro dia do Mês Anterior
                    WHEN '4' THEN TRUNC(SYSDATE, 'YYYY') -- Ano Atual
                    WHEN '5' THEN TRUNC(ADD_MONTHS(SYSDATE, -12), 'YYYY') -- Primeiro dia do Ano Anterior
                    ELSE NULL
                END
                AND CAB.DTNEG < CASE TO_CHAR(:PERIODO_FT)
                    WHEN '0' THEN TRUNC(SYSDATE + 1) -- Amanhã
                    WHEN '1' THEN TRUNC(SYSDATE) -- Hoje
                    WHEN '2' THEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1) -- Próximo mês
                    WHEN '3' THEN TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') -- Primeiro dia do mês atual (fim do mês anterior)
                    WHEN '4' THEN ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), 12) -- Próximo Ano
                    WHEN '5' THEN TRUNC(SYSDATE, 'YYYY') -- Início do Ano Atual
                    ELSE NULL
                END
            )
            OR (
                (:PERIODO_FT IS NULL OR :PERIODO_FT = 9)
                AND :PERIODO.INI IS NOT NULL
                AND :PERIODO.FIN IS NOT NULL
                AND CAB.DTNEG BETWEEN :PERIODO.INI AND :PERIODO.FIN
            ))
    ) LL
GROUP BY
    CODEMP,
    NOMECID,
    NOMEBAI