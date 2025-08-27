```html
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f0f2f5;
      margin: 0;
      padding: 0;
      width: 575px;
      height: 448px;
    }

    .ranking-container {
      background: linear-gradient(to bottom, #ffffff, #f9f9f9);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      overflow: hidden;
    }

    .ranking-header {
      background: linear-gradient(to right, #0078d4, #00c6ff);
      padding: 16px 10px;
      text-align: center;
      color: white;
      font-size: 18px;
      font-weight: bold;
    }

    .ranking-list {
    list-style: none;
    padding-left: 5px;
    }
    .colunas,
    .ranking-item {
      display: grid;
      grid-template-columns: 0.1fr 2fr 1.4fr 1.4fr 1.4fr 1fr;
      gap: 6px;
      align-items: center;
      padding: 10px 5px;
      justify-items: start;

    }

    .colunas {
      background: linear-gradient(to right, #0078d4, #00c6ff);
      color: white;
      font-weight: bold;
      font-size: 13px;
      padding-left: 5px;

    }

    .ranking-item {
      border-bottom: 1px solid #ddd;
      background-color: white;
      transition: background-color 0.2s ease-in-out;
    }

    .ranking-item:hover {
      background-color: #f0f4f9;
    }

    .ranking-item.top1 {
      background: linear-gradient(to right, #e0f8e9, #d3f8dd);
      border-left: 4px solid #27ae60;
    }

    .ranking-item.pior {
      background-color: #fff0f0;
      border-left: 4px solid #e74c3c;
    }


    .atual, .anterior, .diferenca, .percentual {
      display: flex;
      align-items: center;
      justify-content: flex-end;
      font-size: 10px;
      font-weight: 600;
      gap: 6px;
    }
    .rank, .col-franquia {
      align-items: start;
      display: flex;
      font-size: 10px;
      font-weight: 600;
      gap: 6px;
    }

    .arrow {
      width: 10px;
      text-align: center;
    }
    .valor {
      font-size: 10px;
      min-width: 60px;
      text-align: right;
    }
    .percentual .valor {
      min-width: 30px;
  }

    .positivo { color: green; }
    .negativo { color: red; }
    .neutro   { color: black; }
```
