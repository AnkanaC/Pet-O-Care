import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _userMessage = TextEditingController();
  final List<Message> _messages = [];
  final Map<String, String> _petProfile = {};
  final model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: 'AIzaSyAWQ3yv1fnqmsrOR14LzbjVKI2Kb_ImxUg',
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
    systemInstruction: Content.system(
      'You are a licensed virtual Pet Care Expert...',
    ),
  );

  @override
  void initState() {
    super.initState();
    fetchPetProfile();
  }

  Future<void> fetchPetProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await FirebaseFirestore.instance
            .collection('pets')
            .where('ownerId', isEqualTo: uid)
            .limit(1)
            .get();

    if (snapshot.docs.isNotEmpty) {
      final petData = snapshot.docs.first.data();
      setState(() {
        _petProfile.addAll(
          petData.map((key, value) => MapEntry(key, value.toString())),
        );
      });
    }
  }

  Future<void> sendMessage() async {
    final message = _userMessage.text;
    if (message.trim().isEmpty) return;
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    final petInfo = _petProfile.entries
        .map((e) => "${e.key}: ${e.value}")
        .join(", ");

    final content = [
      Content.text(
        "Here is the pet's profile: $petInfo\n"
        "Symptoms described: $message\n"
        "Please provide species-aware, breed-specific, and safe veterinary advice as per the system instructions.",
      ),
    ];

    final response = await model.generateContent(content);

    setState(() {
      _messages.add(
        Message(
          isUser: false,
          message: response.text ?? "Sorry, I couldn't generate a response.",
          date: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Pet Chatbot")),
        backgroundColor: const Color.fromRGBO(198, 247, 244, 1),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment:
                        msg.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg.isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg.message),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 12,
                top: 4,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _userMessage,
                      decoration: const InputDecoration(
                        labelText: "Enter your worries...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({required this.isUser, required this.message, required this.date});
}
