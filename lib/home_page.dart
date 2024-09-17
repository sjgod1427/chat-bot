// import 'package:allen/openai_service.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:allen/feature_box.dart';
// import 'package:allen/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   FlutterTts flutterTts = FlutterTts();
//   String lastWords = '';
//   //final OpenAIService openAIService = OpenAIService();
//   String? generatedContent;
//   String? generatedImageUrl;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//   }

//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   // Future<void> initSpeechToText() async {
//   //   bool available = await speechToText.initialize(
//   //     onStatus: (val) => print('onStatus: $val'),
//   //     onError: (val) => print('onError: $val'),
//   //   );
//   //   if (!available) {
//   //     print("Speech recognition not available");
//   //   }
//   //   setState(() {});
//   // }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   // Future<void> startListening() async {
//   //   if (await speechToText.hasPermission) {
//   //     await speechToText.listen(onResult: onSpeechResult);
//   //     setState(() {});
//   //   } else {
//   //     print("Permission not granted");
//   //   }
//   // }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {
//     await flutterTts.speak(content);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//     flutterTts.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // Background image
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/images/jarvis.gif"),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // Scaffold with transparent AppBar
//         Scaffold(
//           backgroundColor:
//               Colors.transparent, // Makes the Scaffold background transparent
//           appBar: AppBar(
//             leading: const Icon(
//               Icons.menu,
//               color: Colors.white,
//             ),
//             title: BounceInDown(
//               child: const Text(
//                 'JARVIS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent, // Makes the AppBar transparent
//             elevation: 0, // Removes the shadow beneath the AppBar
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: ZoomIn(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       margin: const EdgeInsets.only(top: 4.0),
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Pallete.assistantCircleColor,
//                         image: DecorationImage(
//                             image: AssetImage("assets/images/jarvis_2.gif"),
//                             fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FadeInRight(
//                   delay: const Duration(seconds: 2),
//                   child: Visibility(
//                     visible: generatedImageUrl == null,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       margin: const EdgeInsets.symmetric(horizontal: 40)
//                           .copyWith(top: 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Pallete.borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                             .copyWith(topLeft: Radius.zero),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           generatedContent == null
//                               ? 'Good Morning, What task can I do for You!'
//                               : generatedContent!,
//                           style: TextStyle(
//                             fontFamily: 'Cera Pro',
//                             color: const Color.fromARGB(255, 217, 223, 228),
//                             fontSize: generatedContent == null ? 25 : 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (generatedImageUrl != null)
//                   Image.network(generatedImageUrl!),
//                 FadeInLeft(
//                   delay: const Duration(seconds: 3),
//                   child: Visibility(
//                     visible:
//                         generatedContent == null && generatedImageUrl == null,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.only(top: 10, left: 22),
//                       child: const Text(
//                         'Here are a few features',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Cera Pro',
//                           color: Color.fromARGB(255, 190, 195, 199),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       generatedContent == null && generatedImageUrl == null,
//                   child: Column(
//                     children: [
//                       FadeInRight(
//                         delay: const Duration(seconds: 4),
//                         child: const FeatureBox(
//                           color: Pallete.firstSuggestionBoxColor,
//                           headerText: 'CHATGPT',
//                           descriptionText:
//                               'A faster way to stay organized and informed with ChatGPT',
//                         ),
//                       ),
//                       FadeInLeft(
//                         delay: const Duration(seconds: 5),
//                         child: const FeatureBox(
//                           color: Pallete.secondSuggestionBoxColor,
//                           headerText: 'DALL-E',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       ),
//                       FadeInRight(
//                         delay: const Duration(seconds: 6),
//                         child: const FeatureBox(
//                           color: Pallete.thirdSuggestionBoxColor,
//                           headerText: 'Smart Voice Assistant',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (await speechToText.hasPermission &&
//                   speechToText.isNotListening) {
//                 await startListening();
//               } else if (speechToText.isListening) {
//                 final speech = await openAIService.isArtPromptAPI(lastWords);
//                 if (speech.contains('https')) {
//                   generatedImageUrl = speech;
//                   generatedContent = null;
//                   setState(() {});
//                 } else {
//                   generatedContent = speech;
//                   generatedImageUrl = null;
//                   setState(() {});
//                   await systemSpeak(speech);
//                 }
//                 await stopListening();
//               } else {
//                 initSpeechToText();
//               }
//               // if (await speechToText.hasPermission &&
//               //     speechToText.isNotListening) {
//               //   print("Starting to listen...");
//               //   await startListening();
//               // } else if (speechToText.isListening) {
//               //   print("Stopping listening...");
//               //   await openAIService.isArtPromptAPI(lastWords);
//               //   await stopListening();
//               // } else {
//               //   print("Initializing speech recognition...");
//               //   await initSpeechToText();
//               // }
//             },
//             child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:allen/openai_service.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:allen/feature_box.dart';
// import 'package:allen/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   FlutterTts flutterTts = FlutterTts();
//   String lastWords = '';
//   final OpenAIService openAIService =
//       OpenAIService(); // Initialize the OpenAIService
//   String? generatedContent;
//   String? generatedImageUrl;
//   var background;
//   var b_title;
//   var jarvis;
//   var j_title;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//     background = const AssetImage("assets/images/jarvis.gif");
//     b_title = "assets/images/jarvis.gif";
//     jarvis = const AssetImage("assets/images/jarvis_2.gif");
//     j_title = "assets/images/jarvis_2.gif";
//   }

//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {
//     await flutterTts.speak(content);
//   }

//   void _changeBackground() {
//     if (b_title == "assets/images/jarvis.gif")
//       setState(() {
//         background = const AssetImage("assets/images/background_jarvis.gif");
//         b_title = "assets/images/background_jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis.gif");
//       });
//     else {
//       setState(() {
//         background = const AssetImage("assets/images/jarvis.gif");
//         b_title = "assets/images/jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis_2.gif");
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//     flutterTts.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: background, // background
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           drawer: Drawer(
//               surfaceTintColor: Colors.white,
//               child: Column(
//                 children: [
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: [
//                       Theme.of(context).colorScheme.primaryContainer,
//                       Theme.of(context).colorScheme.secondaryContainer
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                     child: Expanded(
//                       child: Row(
//                         children: [
//                           const Icon(Icons.format_paint, size: 50),
//                           const SizedBox(width: 14),
//                           Text(
//                             'THEMES',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimaryContainer
//                                         .withOpacity(0.8),
//                                     fontSize: 20),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                       leading: Icon(Icons.settings),
//                       title: Text(
//                         'CHNAGE LOOK',
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall!
//                             .copyWith(color: Colors.black, fontSize: 20),
//                       ),
//                       onTap: () {
//                         _changeBackground();
//                       }),
//                   // ListTile(
//                   //     leading: const Icon(Icons.settings),
//                   //     title: Text(
//                   //       'Miss Jarvis 2',
//                   //       style: Theme.of(context)
//                   //           .textTheme
//                   //           .titleSmall!
//                   //           .copyWith(color: Colors.black, fontSize: 20),
//                   //     ),
//                   //     onTap: () {}),
//                 ],
//               )),
//           appBar: AppBar(
//             // leading: const Icon(
//             //   Icons.menu,
//             //   color: Colors.white,
//             // ),
//             title: BounceInDown(
//               child: const Text(
//                 'JARVIS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: ZoomIn(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       margin: const EdgeInsets.only(top: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Pallete.assistantCircleColor,
//                         image:
//                             DecorationImage(image: jarvis!, fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FadeInRight(
//                   delay: const Duration(seconds: 2),
//                   child: Visibility(
//                     visible: generatedImageUrl == null,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       margin: const EdgeInsets.symmetric(horizontal: 40)
//                           .copyWith(top: 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Pallete.borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                             .copyWith(topLeft: Radius.zero),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           generatedContent == null
//                               ? 'Good Morning, What task can I do for You!'
//                               : generatedContent!,
//                           style: TextStyle(
//                             fontFamily: 'Cera Pro',
//                             color: const Color.fromARGB(255, 217, 223, 228),
//                             fontSize: generatedContent == null ? 25 : 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (generatedImageUrl != null)
//                   Image.network(generatedImageUrl!),
//                 FadeInLeft(
//                   delay: const Duration(seconds: 3),
//                   child: Visibility(
//                     visible:
//                         generatedContent == null && generatedImageUrl == null,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.only(top: 10, left: 22),
//                       child: const Text(
//                         'Here are a few features',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Cera Pro',
//                           color: Color.fromARGB(255, 190, 195, 199),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       generatedContent == null && generatedImageUrl == null,
//                   child: Column(
//                     children: [
//                       FadeInRight(
//                         delay: const Duration(seconds: 4),
//                         child: const FeatureBox(
//                           color: Pallete.firstSuggestionBoxColor,
//                           headerText: 'CHATGPT',
//                           descriptionText:
//                               'A faster way to stay organized and informed with ChatGPT',
//                         ),
//                       ),
//                       FadeInLeft(
//                         delay: const Duration(seconds: 5),
//                         child: const FeatureBox(
//                           color: Pallete.secondSuggestionBoxColor,
//                           headerText: 'DALL-E',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       ),
//                       FadeInRight(
//                         delay: const Duration(seconds: 6),
//                         child: const FeatureBox(
//                           color: Pallete.thirdSuggestionBoxColor,
//                           headerText: 'Smart Voice Assistant',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (await speechToText.hasPermission &&
//                   speechToText.isNotListening) {
//                 await startListening();
//               } else if (speechToText.isListening) {
//                 final speech = await openAIService
//                     .generateContent(lastWords); // Call OpenAIService method
//                 generatedContent = speech;
//                 generatedImageUrl = null;
//                 setState(() {});
//                 await systemSpeak(speech!);
//                 await stopListening();
//               } else {
//                 initSpeechToText();
//               }
//             },
//             child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:allen/openai_service.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:allen/feature_box.dart';
// import 'package:allen/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   FlutterTts flutterTts = FlutterTts();
//   String lastWords = '';
//   final OpenAIService openAIService = OpenAIService();
//   String? generatedContent;
//   String? generatedImageUrl;
//   var background;
//   var b_title;
//   var jarvis;
//   var j_title;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//     background = const AssetImage("assets/images/jarvis.gif");
//     b_title = "assets/images/jarvis.gif";
//     jarvis = const AssetImage("assets/images/jarvis_2.gif");
//     j_title = "assets/images/jarvis_2.gif";
//   }

//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {
//     // Ensure that the content is clean before speaking
//     final cleanContent = content.replaceAll('*', '').trim();
//     await flutterTts.speak(cleanContent);
//   }

//   void _changeBackground() {
//     if (b_title == "assets/images/jarvis.gif") {
//       setState(() {
//         background = const AssetImage("assets/images/background_jarvis.gif");
//         b_title = "assets/images/background_jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis.gif");
//       });
//     } else {
//       setState(() {
//         background = const AssetImage("assets/images/jarvis.gif");
//         b_title = "assets/images/jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis_2.gif");
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//     flutterTts.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: background,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           drawer: Drawer(
//               surfaceTintColor: Colors.white,
//               child: Column(
//                 children: [
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: [
//                       Theme.of(context).colorScheme.primaryContainer,
//                       Theme.of(context).colorScheme.secondaryContainer
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                     child: Expanded(
//                       child: Row(
//                         children: [
//                           const Icon(Icons.format_paint, size: 50),
//                           const SizedBox(width: 14),
//                           Text(
//                             'THEMES',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimaryContainer
//                                         .withOpacity(0.8),
//                                     fontSize: 20),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                       leading: Icon(Icons.settings),
//                       title: Text(
//                         'CHANGE LOOK',
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall!
//                             .copyWith(color: Colors.black, fontSize: 20),
//                       ),
//                       onTap: () {
//                         _changeBackground();
//                       }),
//                 ],
//               )),
//           appBar: AppBar(
//             title: BounceInDown(
//               child: const Text(
//                 'JARVIS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: ZoomIn(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       margin: const EdgeInsets.only(top: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Pallete.assistantCircleColor,
//                         image:
//                             DecorationImage(image: jarvis!, fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FadeInRight(
//                   delay: const Duration(seconds: 2),
//                   child: Visibility(
//                     visible: generatedImageUrl == null,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       margin: const EdgeInsets.symmetric(horizontal: 40)
//                           .copyWith(top: 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Pallete.borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                             .copyWith(topLeft: Radius.zero),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           generatedContent == null
//                               ? 'Good Morning, What task can I do for You!'
//                               : generatedContent!,
//                           style: TextStyle(
//                             fontFamily: 'Cera Pro',
//                             color: const Color.fromARGB(255, 217, 223, 228),
//                             fontSize: generatedContent == null ? 25 : 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (generatedImageUrl != null)
//                   Image.network(generatedImageUrl!),
//                 FadeInLeft(
//                   delay: const Duration(seconds: 3),
//                   child: Visibility(
//                     visible:
//                         generatedContent == null && generatedImageUrl == null,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.only(top: 10, left: 22),
//                       child: const Text(
//                         'Here are a few features',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Cera Pro',
//                           color: Color.fromARGB(255, 190, 195, 199),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       generatedContent == null && generatedImageUrl == null,
//                   child: Column(
//                     children: [
//                       FadeInRight(
//                         delay: const Duration(seconds: 4),
//                         child: const FeatureBox(
//                           color: Pallete.firstSuggestionBoxColor,
//                           headerText: 'CHATGPT',
//                           descriptionText:
//                               'A faster way to stay organized and informed with ChatGPT',
//                         ),
//                       ),
//                       FadeInLeft(
//                         delay: const Duration(seconds: 5),
//                         child: const FeatureBox(
//                           color: Pallete.secondSuggestionBoxColor,
//                           headerText: 'DALL-E',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       ),
//                       FadeInRight(
//                         delay: const Duration(seconds: 6),
//                         child: const FeatureBox(
//                           color: Pallete.thirdSuggestionBoxColor,
//                           headerText: 'Smart Voice Assistant',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (await speechToText.hasPermission &&
//                   speechToText.isNotListening) {
//                 await startListening();
//               } else if (speechToText.isListening) {
//                 final speech = await openAIService
//                     .generateContent(lastWords); // Call OpenAIService method
//                 generatedContent = speech;
//                 generatedImageUrl = null;
//                 setState(() {});
//                 await systemSpeak(speech!);
//                 await stopListening();
//               } else {
//                 initSpeechToText();
//               }
//             },
//             child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:allen/openai_service.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:allen/feature_box.dart';
// import 'package:allen/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   FlutterTts flutterTts = FlutterTts();
//   String lastWords = '';
//   final OpenAIService openAIService =
//       OpenAIService(); // Initialize the OpenAIService
//   String? generatedContent;
//   String? generatedImageUrl;
//   var background;
//   var b_title;
//   var jarvis;
//   var j_title;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//     background = const AssetImage("assets/images/jarvis.gif");
//     b_title = "assets/images/jarvis.gif";
//     jarvis = const AssetImage("assets/images/jarvis_2.gif");
//     j_title = "assets/images/jarvis_2.gif";
//   }

//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {
//     await flutterTts.speak(content);
//   }

//   Future<void> stopSpeaking() async {
//     await flutterTts.stop();
//   }

//   void _changeBackground() {
//     if (b_title == "assets/images/jarvis.gif")
//       setState(() {
//         background = const AssetImage("assets/images/background_jarvis.gif");
//         b_title = "assets/images/background_jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis.gif");
//       });
//     else {
//       setState(() {
//         background = const AssetImage("assets/images/jarvis.gif");
//         b_title = "assets/images/jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis_2.gif");
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//     flutterTts.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: background, // background
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           drawer: Drawer(
//               surfaceTintColor: Colors.white,
//               child: Column(
//                 children: [
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: [
//                       Theme.of(context).colorScheme.primaryContainer,
//                       Theme.of(context).colorScheme.secondaryContainer
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                     child: Expanded(
//                       child: Row(
//                         children: [
//                           const Icon(Icons.format_paint, size: 50),
//                           const SizedBox(width: 14),
//                           Text(
//                             'THEMES',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimaryContainer
//                                         .withOpacity(0.8),
//                                     fontSize: 20),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                       leading: Icon(Icons.settings),
//                       title: Text(
//                         'CHANGE LOOK',
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall!
//                             .copyWith(color: Colors.black, fontSize: 20),
//                       ),
//                       onTap: () {
//                         _changeBackground();
//                       }),
//                 ],
//               )),
//           appBar: AppBar(
//             title: BounceInDown(
//               child: const Text(
//                 'JARVIS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: ZoomIn(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       margin: const EdgeInsets.only(top: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Pallete.assistantCircleColor,
//                         image:
//                             DecorationImage(image: jarvis!, fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FadeInRight(
//                   delay: const Duration(seconds: 2),
//                   child: Visibility(
//                     visible: generatedImageUrl == null,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       margin: const EdgeInsets.symmetric(horizontal: 40)
//                           .copyWith(top: 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Pallete.borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                             .copyWith(topLeft: Radius.zero),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           generatedContent == null
//                               ? 'Good Morning, What task can I do for You!'
//                               : generatedContent!,
//                           style: TextStyle(
//                             fontFamily: 'Cera Pro',
//                             color: const Color.fromARGB(255, 217, 223, 228),
//                             fontSize: generatedContent == null ? 25 : 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (generatedImageUrl != null)
//                   Image.network(generatedImageUrl!),
//                 FadeInLeft(
//                   delay: const Duration(seconds: 3),
//                   child: Visibility(
//                     visible:
//                         generatedContent == null && generatedImageUrl == null,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.only(top: 10, left: 22),
//                       child: const Text(
//                         'Here are a few features',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Cera Pro',
//                           color: Color.fromARGB(255, 190, 195, 199),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       generatedContent == null && generatedImageUrl == null,
//                   child: Column(
//                     children: [
//                       FadeInRight(
//                         delay: const Duration(seconds: 4),
//                         child: const FeatureBox(
//                           color: Pallete.firstSuggestionBoxColor,
//                           headerText: 'CHATGPT',
//                           descriptionText:
//                               'A faster way to stay organized and informed with ChatGPT',
//                         ),
//                       ),
//                       FadeInLeft(
//                         delay: const Duration(seconds: 5),
//                         child: const FeatureBox(
//                           color: Pallete.secondSuggestionBoxColor,
//                           headerText: 'DALL-E',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       ),
//                       FadeInRight(
//                         delay: const Duration(seconds: 6),
//                         child: const FeatureBox(
//                           color: Pallete.thirdSuggestionBoxColor,
//                           headerText: 'Smart Voice Assistant',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (await speechToText.hasPermission &&
//                   !speechToText.isListening) {
//                 // Stop any ongoing speech
//                 await stopSpeaking();
//                 // Start listening for new prompt
//                 await startListening();
//               } else if (speechToText.isListening) {
//                 final speech = await openAIService
//                     .generateContent(lastWords); // Call OpenAIService method
//                 generatedContent = speech;
//                 generatedImageUrl = null;
//                 setState(() {});
//                 await systemSpeak(speech!);
//                 await stopListening();
//               } else {
//                 initSpeechToText();
//               }
//             },
//             child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:allen/openai_service.dart';
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:allen/feature_box.dart';
// import 'package:allen/pallete.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final speechToText = SpeechToText();
//   FlutterTts flutterTts = FlutterTts();
//   String lastWords = '';
//   final OpenAIService openAIService =
//       OpenAIService(); // Initialize the OpenAIService
//   String? generatedContent;
//   String? generatedImageUrl;
//   var background;
//   var b_title;
//   var jarvis;
//   var j_title;

//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//     setVoice("en-us-x-sfg#female_1-local"); // Set a specific voice
//     background = const AssetImage("assets/images/jarvis.gif");
//     b_title = "assets/images/jarvis.gif";
//     jarvis = const AssetImage("assets/images/jarvis_2.gif");
//     j_title = "assets/images/jarvis_2.gif";
//   }

//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     setState(() {});
//   }

//   Future<void> initSpeechToText() async {
//     await speechToText.initialize();
//     setState(() {});
//   }

//   Future<void> startListening() async {
//     await speechToText.listen(onResult: onSpeechResult);
//     setState(() {});
//   }

//   Future<void> stopListening() async {
//     await speechToText.stop();
//     setState(() {});
//   }

//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       lastWords = result.recognizedWords;
//     });
//   }

//   Future<void> systemSpeak(String content) async {
//     await flutterTts.speak(content);
//   }

//   Future<void> stopSpeaking() async {
//     await flutterTts.stop();
//   }

//   Future<void> setVoice(String voiceName) async {
//     await flutterTts.setVoice({'name': voiceName, 'locale': 'en-US'});
//   }

//   void _changeBackground() {
//     if (b_title == "assets/images/jarvis.gif")
//       setState(() {
//         background = const AssetImage("assets/images/background_jarvis.gif");
//         b_title = "assets/images/background_jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis.gif");
//       });
//     else {
//       setState(() {
//         background = const AssetImage("assets/images/jarvis.gif");
//         b_title = "assets/images/jarvis.gif";
//         jarvis = const AssetImage("assets/images/jarvis_2.gif");
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     speechToText.stop();
//     flutterTts.stop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: background, // background
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           drawer: Drawer(
//               surfaceTintColor: Colors.white,
//               child: Column(
//                 children: [
//                   DrawerHeader(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(colors: [
//                       Theme.of(context).colorScheme.primaryContainer,
//                       Theme.of(context).colorScheme.secondaryContainer
//                     ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                     child: Expanded(
//                       child: Row(
//                         children: [
//                           const Icon(Icons.format_paint, size: 50),
//                           const SizedBox(width: 14),
//                           Text(
//                             'THEMES',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimaryContainer
//                                         .withOpacity(0.8),
//                                     fontSize: 20),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                       leading: Icon(Icons.settings),
//                       title: Text(
//                         'CHANGE LOOK',
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleSmall!
//                             .copyWith(color: Colors.black, fontSize: 20),
//                       ),
//                       onTap: () {
//                         _changeBackground();
//                       }),
//                 ],
//               )),
//           appBar: AppBar(
//             title: BounceInDown(
//               child: const Text(
//                 'JARVIS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Center(
//                   child: ZoomIn(
//                     child: Container(
//                       height: 200,
//                       width: 200,
//                       margin: const EdgeInsets.only(top: 4.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Pallete.assistantCircleColor,
//                         image:
//                             DecorationImage(image: jarvis!, fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//                 ),
//                 FadeInRight(
//                   delay: const Duration(seconds: 2),
//                   child: Visibility(
//                     visible: generatedImageUrl == null,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       margin: const EdgeInsets.symmetric(horizontal: 40)
//                           .copyWith(top: 30),
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Pallete.borderColor,
//                         ),
//                         borderRadius: BorderRadius.circular(20)
//                             .copyWith(topLeft: Radius.zero),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0),
//                         child: Text(
//                           generatedContent == null
//                               ? 'Good Morning, What task can I do for You!'
//                               : generatedContent!,
//                           style: TextStyle(
//                             fontFamily: 'Cera Pro',
//                             color: const Color.fromARGB(255, 217, 223, 228),
//                             fontSize: generatedContent == null ? 25 : 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (generatedImageUrl != null)
//                   Image.network(generatedImageUrl!),
//                 FadeInLeft(
//                   delay: const Duration(seconds: 3),
//                   child: Visibility(
//                     visible:
//                         generatedContent == null && generatedImageUrl == null,
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.all(10),
//                       margin: const EdgeInsets.only(top: 10, left: 22),
//                       child: const Text(
//                         'Here are a few features',
//                         textAlign: TextAlign.start,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Cera Pro',
//                           color: Color.fromARGB(255, 190, 195, 199),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible:
//                       generatedContent == null && generatedImageUrl == null,
//                   child: Column(
//                     children: [
//                       FadeInRight(
//                         delay: const Duration(seconds: 4),
//                         child: const FeatureBox(
//                           color: Pallete.firstSuggestionBoxColor,
//                           headerText: 'CHATGPT',
//                           descriptionText:
//                               'A faster way to stay organized and informed with ChatGPT',
//                         ),
//                       ),
//                       FadeInLeft(
//                         delay: const Duration(seconds: 5),
//                         child: const FeatureBox(
//                           color: Pallete.secondSuggestionBoxColor,
//                           headerText: 'DALL-E',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       ),
//                       FadeInRight(
//                         delay: const Duration(seconds: 6),
//                         child: const FeatureBox(
//                           color: Pallete.thirdSuggestionBoxColor,
//                           headerText: 'Smart Voice Assistant',
//                           descriptionText:
//                               'Get inspired and stay creative with your personal assistant powered by Dall-E',
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () async {
//               if (await speechToText.hasPermission &&
//                   !speechToText.isListening) {
//                 await stopSpeaking(); // Stop any ongoing speech
//                 await startListening(); // Start listening for a new prompt
//               } else if (speechToText.isListening) {
//                 final speech = await openAIService
//                     .generateContent(lastWords); // Call OpenAIService method
//                 generatedContent = speech;
//                 generatedImageUrl = null;
//                 setState(() {});
//                 await systemSpeak(speech!);
//                 await stopListening();
//               } else {
//                 initSpeechToText();
//               }
//             },
//             child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
//           ),
//         ),
//       ],
//     );
//   }
// }

//import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:allen/openai_service.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:allen/feature_box.dart';
import 'package:allen/pallete.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService =
      OpenAIService(); // Initialize the OpenAIService
  String? generatedContent;
  String? generatedImageUrl;
  var background;
  var b_title;
  var jarvis;
  var j_title;
  String voice = "en-us-x-sfg#male_1-local";
  // Default voice

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
    setVoice(voice); // Set the default voice
    background = const AssetImage("assets/images/giphy.webp");
    b_title = "assets/images/giphy.webp";
    jarvis = const AssetImage("assets/images/jarvis_2.gif");
    j_title = "assets/images/jarvis_2.gif";
    flutterTts.speak("Good Morning , What task can I do for You");
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});

    await flutterTts.setSharedInstance(true);

    // List available voices
    var voices = await flutterTts.getVoices;
    print('Available voices: $voices');

    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  Future<void> setVoice(String voiceName) async {
    await flutterTts.setVoice({'name': voiceName, 'locale': 'en-US'});
    setState(() {});
  }

  void _changeBackground() {
    if (b_title == "assets/images/giphy.webp")
      setState(() {
        background = const AssetImage("assets/images/background_jarvis.gif");
        b_title = "assets/images/background_jarvis.gif";
        jarvis = const AssetImage("assets/images/jarvis.gif");
      });
    else {
      setState(() {
        background = const AssetImage("assets/images/giphy.webp");
        b_title = "assets/images/gify.webp";
        jarvis = const AssetImage("assets/images/jarvis_2.gif");
      });
    }
  }

  Future<void> _toggleVoice() async {
    if (voice.contains("US")) {
      voice = "en-GB-default"; // Switching to a different accent
    } else {
      voice = "en-US-default"; // Default voice
    }

    await setVoice(voice); // Apply the new voice setting
    setState(() {}); // Update the state

    // Introduce a small delay to ensure the voice setting has taken effect
    await Future.delayed(Duration(milliseconds: 500));

    // Announce the voice change with the new voice setting
    await systemSpeak("Voice changed");
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: background, // background
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawer: Drawer(
              surfaceTintColor: Colors.white,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    child: Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.format_paint, size: 50),
                          const SizedBox(width: 14),
                          Text(
                            'THEMES',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer
                                        .withOpacity(0.8),
                                    fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'CHANGE LOOK',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                      onTap: () {
                        _changeBackground();
                      }),
                  ListTile(
                    leading: Icon(Icons.voice_chat),
                    title: Text(
                      'TOGGLE VOICE',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black, fontSize: 20),
                    ),
                    onTap: _toggleVoice,
                  ),
                ],
              )),
          appBar: AppBar(
            title: BounceInDown(
              child: const Text(
                'JARVIS',
                style: TextStyle(color: Colors.white),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: ZoomIn(
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.only(top: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pallete.assistantCircleColor,
                        image:
                            DecorationImage(image: jarvis!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                FadeInRight(
                  delay: const Duration(seconds: 2),
                  child: Visibility(
                    visible: generatedImageUrl == null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.symmetric(horizontal: 40)
                          .copyWith(top: 30),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Pallete.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(20)
                            .copyWith(topLeft: Radius.zero),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          generatedContent == null
                              ? 'Good Morning, What task can I do for You!'
                              : generatedContent!,
                          style: TextStyle(
                            fontFamily: 'Cera Pro',
                            color: const Color.fromARGB(255, 217, 223, 228),
                            fontSize: generatedContent == null ? 25 : 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (generatedImageUrl != null)
                  Image.network(generatedImageUrl!),
                FadeInLeft(
                  delay: const Duration(seconds: 3),
                  child: Visibility(
                    visible:
                        generatedContent == null && generatedImageUrl == null,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 10, left: 22),
                      child: const Text(
                        'Here are a few features',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cera Pro',
                          color: Color.fromARGB(255, 190, 195, 199),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Column(
                    children: [
                      FadeInRight(
                        delay: const Duration(seconds: 4),
                        child: const FeatureBox(
                          color: Pallete.firstSuggestionBoxColor,
                          headerText: 'CHATGPT',
                          descriptionText:
                              'A faster way to stay organized and informed with ChatGPT',
                        ),
                      ),
                      FadeInLeft(
                        delay: const Duration(seconds: 5),
                        child: const FeatureBox(
                          color: Pallete.secondSuggestionBoxColor,
                          headerText: 'DALL-E',
                          descriptionText:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E',
                        ),
                      ),
                      FadeInRight(
                        delay: const Duration(seconds: 6),
                        child: const FeatureBox(
                          color: Pallete.thirdSuggestionBoxColor,
                          headerText: 'Smart Voice Assistant',
                          descriptionText:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (await speechToText.hasPermission &&
                  !speechToText.isListening) {
                await stopSpeaking(); // Stop any ongoing speech
                await startListening(); // Start listening for a new prompt
              } else if (speechToText.isListening) {
                final speech = await openAIService
                    .generateContent(lastWords); // Call OpenAIService method
                generatedContent = speech;
                generatedImageUrl = null;
                setState(() {});
                await systemSpeak(speech!);
                await stopListening();
              } else {
                initSpeechToText();
              }
            },
            child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
          ),
        ),
      ],
    );
  }
}
