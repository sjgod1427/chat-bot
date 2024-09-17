// import 'dart:convert';

// import 'package:allen/secrets.dart';
// //import 'package:allen/secrets.dart';
// import 'package:http/http.dart' as http;

// class OpenAIService {
//   final List<Map<String, String>> messages = [];

//   Future<String> isArtPromptAPI(String prompt) async {
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           "model": "gpt-4o-mini",
//           "messages": [
//             {
//               'role': 'user',
//               'content':
//                   'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
//             }
//           ],
//         }),
//       );
//       print(res.body);
//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();

//         switch (content) {
//           case 'Yes':
//           case 'yes':
//           case 'Yes.':
//           case 'yes.':
//             final res = await dallEAPI(prompt);
//             return res;
//           default:
//             final res = await chatGPTAPI(prompt);
//             return res;
//         }
//       }
//       return 'An internal error occurred';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> chatGPTAPI(String prompt) async {
//     messages.add({
//       'role': 'user',
//       'content': prompt,
//     });
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           "model": "gpt-4o-mini",
//           "messages": messages,
//         }),
//       );

//       if (res.statusCode == 200) {
//         String content =
//             jsonDecode(res.body)['choices'][0]['message']['content'];
//         content = content.trim();

//         messages.add({
//           'role': 'assistant',
//           'content': content,
//         });
//         return content;
//       }
//       return 'An internal error occurred';
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String> dallEAPI(String prompt) async {
//     messages.add({
//       'role': 'user',
//       'content': prompt,
//     });
//     try {
//       final res = await http.post(
//         Uri.parse('https://api.openai.com/v1/images/generations'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $openAIAPIKey',
//         },
//         body: jsonEncode({
//           'prompt': prompt,
//           'n': 1,
//         }),
//       );

//       if (res.statusCode == 200) {
//         String imageUrl = jsonDecode(res.body)['data'][0]['url'];
//         imageUrl = imageUrl.trim();

//         messages.add({
//           'role': 'assistant',
//           'content': imageUrl,
//         });
//         return imageUrl;
//       }
//       return 'An internal error occurred';
//     } catch (e) {
//       return e.toString();
//     }
//

// import 'package:google_generative_ai/google_generative_ai.dart';

// class OpenAIService {
//   final GenerativeModel _model;

//   OpenAIService()
//       : _model = GenerativeModel(
//           model: 'gemini-1.5-flash',
//           apiKey: 'AIzaSyCSDDBMB4f6dU2Hdfvt16fLKgnz_ihRvf0',
//         );

//   Future<String?> generateContent(String prompt) async {
//     final content = [Content.text(prompt)];
//     final response = await _model.generateContent(content);
//     return response.text;
//   }
// }

import 'package:google_generative_ai/google_generative_ai.dart';

class OpenAIService {
  final GenerativeModel _model;

  OpenAIService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: 'AIzaSyCSDDBMB4f6dU2Hdfvt16fLKgnz_ihRvf0',
        );

  Future<String?> generateContent(String prompt) async {
    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);

    // Check if response.text is not null, then apply replaceAll
    final cleanedText = response.text != null
        ? response.text!.replaceAll('*', '').trim()
        : null;

    return cleanedText;
  }
}
