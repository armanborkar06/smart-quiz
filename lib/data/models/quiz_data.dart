import 'question.dart';

class QuizData {
  static Map<String, List<Question>> getCategorizedQuestions() {
    return {
      'General Knowledge': [
        Question(
          questionText: "What is the capital of France?",
          options: ["Paris", "London", "Berlin", "Madrid"],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: "Which is the largest ocean?",
          options: ["Atlantic", "Indian", "Pacific", "Arctic"],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: "Who wrote the national anthem of India?",
          options: ["Tagore", "Gandhi", "Nehru", "Bose"],
          correctAnswerIndex: 0,
        ),
      ],
      'Science': [
        Question(
          questionText: "Which planet is known as the Red Planet?",
          options: ["Earth", "Mars", "Jupiter", "Venus"],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: "What is the chemical symbol for Gold?",
          options: ["Au", "Ag", "Fe", "Cu"],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: "What gas do plants absorb from the atmosphere?",
          options: ["Oxygen", "Nitrogen", "Carbon Dioxide", "Helium"],
          correctAnswerIndex: 2,
        ),
      ],
      'History': [
        Question(
          questionText: "Who was the first Emperor of the Maurya Dynasty?",
          options: ["Ashoka", "Chandragupta", "Bindusara", "Samudragupta"],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: "In which year did India gain independence?",
          options: ["1945", "1947", "1950", "1962"],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: "Who built the Taj Mahal?",
          options: ["Akbar", "Shah Jahan", "Aurangzeb", "Jahangir"],
          correctAnswerIndex: 1,
        ),
      ],
    };
  }

  static List<String> getCategories() {
    return getCategorizedQuestions().keys.toList();
  }
}