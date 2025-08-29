

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>

<html>
<head>
  <meta charset="UTF-8">

  <snk:load/>



<style>
body {
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  margin: 10px;
  background-color: #f7f7f7;
  width: 550px;
  height: 448px;
}

/* Botão padrão */
button {
  padding: 4px 10px;
  background-color: #005fa3;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  font-size: 11px;
  width: 60px;
}

button:hover {
  background-color: #00467a;
}

/* Título com fundo azul */
.titulo-container {
  background-color: #00aaf0;
  padding: 12px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  margin-bottom: 5px;
}

h2.titulo-filtros {
  font-size: 16px;
  color: #ffffff;
  margin: 0;
  text-align: center;
}

/* Card branco ao redor dos filtros */
.card-filtros {
  padding: 8px;
  border-radius: 6px;
  background-color: white;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  border: 1px solid #ddd;
  margin-bottom: 10px;
}

/* Organização geral dos filtros */
.filtros-calendario {
  display: flex;
  flex-direction: column;
  gap: 8px;
  font-size: 11px;
}

.linha-mes {
  display: flex;
  justify-content: space-between;
  gap: 10px;
}

.grupo {
  display: flex;
  align-items: center;
  gap: 4px;
  flex: 1;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.grupo label {
  font-weight: bold;
  font-size: 11px;
  min-width: 100px;
  white-space: nowrap;
}

.grupo input[type="date"] {
  flex: 1;
  padding: 4px 6px;
  font-size: 11px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
input[type="date"]:hover {
  border-color: #0085c3;
}

/* Botão centralizado */
.linha-botao {
  display: flex;
  justify-content: center;
  margin-top: 6px;
}

/* Tabela de resultados */
.tabela-card {
  font-size: 10px;
  width: 100%;
  overflow-x: hidden;
}

table {
  width: 100%;
  font-size: 11px;
  font-weight: bold;
  border-collapse: separate;
  border-spacing: 0 8px; /* Espaço entre linhas */
  margin-top: 10px;
  background-color: transparent;
}

thead tr {
  background-color: #0085c3;
  color: white;
}

thead th {
  color: white;
  background-color: #0085c3;
  position: sticky;
  top: 0;
}

/* Estiliza cada linha como "card" */
tbody tr {
  background-color: white;
  border-radius: 6px;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
}

/* Arredonda as células das extremidades da linha */
tbody td:first-child {
  border-top-left-radius: 6px;
  border-bottom-left-radius: 6px;
  overflow: hidden;
}
tbody td:last-child {
  border-top-right-radius: 6px;
  border-bottom-right-radius: 6px;
  overflow: hidden;
}

th, td {
  padding: 6px 8px;
  min-width: 70px;
  max-width: 100px;
  word-wrap: break-word;
  text-align: center;
}

td {
  text-align: left;
}

/* Primeira coluna com largura fixa */
th:first-child,
td:first-child {
  width: 30px !important;
  min-width: 30px !important;
  max-width: 30px !important;
  padding: 2px 4px;
  text-align: center;
}

/* Cores por desempenho */
.melhor-linha {
  background-color: #c6f1d0 !important;
}

.pior-linha {
  background-color: #fac4c8 !important;
}

.positivo {
  color: green;
  font-weight: bold;
}

.negativo {
  color: red;
  font-weight: bold;
}

.neutro {
  color: gray;
}
</style>




  <script>
function carregarRanking() {
  var dtIniAtual = document.getElementById("dtIniAtual").value;
  var dtFimAtual = document.getElementById("dtFimAtual").value;
  var dtIniAnterior = document.getElementById('dtIniAnterior').value;
  var dtFimAnterior = document.getElementById('dtFimAnterior').value;
  var hoje = new Date();

  // Preenche datas padrão se não informado
  if (!dtIniAtual || !dtFimAtual) {
    dtIniAtual = new Date(hoje.getFullYear(), hoje.getMonth(), 1).toISOString().substring(0, 10);
    dtFimAtual = new Date(hoje.getFullYear(), hoje.getMonth() + 1, 0).toISOString().substring(0, 10);
    document.getElementById("dtIniAtual").value = dtIniAtual;
    document.getElementById("dtFimAtual").value = dtFimAtual;
  }
  
// Cálculo automático do mês anterior somente se não informado
if (!dtIniAnterior || !dtFimAnterior) {
  var primeiroDiaMesAnterior = new Date(hoje.getFullYear(), hoje.getMonth() - 1, 1).toISOString().substring(0, 10);
  var ultimoDiaMesAnterior = new Date(hoje.getFullYear(), hoje.getMonth(), 0).toISOString().substring(0, 10);
  
  dtIniAnterior = primeiroDiaMesAnterior;
  dtFimAnterior = ultimoDiaMesAnterior;

  document.getElementById("dtIniAnterior").value = dtIniAnterior;
  document.getElementById("dtFimAnterior").value = dtFimAnterior;
}



  var query = `

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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                        ITE.CODPROD,
                                'S',
                        CAB.CODEMP,
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
    AND CAB.DTNEG BETWEEN TO_DATE(:dtIniAtual, 'YYYY-MM-DD') AND TO_DATE(:dtFimAtual, 'YYYY-MM-DD')
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
    AND CAB.DTNEG BETWEEN TO_DATE(:dtIniAtual, 'YYYY-MM-DD') AND TO_DATE(:dtFimAtual, 'YYYY-MM-DD')
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
                        ITE.CODPROD,
                                'S',
                        CAB.CODEMP,
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE -1
                 * OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
    AND CAB.DTNEG BETWEEN TO_DATE(:dtIniAnterior, 'YYYY-MM-DD') AND TO_DATE(:dtFimAnterior, 'YYYY-MM-DD')
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
                AND CODEMP = CAB.CODEMP
                AND DTATUAL = (
                  SELECT MAX(DTATUAL)
                  FROM TGFCUS
                  WHERE CODPROD = ITE.CODPROD
                    AND CODEMP = CAB.CODEMP
                    AND DTATUAL <= TRUNC(CAB.DTNEG)
                )
            ) IS NULL THEN 0
            ELSE OBTEMCUSTO(
  ITE.CODPROD,
  'S',
  CAB.CODEMP,
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
    AND CAB.DTNEG BETWEEN TO_DATE(:dtIniAnterior, 'YYYY-MM-DD') AND TO_DATE(:dtFimAnterior, 'YYYY-MM-DD')
    AND CAB.CODEMP IN (
    SELECT EMP.CODEMP FROM TSIEMP EMP
    JOIN TGFPAR PAR ON PAR.CODPARC = EMP.CODPARC
    WHERE NVL(PAR.AD_EH_FRANQUIA, 'N') = 'S')
  ) LL
  LEFT JOIN TSIEMP EMP ON EMP.CODEMP = LL.CODEMP
  GROUP BY LL.CODEMP, EMP.NOMEFANTASIA
)   SELECT
         A.RANKING_EMPRESA || '°' as RANK,
         A.CLASSIFICACAO,
         COALESCE(A.NOME, B.NOME) || ' (' || TO_CHAR(COALESCE(A.CODEMP, B.CODEMP)) || ')' AS NOME_EMPRESA,
         TO_CHAR(A.TOTAL_VENDAS, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''R$ ''') AS TOTAL_ATUAL,
         TO_CHAR(B.TOTAL_VENDAS, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''R$ ''') AS TOTAL_ANTERIOR,
         'R$' || TO_CHAR(A.TOTAL_VENDAS - B.TOTAL_VENDAS, '999G999D99', 'NLS_NUMERIC_CHARACTERS = '',.''') AS DIFERENCA_VALOR,
         ROUND(NVL((A.TOTAL_VENDAS - B.TOTAL_VENDAS) / NULLIF(B.TOTAL_VENDAS, 0), 0) * 100, 2) || ' %' AS PERCENTUAL_VARIACAO
       FROM VENDAS_ATUAL A
       FULL OUTER JOIN VENDAS_ANTERIOR B ON A.CODEMP = B.CODEMP
       ORDER BY A.RANKING_EMPRESA

`;
var params = [
  { value: dtIniAtual, type: "S" }, // 1º :dtIniAtual
  { value: dtFimAtual, type: "S" }, // 1º :dtFimAtual
  { value: dtIniAtual, type: "S" }, // 2º :dtIniAtual
  { value: dtFimAtual, type: "S" }, // 2º :dtFimAtual
  { value: dtIniAnterior, type: "S" }, // 3º :dtIniAnterior
  { value: dtFimAnterior, type: "S" }, // 3º :dtFimAnterior
  { value: dtIniAnterior, type: "S" }, // 3º :dtIniAnterior
  { value: dtFimAnterior, type: "S" }, // 3º :dtFimAnterior
];

var tabela = document.getElementById("tabela-dados");

// Limpar a tabela ANTES de carregar os novos dados
tabela.innerHTML = "";

executeQuery(query, params, function (resultado) {
    var dados = JSON.parse(resultado);
    console.log('Resultado da query:', dados);
    console.log("Colunas reais retornadas:", Object.keys(dados[0]));

    tabela.innerHTML = "";

    if (dados.length > 0) {
        var colunas = Object.keys(dados[0]);

        var thead = tabela.createTHead();
        var header = thead.insertRow(0);

        const nomestabela = {
            'RANK': 'Rank',
            'CLASSIFICACAO': '',
            'NOME_EMPRESA': 'Franquias',
            'TOTAL_ATUAL': 'Mês Atual',
            'TOTAL_ANTERIOR': 'Mês Anterior',
            'DIFERENCA_VALOR': 'Diferença',
            'PERCENTUAL_VARIACAO': '% Percentual'
        };

colunas.forEach(function (col) {
    // Oculta a coluna CLASSIFICACAO do cabeçalho
    if (col === 'CLASSIFICACAO') {
    var th = document.createElement("th");
    th.innerText = ""; // Sem texto
    th.classList.add("coluna-titulo", "classificacao");
    th.style.display = "none";
    header.appendChild(th);
    return;
}


    var th = document.createElement("th");
    th.innerText = nomestabela[col] || col;
    th.classList.add("coluna-titulo");

    // Define largura fixa para RANK
    if (col === 'RANK') {
        th.style.width = "10px";
        th.style.textAlign = "center";
    }

    header.appendChild(th);
});


        var tbody = tabela.createTBody();

        dados.forEach(function (linha) {
            var row = tbody.insertRow();
            

colunas.forEach(function (col) {
  var td = row.insertCell();
  var valor = linha.hasOwnProperty(col) ? linha[col] : '';

  td.classList.add("celula-dado");
  td.classList.add("col-" + col.toLowerCase());

  // CLASSIFICACAO — esconde mas marca para depois
  if (col === "CLASSIFICACAO") {
    td.classList.add("classificacao-marker");
    td.style.display = "none";
  }

  // TOTAL_ATUAL
  if (col === 'TOTAL_ATUAL') {
    const atual = parseFloat(linha['TOTAL_ATUAL'].toString().replace(/[^\d,-]/g, '').replace(',', '.'));
    const anterior = parseFloat(linha['TOTAL_ANTERIOR'].toString().replace(/[^\d,-]/g, '').replace(',', '.'));

    if (!isNaN(atual) && !isNaN(anterior)) {
      const flecha = atual > anterior ? '\u25B2' : (atual < anterior ? '\u25BC' : '\u25C6');
      valor = flecha + ' ' + valor;
      td.classList.add(atual > anterior ? 'positivo' : anterior > atual ? 'negativo' : 'neutro');
    }
  }

  // DIFERENCA_VALOR
  else if (col === 'DIFERENCA_VALOR') {
    const atual = parseFloat(linha['TOTAL_ATUAL'].toString().replace(/[^\d,-]/g, '').replace(',', '.'));
    const anterior = parseFloat(linha['TOTAL_ANTERIOR'].toString().replace(/[^\d,-]/g, '').replace(',', '.'));

    if (!isNaN(atual) && !isNaN(anterior)) {
      const flecha = atual > anterior ? '\u25B2' : (atual < anterior ? '\u25BC' : '\u25C6');
      valor = flecha + ' ' + valor;
      td.classList.add(atual > anterior ? 'positivo' : anterior > atual ? 'negativo' : 'neutro');
    }
  }

  // PERCENTUAL_VARIACAO
  else if (col === 'PERCENTUAL_VARIACAO') {
    let percentualStr = valor.replace('%', '').trim().replace(',', '.');
    let percentualNum = parseFloat(percentualStr);
    if (!isNaN(percentualNum)) {
      let flecha = percentualNum > 0 ? '\u25B2' : (percentualNum < 0 ? '\u25BC' : '');
      valor = flecha + ' ' + valor;
      td.classList.add(percentualNum > 0 ? 'positivo' : percentualNum < 0 ? 'negativo' : 'neutro');
    }
  }

  td.innerText = valor;
});


            row.classList.add("linha-dado");
        });

      // Pintar linhas com base na classificação
    const linhas = tabela.querySelectorAll("tbody tr");
    linhas.forEach((linha) => {
      const classificacaoCelula = linha.querySelector(".classificacao-marker");
      if (!classificacaoCelula) return;

      const classificacao = classificacaoCelula.innerText.trim().toUpperCase();
      if (classificacao === "MELHOR") {
        linha.classList.add("melhor-linha");
      } else if (classificacao === "PIOR") {
        linha.classList.add("pior-linha");
      }
      
    });

    if (linhas.length > 1) {
      const ultima = linhas[linhas.length - 1];
      ultima.classList.add("pior-linha");
      ultima.style.backgroundColor = "#fac4c8";
    }

        tabela.style.visibility = "visible";

    } else {
        tabela.innerHTML = "<tr><td colspan='15'>Nenhum dado encontrado</td></tr>";
        tabela.style.visibility = "visible";
    }

}, function (erro) {
    console.error('Erro ao executar a query:', erro);
    alert("Erro ao executar a query: " + erro);
});

}

window.onload = carregarRanking;



</script>
</head>

<body>
<!-- TÍTULO COM FUNDO AZUL -->
<div class="titulo-container">
  <h2 class="titulo-filtros">Ranking da Franquias por Média de Vendas</h2>
</div>

<!-- CAMPOS DE DATA COM FUNDO BRANCO -->
<div class="card-filtros">
  <div class="filtros-calendario">
    <!-- Linha 1 - Mês Atual -->
    <div class="linha linha-mes">
      <div class="grupo">
        <label>Iní Mês Atual:</label>
        <input type="date" id="dtIniAtual">
      </div>
      <div class="grupo">
        <label>Fim Mês Atual:</label>
        <input type="date" id="dtFimAtual">
      </div>
    </div>

    <!-- Linha 2 - Mês Anterior -->
    <div class="linha linha-mes">
      <div class="grupo">
        <label>Iní Mês Anterior:</label>
        <input type="date" id="dtIniAnterior">
      </div>
      <div class="grupo">
        <label>Fim Mês Anterior:</label>
        <input type="date" id="dtFimAnterior">
      </div>
    </div>

    <!-- Botão -->
    <div class="linha linha-botao">
      <button onclick="carregarRanking()" id="botao">Buscar</button>
    </div>
  </div>
</div>
<div class="tabela-card">
  <table id="tabela-dados" style="visibility: hidden;"></table>
</div>
</body>
</html>

