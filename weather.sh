#!/bin/bash

# Файл для сохранения HTML
OUTPUT_FILE="/var/www/html/index.html"

# Получаем JSON с фактом о котах
JSON_DATA=$(curl -4 -s "https://catfact.ninja/fact")

# Парсим JSON с помощью jq
FACT=$(echo "$JSON_DATA" | jq -r '.fact // "Не удалось получить факт"')
LENGTH=$(echo "$JSON_DATA" | jq -r '.length // 0')

# Генерируем HTML-страницу
cat > "$OUTPUT_FILE" << EOF
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Факт о котах</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 600px;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        .fact {
            font-size: 24px;
            color: #667eea;
            line-height: 1.6;
            margin: 20px 0;
        }
        .length {
            font-size: 14px;
            color: #999;
            margin-top: 20px;
        }
        .updated {
            font-size: 12px;
            color: #bbb;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>🐱 Факт о котах</h1>
        <div class="fact">${FACT}</div>
        <div class="length">Длина текста: ${LENGTH} символов</div>
        <div class="updated">Обновлено: $(date '+%Y-%m-%d %H:%M:%S')</div>
    </div>
</body>
</html>
EOF

echo "✅ Факт обновлён: ${FACT:0:50}..."
