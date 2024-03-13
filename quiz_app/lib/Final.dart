import "package:flutter/material.dart";

class SingleQuestionModel {
  final String? question;
  final List<String>? options;
  final int? answerIndex;

  const SingleQuestionModel({this.question, this.options, this.answerIndex});
}

List allQuestions = [
  const SingleQuestionModel(
    question: "Which widget is used to create a button in Flutter?",
    options: ["Text", "Container", "ElevatedButton", "Listview"],
    answerIndex: 2,
  ),
  const SingleQuestionModel(
    question:
        "Which Flutter widget is commonly used to create text input fields?",
    options: ["InputField", "TextField", "TextInput", "TextEntry"],
    answerIndex: 1,
  ),
  const SingleQuestionModel(
    question:
        "Which widget is used to create a scrollable list of items in Flutter?",
    options: ["Row", "GridView", "ListView", "Column"],
    answerIndex: 2,
  ),
  const SingleQuestionModel(
    question:
        "What is the primary purpose of the FloatingActionButton widget in Flutter?",
    options: [
      "Primary action button",
      "Navigation button",
      "Dropdown menu button",
      "Progress indicator botton"
    ],
    answerIndex: 0,
  ),
  const SingleQuestionModel(
    question:
        "Which file is used to declare dependencies for a Flutter project?",
    options: [
      "Flutter.yaml",
      "dependencies.yaml",
      "package.json",
      "pubspec.yaml"
    ],
    answerIndex: 3,
  ),
];

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});
  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State {
  bool questionscreen = false;
  bool welcomepage = true;
  int currentQuestionIndex = 0;
  int selectedIndex = -1;
  int noOfCorrectAnswer = 0;

  MaterialStateProperty<Color?> checkAnswer(int buttonIndex) {
    if (selectedIndex != -1) {
      if (buttonIndex == allQuestions[currentQuestionIndex].answerIndex) {
        return const MaterialStatePropertyAll(Colors.green);
      } else if (buttonIndex == selectedIndex) {
        return const MaterialStatePropertyAll(Colors.red);
      } else {
        return const MaterialStatePropertyAll(null);
      }
    } else {
      return MaterialStateProperty.all(null);
    }
  }

  void pageValidate() {
    setState(() {
      if (selectedIndex == -1) {
        return;
      }

      if (selectedIndex == allQuestions[currentQuestionIndex].answerIndex &&
          selectedIndex != -1) {
        noOfCorrectAnswer += 1;
      }

      selectedIndex = -1;
      currentQuestionIndex++;
      if (currentQuestionIndex == allQuestions.length) {
        setState(() {
          questionscreen = false;
        });
      }
    });
  }

  Scaffold isQuestionScreen() {
    if (welcomepage == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "QuizApp",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 570,
                width: 420,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.network(
                        "https://www.finoforce.com/assets/new_images/Home_Small_Icon/why-choose-service.webp"),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(
                            12), // Adjust elevation
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 64), // Adjust padding
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Colors.blue,
                                width: 2), // Adjust border radius
                          ),
                        ),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          welcomepage = false;
                          questionscreen = true;
                        });
                      },
                      child: const Text(
                        "Start quiz",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      );
    } else if (questionscreen == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "QuizApp",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Question: ",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${currentQuestionIndex + 1}/${allQuestions.length}",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 380,
              height: 60,
              child: Text(
                "${allQuestions[currentQuestionIndex].question}",
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              width: 280,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.all<double>(20), // Adjust elevation

                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  backgroundColor: checkAnswer(0),
                ),
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 0;
                    });
                  }
                },
                child: Text(
                  "${allQuestions[currentQuestionIndex].options[0]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              width: 280,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.all<double>(20), // Adjust elevation

                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  backgroundColor: checkAnswer(1),
                ),
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 1;
                    });
                  }
                },
                child: Text(
                  "${allQuestions[currentQuestionIndex].options[1]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              width: 280,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.all<double>(20), // Adjust elevation

                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  backgroundColor: checkAnswer(2),
                ),
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 2;
                    });
                  }
                },
                child: Text(
                  "${allQuestions[currentQuestionIndex].options[2]}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              width: 280,
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation:
                      MaterialStateProperty.all<double>(20), // Adjust elevation

                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  backgroundColor: checkAnswer(3),
                ),
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 3;
                    });
                  }
                },
                child: Text(
                  "${allQuestions[currentQuestionIndex].options[3]}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.forward),
          onPressed: () {
            pageValidate();
          },
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "QuizApp",
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                color: Colors.white,
                child: Image.network(
                  'https://png.pngtree.com/png-clipart/20230914/original/pngtree-award-ceremony-vector-png-image_12097281.png',
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Text(
              "Congratulations: $noOfCorrectAnswer/${allQuestions.length}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              height: 40,
              width: 180,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          color: Colors.blue, width: 2), // Adjust border radius
                    ),
                  ),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    selectedIndex = -1;
                    currentQuestionIndex = 0;
                    noOfCorrectAnswer = 0;
                    questionscreen = true;
                  });
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }
}
