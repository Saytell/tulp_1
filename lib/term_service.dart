import 'dart:convert';
import 'package:http/http.dart' as http;

class TermService {
  static const _baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  static const _apiKey =
      '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'; // 🔐 вставь свой API-ключ сюда

static Future<Map<String, List<String>>> searchTerms(String prompt) 
async {
    final headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
      'HTTP-Referer': 'https://yourapp.example.com', // заменишь при публикации
      'X-Title': 'ProTermFinder',
    };

    final body = jsonEncode({
      'model': 'openai/gpt-3.5-turbo',
      'messages': [
        {
          'role': 'user',
          'content':
              """
Ты — профессиональный помощник по терминам в разных профессиональных областях.

Пользователь ввёл запрос: "$prompt"

Ответь, в каких областях это используется, и для каждой области:
- Назови область
- Объясни понятным языком, как это применяется в этой области
- Не повторяй слово "термин"
- Сделай объяснение связным и развёрнутым
- Ответ верни в JSON-массиве, где каждый элемент имеет поля "area" и "explanation"

Пример:
[
  {
    "area": "Программирование",
    "explanation": "В объектно-ориентированном программировании выделяют четыре ключевых принципа: инкапсуляция, наследование, полиморфизм и абстракция. Они позволяют создавать гибкие и поддерживаемые приложения."
  },
  {
    "area": "Информационные технологии",
    "explanation": "Принципы ООП используются в архитектуре систем, чтобы упростить поддержку, расширяемость и повторное использование компонентов."
  }
]
""",
        }
      ],
    });

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final data = jsonDecode(decodedBody);
      final content = data['choices'][0]['message']['content'];
      try {
       final decoded = jsonDecode(content);

      final Map<String, List<String>> result = {};

      for (final item in decoded) {
        final area = item['area'] as String;
        final explanation = item['explanation'] as String;

        result.putIfAbsent(area, () => []);
        result[area]!.add(explanation);
      }

      return result;
      } catch (e) {
        throw Exception('Ошибка при обработке ответа: ${e.toString()}');
      }
    } else {
      throw Exception(
          'Ошибка запроса: ${response.statusCode} ${response.body}');
    }
  }
}
