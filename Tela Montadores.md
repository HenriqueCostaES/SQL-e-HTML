``` html
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Upload Montagem e Assinaturas</title>
<!--Tailwind CSS-->

<link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">

<!-- Assinatura digital -->
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.0/dist/signature_pad.umd.min.js"></script>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>



</head>
<body  class="bg-gray-100 font-sans">
   <snk:query var="dadosMontagem">
WITH RECEBER AS (
    SELECT 
        CODMONTADOR,
        NOMEPARC,
        SUM(VLRMONT) AS TOTAL_RECEBIDO
    FROM (
        SELECT DISTINCT
            PED.NUMONTA,
            PED.CODMONTADOR,
            PED.VLRMONT,
            PAR.NOMEPARC
        FROM AD_MONTAGEMPEDIDOS PED
        LEFT JOIN AD_MONTAGEMITEM MONT ON MONT.NUMONTA = PED.NUMONTA
        LEFT JOIN TGFPAR PAR ON PAR.CODPARC = PED.CODMONTADOR
        WHERE PED.STATUS = 'CO'
          AND NUNOTAGER IS NOT NULL
    ) 
    GROUP BY CODMONTADOR, NOMEPARC
),

ITEM_UNICO AS (
    SELECT
        MONT.*,
        ROW_NUMBER() OVER (PARTITION BY MONT.NUMONTA, MONT.CODPROD ORDER BY MONT.CODPROD) AS RN
    FROM AD_MONTAGEMITEM MONT
)

SELECT 
    MONT.NUMONTA,
    MONT.CODPARC,
    TO_CHAR(CAB.AD_DT_MONTAGEM, 'DD/MM/YYYY') AS DATA,
    CAB.NUNOTA,
    PRO.CODPROD,
    PRO.DESCRPROD,
    PRO.CARACTERISTICAS,
    MONT.QTDNEG,
    MONT.PERCMONTAGEM,
    MONT.SEQUENCIA,
    TRIM(REPLACE(REPLACE(REC.NOMEPARC, 'MONTADOR', ''), '-', '')) AS NOMEPARC,
    PAR.NOMEPARC AS CLIENTE, 
    PED.CODMONTADOR,
    TO_CHAR(MONT.VLRCOMISSAOMONTAGEM, 'L999G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''R$ ''') AS VALOR,
CASE 
    WHEN MONT.ASSCLI IS NOT NULL 
     AND MONT.ASSMONT IS NOT NULL 
     AND MONT.FOTO IS NOT NULL 
    THEN 'Montagem Concluída'

    WHEN CAB.AD_DT_MONTAGEM < SYSDATE 
     AND (MONT.ASSCLI IS NULL OR MONT.ASSMONT IS NULL OR MONT.FOTO IS NULL)
    THEN 'Montagem Atrasada'

    WHEN MONT.FOTO IS NOT NULL 
    THEN 'Em Andamento'

    ELSE 'Montagem Pendente'
END AS STATUSMONTAGEM,
REPLACE(
  REPLACE(
    END.NOMEEND || ',' || TO_CHAR(CTT.NUMEND) || ',' || BAI.NOMEBAI || ',' || CID.NOMECID || ',' || UFS.UF,' ', '+'),'ã' ,'a') AS ENDERECO_MAPS,
   COALESCE(END.NOMEEND, '') || ', ' || 
COALESCE(TO_CHAR(CTT.NUMEND), '') || ', ' ||COALESCE(BAI.NOMEBAI, '') || ', ' || COALESCE(CID.NOMECID, '') || ' - ' || COALESCE(UFS.UF, '') AS ENDERECO
FROM ITEM_UNICO MONT
LEFT JOIN AD_MONTAGEMPEDIDOS PED ON PED.NUMONTA = MONT.NUMONTA
LEFT JOIN RECEBER REC ON REC.CODMONTADOR = PED.CODMONTADOR
LEFT JOIN TGFPRO PRO ON PRO.CODPROD = MONT.CODPROD
LEFT JOIN TGFCTT CTT ON CTT.CODPARC = MONT.CODPARC
LEFT JOIN TSIBAI BAI ON BAI.CODBAI = CTT.CODBAI            
LEFT JOIN TSICID CID ON CID.CODCID = CTT.CODCID
LEFT JOIN TSIEND END ON END.CODEND = CTT.CODEND
LEFT JOIN TSIUFS UFS ON UFS.CODUF = CID.UF
LEFT JOIN TGFPAR PAR ON PAR.CODPARC = MONT.CODPARC
LEFT JOIN TGFCAB CAB ON CAB.NUNOTA = MONT.NUNOTA
WHERE CTT.ATIVO = 'S'
AND (MONT.ASSCLI IS NULL OR MONT.ASSMONT IS NULL OR MONT.FOTO IS NULL)

AND PED.CODMONTADOR = 172023
AND CAB.AD_DT_MONTAGEM IS NOT NULL
ORDER BY 
  CASE 
    WHEN (CAB.AD_DT_MONTAGEM < SYSDATE 
          AND (MONT.ASSCLI IS NULL OR MONT.ASSMONT IS NULL OR MONT.FOTO IS NULL))
    THEN 1 
    ELSE 2 
  END,
  CAB.AD_DT_MONTAGEM ASC ,MONT.NUMONTA, MONT.SEQUENCIA

    </snk:query>
    <!--
    WHERE MONT.RN = 1
  AND NUNOTAGER IS NOT NULL
  AND MONT.VLRCOMISSAOMONTAGEM IS NOT NULL 
  AND CTT.ATIVO = 'S' 
  --adicionar um case pra a dtmontagem > sysdate = montagem atrasada -->
    <!-- 
    <snk:query var="total">
        
    SELECT 
        CODMONTADOR,
        TRIM(REPLACE(REPLACE(NOMEPARC, 'MONTADOR', ''), '-', '')) AS NOMEPARC,
        TO_CHAR(SUM(VLRMONT), 'L999G999D99', 'NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''R$ ''') AS TOTAL_RECEBIDO
    FROM (
        SELECT DISTINCT
            PED.NUMONTA,
            PED.CODMONTADOR,
            PED.VLRMONT,
            PAR.NOMEPARC
        FROM AD_MONTAGEMPEDIDOS PED
        LEFT JOIN AD_MONTAGEMITEM MONT ON MONT.NUMONTA = PED.NUMONTA
        LEFT JOIN TGFPAR PAR ON PAR.CODPARC = PED.CODMONTADOR
        WHERE PED.STATUS = 'CO'
          AND NUNOTAGER IS NOT NULL
) GROUP BY CODMONTADOR, NOMEPARC
</snk:query>
 Total Recebido por Montador 
<div class="bg-green-600 text-white py-6 px-4 shadow-lg mb-8 rounded-b-lg">
  <h1 class="text-3xl font-bold text-center mb-4">Total Recebido por Montador</h1>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 max-w-6xl mx-auto">
    <c:forEach items="${total.rows}" var="t">
      <div class="bg-white text-green-800 rounded-lg p-4 shadow text-center font-bold border border-green-300">
        ${t.NOMEPARC}: R$ ${t.TOTAL_RECEBIDO}
      </div>
    </c:forEach>
  </div>
</div> -->
<!--Topo da página-->
<div class="bg-green-600 text-white py-6 px-4 shadow-lg mb-8 rounded-b-lg">
  <h1 class="text-3xl font-bold text-center mb-4"> Montagens Pendentes</h1>
  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 max-w-6xl mx-auto">
  </div>
</div>
<!-- Cards da Montagem -->
<div class="container mx-auto p-4">

  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <c:forEach items="${dadosMontagem.rows}" var="item">
      <div class="card bg-white rounded-xl border border-gray-200 shadow p-4 hover:shadow-lg transition">

        <!-- Nota e Características -->
        <div class="flex items-center justify-between mb-2">
          <p class="text-sm text-gray-600">Nº da Nota: <strong>${item.NUNOTA}</strong></p>
          <button type="button"
                  data-text="${fn:escapeXml(item.CARACTERISTICAS)}"
                  class="textModalBtn w-6 h-6 flex items-center justify-center bg-blue-500 text-white text-sm font-bold rounded-full hover:bg-blue-600 shadow">
            ?
          </button>
        </div>

        <!-- Imagem do Produto -->
        <img src="http://valdirmoveis.snk.ativy.com:50266/mge/Produto@IMAGEM@CODPROD=${item.CODPROD}.dbimage"
             alt="Imagem Produto"
             class="w-full h-32 object-cover rounded mb-2 cursor-pointer hover:opacity-80 transition"
             onclick="openModal(this.src)">
        <!-- Info da montagem -->
        <p class="text-sm text-gray-600 mb-1">Nº da Montagem: <strong>${item.NUMONTA}</strong></p>
        <p class="text-sm text-gray-600 mb-1">Cliente: <strong>${item.CLIENTE}</strong></p>
        <p class="text-sm text-gray-600 mb-1">Data da Montagem: <strong>${item.DATA}</strong></p>
        <p class="text-sm text-gray-600 mb-1">
          Endereço: 
          <a href="https://www.google.com/maps/dir/?api=1&origin=&destination=${item.ENDERECO_MAPS}" target="_blank" class="text-blue-600 hover:underline">
            ${item.ENDERECO}
          </a>
        </p>
        <p class="text-sm text-gray-600 mb-1">Produto: <strong>${item.DESCRPROD}</strong></p>
        <p class="text-sm text-gray-600 mb-1">Qtd: <strong>${item.QTDNEG}</strong></p>

        <!-- Status colorido -->
        <c:choose>
              <c:when test="${item.STATUSMONTAGEM == 'Montagem Pendente'}">
                <p class="text-sm text-yellow-600 font-semibold">Status: <strong>${item.STATUSMONTAGEM}</strong></p>
              </c:when>
              <c:when test="${item.STATUSMONTAGEM == 'Em Andamento'}">
                <p class="text-sm text-blue-600 font-semibold">Status: <strong>${item.STATUSMONTAGEM}</strong></p>
              </c:when>
              <c:when test="${item.STATUSMONTAGEM == 'Montagem Concluída'}">
                <p class="text-sm text-green-600 font-semibold">Status: <strong>${item.STATUSMONTAGEM}</strong></p>
              </c:when>
              <c:when test="${item.STATUSMONTAGEM == 'Montagem Atrasada'}">
                <p class="text-sm text-red-600 font-semibold">Status: <strong>${item.STATUSMONTAGEM}</strong></p>
              </c:when>
              <c:otherwise>
                <p class="text-sm text-gray-600 font-semibold">Status: <strong>${item.STATUSMONTAGEM}</strong></p>
              </c:otherwise>
        </c:choose>

        <div class="grid grid-cols-1 sm:grid-cols-2 gap-2 mt-2">

          <!-- Selecionar Imagem -->
          <label class="bg-blue-600 text-white text-sm px-3 py-2 rounded hover:bg-blue-700 cursor-pointer flex items-center justify-center relative">
            Selecionar Imagem
            <!-- Input invisível, mas clicável -->
            <input type="file" class="inputImagem absolute inset-0 w-full h-full opacity-0 cursor-pointer">
          </label>

          <!-- Ver Imagem -->
        <button type="button"
                onclick="openModal('http://valdirmoveis.snk.ativy.com:50266/mge/AD_MONTAGEMITEM@FOTO@NUMONTA=${item.NUMONTA}@SEQUENCIA=${item.SEQUENCIA}.dbimage', 90)"
                class="bg-gray-200 text-gray-800 text-sm px-3 py-2 rounded hover:bg-gray-300">
          Ver imagem
        </button>


          <!-- Botões de assinatura na segunda linha -->
          <button onclick="openSignatureClienteModal('${item.NUMONTA}', '${item.SEQUENCIA}')"
                  class="bg-green-500 text-white px-3 py-2 rounded hover:bg-green-600">
            Assinar Cliente
          </button>

          <button onclick="openSignatureMontadorModal('${item.NUMONTA}', '${item.SEQUENCIA}')"
                  class="bg-blue-500 text-white px-3 py-2 rounded hover:bg-blue-600">
            Assinar Montador
          </button>

          <!-- Hidden inputs necessários para a lógica -->
          <input type="hidden" class="numonta" value="${item.NUMONTA}">
          <input type="hidden" class="sequenciaItem" value="${item.SEQUENCIA}">

        </div>
      </div>
    </c:forEach>
  </div>
</div>

<!-- Modal de Assinatura Cliente -->
<div id="signatureClienteModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-70 flex items-center justify-center p-4">
  <div class="bg-white rounded-lg shadow-lg w-full max-w-4xl h-full max-h-[90vh] flex flex-col">
    <!-- Cabeçalho -->
    <div class="flex justify-between items-center mb-2 p-4 border-b">
      <h2 class="text-xl font-bold">Assinatura do Cliente</h2>
      <button onclick="closeSignatureClienteModal()" class="text-red-500 font-bold text-2xl">&times;</button>
    </div>

      <!-- Canvas -->
      <div class="flex-grow p-4">
        <canvas id="signatureClienteCanvas" class="border rounded w-full h-full"></canvas>
      </div>

    <!-- Botões -->
    <div class="mt-2 flex justify-end gap-3 p-4 border-t">
      <button id="clearCliente" class="bg-gray-400 text-white px-4 py-2 rounded hover:bg-gray-500">Limpar</button>
      <button id="saveCliente" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Salvar</button>
    </div>
  </div>
</div>

<!-- Modal de Assinatura Montador -->
<div id="signatureMontadorModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-70 flex items-center justify-center p-4">
  <div class="bg-white rounded-lg shadow-lg w-full max-w-4xl h-full max-h-[90vh] flex flex-col">
    <!-- Cabeçalho -->
    <div class="flex justify-between items-center mb-2 p-4 border-b">
      <h2 class="text-xl font-bold">Assinatura do Montador</h2>
      <button onclick="closeSignatureMontadorModal()" class="text-red-500 font-bold text-2xl">&times;</button>
    </div>

    <!-- Canvas -->
    <div class="flex-grow p-4">
      <canvas id="signatureMontadorCanvas" class="border rounded w-full h-full"></canvas>
    </div>

    <!-- Botões -->
    <div class="mt-2 flex justify-end gap-3 p-4 border-t">
      <button id="clearMontador" class="bg-gray-400 text-white px-4 py-2 rounded hover:bg-gray-500">Limpar</button>
      <button id="saveMontador" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Salvar</button>
    </div>
  </div>
</div>


<!-- Modal de texto -->
<div id="textModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-70 flex items-center justify-center p-4">
  <div class="bg-white rounded-lg shadow-lg w-full max-w-md flex flex-col">
    <!-- Botão de fechar -->
    <button onclick="closeTextModal()" 
        class="self-start w-10 h-10 flex items-center justify-center bg-red-500 rounded-full hover:bg-red-300 shadow m-2">
        <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
        </svg>
    </button>

    <!-- Modal do texto -->
    <div id="modalTextContent" 
         class="text-gray-800 text-sm leading-tight p-4 overflow-y-auto h-64">
    </div>
  </div>
</div>

<!-- Modal da imagem Upada e do Produto-->
<div id="imageModal" class="fixed inset-0 z-50 hidden bg-black bg-opacity-70 flex items-center justify-center p-4">
  <div class="relative bg-white rounded-lg shadow-lg max-w-lg w-auto flex flex-col">
    <button onclick="closeModal()" class="w-10 h-10 flex items-center justify-center bg-red-500 rounded-full hover:bg-red-300 shadow absolute top-2 left-2">
      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
      </svg>
    </button>

    <!--Imagem do valdir como placeholder-->
    <img id="modalImage" 
     src="" 
     alt="Imagem Ampliada" 
     class="max-w-full max-h-screen rounded-lg shadow-lg"
     onerror="this.src='https://i.postimg.cc/cH0RSS8D/Chat-GPT-Image-19-de-ago-de-2025-10-15-57.png'">

  </div>
</div>
```
```javascript
<script>
const mgeSession = '<%= session.getAttribute("mgeSession") %>';

// Funções modais
function openTextModal(text) {
  document.getElementById('modalTextContent').innerText = text;
  document.getElementById('textModal').classList.remove('hidden');
}
function closeTextModal() {
  document.getElementById('textModal').classList.add('hidden');
}
function openModal(src) {
  document.getElementById('modalImage').src = src;
  document.getElementById('imageModal').classList.remove('hidden');
}
function closeModal() {
  document.getElementById('imageModal').classList.add('hidden');
}
function enableClickOutsideClose(modalId, closeFunction) {
  const modal = document.getElementById(modalId);
  modal.addEventListener('click', function(e) {
    if (e.target.id === modalId) closeFunction();
  });
}
enableClickOutsideClose('imageModal', closeModal);
enableClickOutsideClose('textModal', closeTextModal);

// Botão modal de texto
document.querySelectorAll('.textModalBtn').forEach(btn => {
  btn.addEventListener('click', () => openTextModal(btn.dataset.text));
});

// ------------------- SIGNATURE -------------------
const clienteCanvas = document.getElementById('signatureClienteCanvas');
const montadorCanvas = document.getElementById('signatureMontadorCanvas');
const clientePad = new SignaturePad(clienteCanvas, { backgroundColor: 'white' });
const montadorPad = new SignaturePad(montadorCanvas, { backgroundColor: 'white' });
let currentNumonta, currentSequencia;

// Redimensiona o canvas sem distorção
function resizeCanvas(canvas, signaturePad) {
  const ratio = Math.max(window.devicePixelRatio || 1, 1);
  canvas.width = canvas.offsetWidth * ratio;
  canvas.height = canvas.offsetHeight * ratio;
  canvas.getContext("2d").scale(ratio, ratio);
  signaturePad.clear();
}

// ---------------- Abrir e fechar modais ----------------

// Cliente
function openSignatureClienteModal(numonta, sequencia) {
  currentNumonta = numonta;
  currentSequencia = sequencia;
  const modal = document.getElementById('signatureClienteModal');
  modal.classList.remove('hidden');

  // redimensiona após o modal estar visível
  setTimeout(() => resizeCanvas(clienteCanvas, clientePad), 50);
}

function closeSignatureClienteModal() {
  document.getElementById('signatureClienteModal').classList.add('hidden');
}

// Montador
function openSignatureMontadorModal(numonta, sequencia) {
  currentNumonta = numonta;
  currentSequencia = sequencia;
  const modal = document.getElementById('signatureMontadorModal');
  modal.classList.remove('hidden');

  setTimeout(() => resizeCanvas(montadorCanvas, montadorPad), 50);
}

function closeSignatureMontadorModal() {
  document.getElementById('signatureMontadorModal').classList.add('hidden');
}

// ---------------- Limpar canvas ----------------
document.getElementById('clearCliente').addEventListener('click', () => clientePad.clear());
document.getElementById('clearMontador').addEventListener('click', () => montadorPad.clear());

// ---------------- Redimensionar ao mudar tela ----------------
window.addEventListener('resize', () => {
  if (!clientePad.isEmpty()) resizeCanvas(clienteCanvas, clientePad);
  if (!montadorPad.isEmpty()) resizeCanvas(montadorCanvas, montadorPad);
});

// Função auxiliar para enviar assinatura
async function uploadSignature(blob, sessionKey, field) {
  const url = `/mge/sessionUpload.mge?sessionkey=${sessionKey}&fitem=S&salvar=S&useCache=N&mgeSession=${mgeSession}`;
  const formData = new FormData();
  formData.append('arquivo', blob);
  await fetch(url, { method: 'POST', body: formData });

  const saveUrl = `/mge/service.sbr?serviceName=CRUDServiceProvider.saveRecord&mgeSession=${mgeSession}&outputType=json`;
  const body = {
    requestBody: {
      dataSet: {
        rootEntity: 'AD_MONTAGEMITEM',
        includePresentationFields: 'N',
        dataRow: {
          key: { NUMONTA: { "$": currentNumonta }, SEQUENCIA: { "$": currentSequencia } },
          localFields: { [field]: { "$": `$file.session.key{${sessionKey}}` } }
        },
        entity: { fieldset: { list: "" } }
      }
    }
  };
  await fetch(saveUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
}

// Salvar assinatura
document.getElementById('saveCliente').addEventListener('click', async () => {
  if (clientePad.isEmpty()) return alert('Assine antes de salvar.');
  const blob = dataURLtoBlob(clientePad.toDataURL('image/png'));
  await uploadSignature(blob, 'ASSCLI_FOTO', 'ASSCLI');
Swal.fire({
  icon: 'success',
  title: 'Assinatura salva!',
  text: 'A assinatura do cliente foi registrada com sucesso.',
  timer: 1500,
  showConfirmButton: false
});
  closeSignatureClienteModal();
  atualizarMontagens();
});
document.getElementById('saveMontador').addEventListener('click', async () => {
  if (montadorPad.isEmpty()) return alert('Assine antes de salvar.');
  const blob = dataURLtoBlob(montadorPad.toDataURL('image/png'));
  await uploadSignature(blob, 'ASSMONT_FOTO', 'ASSMONT');
Swal.fire({
  icon: 'success',
  title: 'Assinatura salva!',
  text: 'A assinatura do montador foi registrada com sucesso.',
  timer: 1500,
  showConfirmButton: false
});

  closeSignatureMontadorModal();
  atualizarMontagens();
});

// Função conversão base64 -> blob
function dataURLtoBlob(dataURL) {
  const parts = dataURL.split(',');
  const mime = parts[0].match(/:(.*?);/)[1];
  const bstr = atob(parts[1]);
  let n = bstr.length;
  const u8arr = new Uint8Array(n);
  while (n--) u8arr[n] = bstr.charCodeAt(n);
  return new Blob([u8arr], { type: mime });
}

// Pré-visualização da imagem e botão de envio 
document.querySelectorAll('.inputImagem').forEach(input => {
  input.addEventListener('change', () => {
    const file = input.files[0];
    if (!file || !file.type.startsWith('image/')) {
      Swal.fire('Arquivo inválido', 'Por favor selecione uma imagem.', 'error');
      input.value = ''; 
      return;
    }

    Swal.fire({
      title: 'Pré-visualização',
      text: 'Deseja enviar esta imagem?',
      imageUrl: URL.createObjectURL(file),
      imageAlt: 'Pré-visualização da imagem',
      showCancelButton: true,
      confirmButtonText: 'Sim, enviar',
      cancelButtonText: 'Cancelar'
    }).then(result => {
      if (result.isConfirmed) {
        enviarImagem(input, file);
      } else {
        input.value = '';
      }
    });
  });
});

async function enviarImagem(input, arquivo) {
  const card = input.closest('.card');
  const numonta = card.querySelector('.numonta').value;
  const sequenciaItem = card.querySelector('.sequenciaItem').value;

  Swal.fire({
    title: 'Enviando...',
    text: 'Aguarde enquanto fazemos o upload.',
    allowOutsideClick: false,
    didOpen: () => {
      Swal.showLoading();
    }
  });

  // Upload para Sankhya
  const url = `/mge/sessionUpload.mge?sessionkey=MONTAGEM_FOTO&fitem=S&salvar=S&useCache=N&mgeSession=${mgeSession}`;
  const formData = new FormData();
  formData.append('arquivo', arquivo);
  await fetch(url, { method: 'POST', body: formData });

  // Salva referência no registro
  const saveUrl = `/mge/service.sbr?serviceName=CRUDServiceProvider.saveRecord&mgeSession=${mgeSession}&outputType=json`;
  const body = {
    requestBody: {
      dataSet: {
        rootEntity: 'AD_MONTAGEMITEM',
        includePresentationFields: 'N',
        dataRow: {
          key: { NUMONTA: { "$": numonta }, SEQUENCIA: { "$": sequenciaItem } },
          localFields: { FOTO: { "$": `$file.session.key{MONTAGEM_FOTO}` } }
        },
        entity: { fieldset: { list: "" } }
      }
    }
  };

  await fetch(saveUrl, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });

  Swal.fire('Sucesso!', 'Imagem enviada com sucesso.', 'success');
}
atualizarMontagens();

</script>
```
</body>
</html>

```


