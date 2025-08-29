
```html

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored ="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>HTML5 Component</title>
	<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}css/mainCSS.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;700&display=swap" rel="stylesheet">

  

	<snk:load/>
</head>
<body>
<snk:query var="ranking">
WITH VENDAS_ATUAL AS(

SELECT
  1 AS ordem,
  '#56b8cd' AS BKCOLOR,
  LL.CODEMP,
  REPLACE(EMP.NOMEFANTASIA, 'VALDIR MOVEIS', 'VM') AS NOME,
  NULL AS CODVEND,
  NULL AS APELIDO,
  --ITENS,
  SUM(MOVEIS) MOVEIS,
  SUM(ELETRO) ELETRO,
  SUM(GARANTIA) GARANTIA,
  SUM(PRESTAMISTA) PRESTAMISTA,
  SUM(CAMINHAO) CAMINHAO,
  -- NOTA 
  SUM(FRETE) FRETE,
  SUM(ITENS + FRETE) AS TOTAL_VENDAS,
  SUM(CUSTO_MOVEIS) CUSTO_MOVEIS,
  SUM(CUSTO_ELETRO) CUSTO_ELETRO,
  --RANKING
    RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) AS RANKING_EMPRESA,
    AVG(SUM(ITENS + FRETE)) OVER () AS MEDIA_VENDAS,
CASE
  WHEN SUM(ITENS + FRETE) > AVG(SUM(ITENS + FRETE)) OVER () THEN 'ACIMA DA MÉDIA'
  WHEN SUM(ITENS + FRETE) < AVG(SUM(ITENS + FRETE)) OVER () THEN 'ABAIXO DA MÉDIA'
  ELSE 'NA MÉDIA'
END AS COMPARATIVO,
CASE
  WHEN RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) = 1 THEN 'MELHOR'
  WHEN RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) = COUNT(*) OVER () THEN 'PIOR' 
  ELSE 'NA MÉDIA'
END AS CLASSIFICACAO,
  --MARGEM
  CASE
    WHEN SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN
    -- Se ambos negativos ou ambos positivos (mesmo sinal)
    CASE
      WHEN SIGN(SUM(MOVEIS)) = SIGN(SUM(CUSTO_MOVEIS)) THEN SUM(MOVEIS) / SUM(CUSTO_MOVEIS)
      -- Se sinais diferentes
      ELSE -1 * ABS(SUM(MOVEIS) / SUM(CUSTO_MOVEIS))
    END
    ELSE 0
  END MARGEM_MOVEIS,
  CASE
    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO)) = SIGN(SUM(CUSTO_ELETRO)) THEN SUM(ELETRO) / SUM(CUSTO_ELETRO)
      ELSE -1 * ABS(SUM(ELETRO) / SUM(CUSTO_ELETRO))
    END
    ELSE 0
  END MARGEM_ELETRO,
  CASE


    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0
    AND SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO) + SUM(MOVEIS)) = SIGN(SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS)) THEN (SUM(ELETRO) + SUM(MOVEIS)) / (SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS))
      ELSE -1 * ABS(
        (SUM(ELETRO) + SUM(MOVEIS)) / (SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS))
      )
    END


    WHEN SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN CASE
      WHEN SIGN(SUM(MOVEIS)) = SIGN(SUM(CUSTO_MOVEIS)) THEN SUM(MOVEIS) / SUM(CUSTO_MOVEIS)
      ELSE -1 * ABS(SUM(MOVEIS) / SUM(CUSTO_MOVEIS))
    END


    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO)) = SIGN(SUM(CUSTO_ELETRO)) THEN SUM(ELETRO) / SUM(CUSTO_ELETRO)
      ELSE -1 * ABS(SUM(ELETRO) / SUM(CUSTO_ELETRO))
    END

	ELSE 0
  END MARGEM_TOTAL
FROM
  (
    SELECT DISTINCT
      'DEVOLUÇÃO' AS TIPO,
      CAB.DTNEG AS DTNEG,
      CAB.NUNOTA,
      CAB.VLRNOTA,
      VEN.APELIDO,
      VEN.CODVEND,
      DESCROPER,
      CAB.CODTIPOPER,
      CAB.CODEMP,
      --50195019
      CAB.VLRFRETE * -1 AS FRETE,
      sum(
        CASE
          WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
          AND AD_GRUPOGERENCIAL = 'M' THEN (
            ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
              ITE.NUNOTA,
              ITE.VLRTOT,
              AD_GRUPOGERENCIAL,
              CAB.VLRDESCTOT
            )
          ) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS MOVEIS,
      sum(
        CASE
          WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
          AND AD_GRUPOGERENCIAL = 'E' THEN (
            ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
              ITE.NUNOTA,
              ITE.VLRTOT,
              AD_GRUPOGERENCIAL,
              CAB.VLRDESCTOT
            )
          ) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ELETRO,
      sum(
        CASE
          WHEN ITE.CODPROD IN (3, 4) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS GARANTIA,
      sum(
        CASE
          WHEN ITE.CODPROD IN (7) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS PRESTAMISTA,
      sum(
        CASE
          WHEN ITE.CODPROD IN (6) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS CAMINHAO,
      sum(
        (
          ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
            ITE.NUNOTA,
            ITE.VLRTOT,
            AD_GRUPOGERENCIAL,
            CAB.VLRDESCTOT
          )
        ) * -1
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ITENS,
    -- CUSTO_MOVEIS 
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'M' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_MOVEIS,
    -- CUSTO_ELETRO
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'E' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_ELETRO
    FROM
      TGFCAB CAB
      LEFT JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
      LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
      LEFT JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
      LEFT JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
      LEFT JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER
      AND CAB.DHTIPOPER = TPO.DHALTER
      --LEFT JOIN  VGFCAB VCAB ON VCAB.NUNOTA= CAB.NUNOTA
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
      CAB.STATUSNOTA = 'L'
      AND CAB.TIPMOV = 'D'
	  AND CAB.DTNEG BETWEEN TRUNC(SYSDATE, 'MM') AND LAST_DAY(SYSDATE)
      AND CAB.CODEMP IN (
        SELECT EMP.CODEMP FROM TSIEMP EMP
        JOIN TGFPAR PAR ON PAR.CODPARC = EMP.CODPARC
        WHERE NVL(PAR.AD_EH_FRANQUIA, 'N') = 'S')
    UNION
    SELECT DISTINCT
      'VENDA' AS TIPO,
      CAB.DTNEG AS DTNEG,
      CAB.NUNOTA,
      CAB.VLRNOTA,
      VEN.APELIDO,
      VEN.CODVEND,
      DESCROPER,
      CAB.CODTIPOPER,
      CAB.CODEMP,
      --50195019
      CAB.VLRFRETE AS FRETE,
      sum(
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
      ) over (
        PARTITION BY
          cab.nunota
      ) AS MOVEIS,
      sum(
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
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ELETRO,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1134 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS GARANTIA,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1137 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS PRESTAMISTA,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1136 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS CAMINHAO,
      sum(
        ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
          ITE.NUNOTA,
          ITE.VLRTOT,
          AD_GRUPOGERENCIAL,
          CAB.VLRDESCTOT
        )
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ITENS,
    -- CUSTO_MOVEIS 
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'M' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_MOVEIS,
    -- CUSTO_ELETRO
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'E' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_ELETRO
    FROM
      TGFCAB CAB
      LEFT JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
      LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
      LEFT JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
      LEFT JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
      LEFT JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER
      AND CAB.DHTIPOPER = TPO.DHALTER
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
      CAB.STATUSNOTA = 'L'
      AND CAB.CODTIPOPER IN (
        SELECT
          CODTIPOPER
        FROM
          AD_VW_TIPOPERFAT
      )
    AND CAB.DTNEG BETWEEN TRUNC(SYSDATE, 'MM') AND LAST_DAY(SYSDATE)
    AND CAB.CODEMP IN (
    SELECT EMP.CODEMP FROM TSIEMP EMP
    JOIN TGFPAR PAR ON PAR.CODPARC = EMP.CODPARC
    WHERE NVL(PAR.AD_EH_FRANQUIA, 'N') = 'S')
  ) LL
  LEFT JOIN TSIEMP EMP ON EMP.CODEMP = LL.CODEMP
  GROUP BY LL.CODEMP, EMP.NOMEFANTASIA
),

 VENDAS_ANTERIOR AS(

SELECT
  1 AS ordem,
  '#56b8cd' AS BKCOLOR,
  LL.CODEMP,
  REPLACE(EMP.NOMEFANTASIA, 'VALDIR MOVEIS', 'VM') AS NOME,
  NULL AS CODVEND,
  NULL AS APELIDO,
  --ITENS,
  SUM(MOVEIS) MOVEIS,
  SUM(ELETRO) ELETRO,
  SUM(GARANTIA) GARANTIA,
  SUM(PRESTAMISTA) PRESTAMISTA,
  SUM(CAMINHAO) CAMINHAO,
  -- NOTA 
  SUM(FRETE) FRETE,
  SUM(ITENS + FRETE) AS TOTAL_VENDAS,
  SUM(CUSTO_MOVEIS) CUSTO_MOVEIS,
  SUM(CUSTO_ELETRO) CUSTO_ELETRO,
  --RANKING
    RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) AS RANKING_EMPRESA,
    AVG(SUM(ITENS + FRETE)) OVER () AS MEDIA_VENDAS,
CASE
  WHEN SUM(ITENS + FRETE) > AVG(SUM(ITENS + FRETE)) OVER () THEN 'ACIMA DA MÉDIA'
  WHEN SUM(ITENS + FRETE) < AVG(SUM(ITENS + FRETE)) OVER () THEN 'ABAIXO DA MÉDIA'
  ELSE 'NA MÉDIA'
END AS COMPARATIVO,
CASE
  WHEN RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) = 1 THEN 'MELHOR'
  WHEN RANK() OVER (ORDER BY SUM(ITENS + FRETE) DESC) = COUNT(*) OVER () THEN 'PIOR' 
  ELSE 'NA MÉDIA'
END AS CLASSIFICACAO,
  --MARGEM
  CASE
    WHEN SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN
    -- Se ambos negativos ou ambos positivos (mesmo sinal)
    CASE
      WHEN SIGN(SUM(MOVEIS)) = SIGN(SUM(CUSTO_MOVEIS)) THEN SUM(MOVEIS) / SUM(CUSTO_MOVEIS)
      -- Se sinais diferentes
      ELSE -1 * ABS(SUM(MOVEIS) / SUM(CUSTO_MOVEIS))
    END
    ELSE 0
  END MARGEM_MOVEIS,
  CASE
    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO)) = SIGN(SUM(CUSTO_ELETRO)) THEN SUM(ELETRO) / SUM(CUSTO_ELETRO)
      ELSE -1 * ABS(SUM(ELETRO) / SUM(CUSTO_ELETRO))
    END
    ELSE 0
  END MARGEM_ELETRO,
  CASE


    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0
    AND SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO) + SUM(MOVEIS)) = SIGN(SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS)) THEN (SUM(ELETRO) + SUM(MOVEIS)) / (SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS))
      ELSE -1 * ABS(
        (SUM(ELETRO) + SUM(MOVEIS)) / (SUM(CUSTO_ELETRO) + SUM(CUSTO_MOVEIS))
      )
    END


    WHEN SUM(MOVEIS) <> 0
    AND SUM(CUSTO_MOVEIS) <> 0 THEN CASE
      WHEN SIGN(SUM(MOVEIS)) = SIGN(SUM(CUSTO_MOVEIS)) THEN SUM(MOVEIS) / SUM(CUSTO_MOVEIS)
      ELSE -1 * ABS(SUM(MOVEIS) / SUM(CUSTO_MOVEIS))
    END


    WHEN SUM(ELETRO) <> 0
    AND SUM(CUSTO_ELETRO) <> 0 THEN CASE
      WHEN SIGN(SUM(ELETRO)) = SIGN(SUM(CUSTO_ELETRO)) THEN SUM(ELETRO) / SUM(CUSTO_ELETRO)
      ELSE -1 * ABS(SUM(ELETRO) / SUM(CUSTO_ELETRO))
    END

	ELSE 0
  END MARGEM_TOTAL
FROM
  (
    SELECT DISTINCT
      'DEVOLUÇÃO' AS TIPO,
      CAB.DTNEG AS DTNEG,
      CAB.NUNOTA,
      CAB.VLRNOTA,
      VEN.APELIDO,
      VEN.CODVEND,
      DESCROPER,
      CAB.CODTIPOPER,
      CAB.CODEMP,
      --50195019
      CAB.VLRFRETE * -1 AS FRETE,
      sum(
        CASE
          WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
          AND AD_GRUPOGERENCIAL = 'M' THEN (
            ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
              ITE.NUNOTA,
              ITE.VLRTOT,
              AD_GRUPOGERENCIAL,
              CAB.VLRDESCTOT
            )
          ) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS MOVEIS,
      sum(
        CASE
          WHEN CAB.CODTIPOPER NOT IN (1134, 1137, 1136)
          AND AD_GRUPOGERENCIAL = 'E' THEN (
            ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
              ITE.NUNOTA,
              ITE.VLRTOT,
              AD_GRUPOGERENCIAL,
              CAB.VLRDESCTOT
            )
          ) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ELETRO,
      sum(
        CASE
          WHEN ITE.CODPROD IN (3, 4) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS GARANTIA,
      sum(
        CASE
          WHEN ITE.CODPROD IN (7) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS PRESTAMISTA,
      sum(
        CASE
          WHEN ITE.CODPROD IN (6) THEN (ITE.VLRTOT - ITE.VLRDESC) * -1
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS CAMINHAO,
      sum(
        (
          ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
            ITE.NUNOTA,
            ITE.VLRTOT,
            AD_GRUPOGERENCIAL,
            CAB.VLRDESCTOT
          )
        ) * -1
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ITENS,
    -- CUSTO_MOVEIS 
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'M' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_MOVEIS,
    -- CUSTO_ELETRO
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'E' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_ELETRO
    FROM
      TGFCAB CAB
      LEFT JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
      LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
      LEFT JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
      LEFT JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
      LEFT JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER
      AND CAB.DHTIPOPER = TPO.DHALTER
      --LEFT JOIN  VGFCAB VCAB ON VCAB.NUNOTA= CAB.NUNOTA
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
      CAB.STATUSNOTA = 'L'
      AND CAB.TIPMOV = 'D'
      AND CAB.DTNEG BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) AND TRUNC(SYSDATE, 'MM') - 1
      AND CAB.CODEMP IN (
        SELECT EMP.CODEMP FROM TSIEMP EMP
        JOIN TGFPAR PAR ON PAR.CODPARC = EMP.CODPARC
        WHERE NVL(PAR.AD_EH_FRANQUIA, 'N') = 'S')
    UNION
    SELECT DISTINCT
      'VENDA' AS TIPO,
      CAB.DTNEG AS DTNEG,
      CAB.NUNOTA,
      CAB.VLRNOTA,
      VEN.APELIDO,
      VEN.CODVEND,
      DESCROPER,
      CAB.CODTIPOPER,
      CAB.CODEMP,
      --50195019
      CAB.VLRFRETE AS FRETE,
      sum(
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
      ) over (
        PARTITION BY
          cab.nunota
      ) AS MOVEIS,
      sum(
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
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ELETRO,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1134 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS GARANTIA,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1137 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS PRESTAMISTA,
      sum(
        CASE
          WHEN CAB.CODTIPOPER = 1136 THEN ITE.VLRTOT - ITE.VLRDESC
          ELSE 0
        END
      ) over (
        PARTITION BY
          cab.nunota
      ) AS CAMINHAO,
      sum(
        ITE.VLRTOT - ITE.VLRDESC - AD_PROPORCAO_DESC_ITE (
          ITE.NUNOTA,
          ITE.VLRTOT,
          AD_GRUPOGERENCIAL,
          CAB.VLRDESCTOT
        )
      ) over (
        PARTITION BY
          cab.nunota
      ) AS ITENS,
    -- CUSTO_MOVEIS 
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'M' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_MOVEIS,
    -- CUSTO_ELETRO
    SUM(
      CASE
        WHEN AD_GRUPOGERENCIAL = 'E' THEN
          CASE
            WHEN (
              SELECT CUSREP
              FROM TGFCUS
              WHERE CODPROD = ITE.CODPROD
                AND CODEMP = (
                  CASE
                    WHEN :CODEMP IS NOT NULL THEN :CODEMP
                    ELSE
                      CASE
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '3'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '3'
                        WHEN EXISTS (
                          SELECT 1
                          FROM TGFCUS
                          WHERE CODPROD = ITE.CODPROD
                            AND CODEMP = '2'
                            AND DTATUAL <= TRUNC(CAB.DTNEG)
                        ) THEN '2'
                        ELSE '1'
                      END
                  END
                )
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = (
                      CASE
                        WHEN :CODEMP IS NOT NULL THEN :CODEMP
                        ELSE
                          CASE
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '3'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '3'
                            WHEN EXISTS (
                              SELECT 1
                              FROM TGFCUS
                              WHERE CODPROD = ITE.CODPROD
                                AND CODEMP = '2'
                                AND DTATUAL <= TRUNC(CAB.DTNEG)
                            ) THEN '2'
                            ELSE '1'
                          END
                      END
                    )
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
                     ITE.CODPROD,
                     'S',
                     CASE
                       WHEN :CODEMP IS NOT NULL THEN :CODEMP
                       ELSE
                         CASE
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '3'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '3'
                           WHEN EXISTS (
                             SELECT 1
                             FROM TGFCUS
                             WHERE CODPROD = ITE.CODPROD
                               AND CODEMP = '2'
                               AND DTATUAL <= TRUNC(CAB.DTNEG)
                           ) THEN '2'
                           ELSE '1'
                         END
                     END,
                     'N',
                     NULL,
                     'N',
                     NULL,
                     TRUNC(CAB.DTNEG),
                     0
                   )
                 * ITE.QTDNEG
          END
        ELSE 0
      END
    ) OVER (PARTITION BY CAB.NUNOTA) AS CUSTO_ELETRO
    FROM
      TGFCAB CAB
      LEFT JOIN TGFPAR PAR ON CAB.CODPARC = PAR.CODPARC
      LEFT JOIN TGFITE ITE ON CAB.NUNOTA = ITE.NUNOTA
      LEFT JOIN TGFPRO PRO ON ITE.CODPROD = PRO.CODPROD
      LEFT JOIN TGFGRU GRU ON PRO.CODGRUPOPROD = GRU.CODGRUPOPROD
      LEFT JOIN TGFTOP TPO ON CAB.CODTIPOPER = TPO.CODTIPOPER
      AND CAB.DHTIPOPER = TPO.DHALTER
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
      CAB.STATUSNOTA = 'L'
      AND CAB.CODTIPOPER IN (
        SELECT
          CODTIPOPER
        FROM
          AD_VW_TIPOPERFAT
      )
	AND CAB.DTNEG BETWEEN ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -1) AND TRUNC(SYSDATE, 'MM') - 1
    AND CAB.CODEMP IN (
    SELECT EMP.CODEMP FROM TSIEMP EMP
    JOIN TGFPAR PAR ON PAR.CODPARC = EMP.CODPARC
    WHERE NVL(PAR.AD_EH_FRANQUIA, 'N') = 'S')
  ) LL
  LEFT JOIN TSIEMP EMP ON EMP.CODEMP = LL.CODEMP
  GROUP BY LL.CODEMP, EMP.NOMEFANTASIA
)
SELECT
  A.RANKING_EMPRESA,
  A.CLASSIFICACAO,
  COALESCE(A.CODEMP, B.CODEMP) AS CODEMP,
  COALESCE(A.NOME, B.NOME) AS NOME_EMPRESA,
  A.TOTAL_VENDAS AS TOTAL_ATUAL,
  B.TOTAL_VENDAS AS TOTAL_ANTERIOR,
  (A.TOTAL_VENDAS - B.TOTAL_VENDAS) AS DIFERENCA_VALOR,
  ROUND(NVL((A.TOTAL_VENDAS - B.TOTAL_VENDAS) / NULLIF(B.TOTAL_VENDAS, 0), 0) * 100, 2) AS PERCENTUAL_VARIACAO
FROM
  VENDAS_ATUAL A
FULL OUTER JOIN VENDAS_ANTERIOR B ON A.CODEMP = B.CODEMP
ORDER BY
  A.RANKING_EMPRESA

</snk:query>
</head>
<body>
<div class="ranking-container">
    <div class="ranking-header">Ranking das Franquias por Média de Vendas</div>
    <div class="colunas">
      <span class="rank">Rank</span>
      <span class="col-franquia">Franquias</span>
      <span class="atual">Mês Atual</span>
      <span class="anterior">Mês Anterior</span>
      <span class="diferenca">Diferença</span>
      <span class="percentual">% Percentual</span>
    </div>
    <ul class="ranking-list">
      <c:forEach items="${ranking.rows}" var="linha">
        <div class="ranking-item ${linha.CLASSIFICACAO eq 'MELHOR' ? 'top1' : (linha.CLASSIFICACAO eq 'PIOR' ? 'pior' : '')}">
          <span class="rank">${linha.RANKING_EMPRESA}º</span>
          <span class="col-franquia">${linha.NOME_EMPRESA} (${linha.CODEMP})</span>

          <span class="atual ${linha.TOTAL_ATUAL > linha.TOTAL_ANTERIOR ? 'positivo' : (linha.TOTAL_ATUAL < linha.TOTAL_ANTERIOR ? 'negativo' : 'neutro')}">
            <span class="arrow">
              <i class="fa-solid ${linha.TOTAL_ATUAL > linha.TOTAL_ANTERIOR ? 'fa-arrow-up' : (linha.TOTAL_ATUAL < linha.TOTAL_ANTERIOR ? 'fa-arrow-down' : '')}"></i>
            </span>
            <span class="valor">
              R$ <fmt:formatNumber value="${linha.TOTAL_ATUAL}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
            </span>
          </span>

          <span class="anterior">
            R$ <fmt:formatNumber value="${linha.TOTAL_ANTERIOR}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
          </span>

          <span class="diferenca ${linha.DIFERENCA_VALOR > 0 ? 'positivo' : (linha.DIFERENCA_VALOR < 0 ? 'negativo' : 'neutro')}">
            <span class="arrow">
              <i class="fa-solid ${linha.DIFERENCA_VALOR > 0 ? 'fa-arrow-up' : (linha.DIFERENCA_VALOR < 0 ? 'fa-arrow-down' : '')}"></i>
            </span>
            <span class="valor">
              R$ <fmt:formatNumber value="${linha.DIFERENCA_VALOR}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
            </span>
          </span>

          <span class="percentual ${linha.PERCENTUAL_VARIACAO > 0 ? 'positivo' : (linha.PERCENTUAL_VARIACAO < 0 ? 'negativo' : 'neutro')}">
            <span class="arrow">
              <i class="fa-solid ${linha.PERCENTUAL_VARIACAO > 0 ? 'fa-arrow-up' : (linha.PERCENTUAL_VARIACAO < 0 ? 'fa-arrow-down' : '')}"></i>
            </span>
            <span class="valor">
              <fmt:formatNumber value="${linha.PERCENTUAL_VARIACAO}" type="number" maxFractionDigits="2" minFractionDigits="2" />%
            </span>
          </span>
        </div>
      </c:forEach>
    </ul>
  </div>
</body>
</html>
```
