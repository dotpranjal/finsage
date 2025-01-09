import 'package:flutter/material.dart';

class Lesson {
  final String title;
  final String description;
  final List<String> content;
  final IconData icon;

  Lesson({
    required this.title,
    required this.description,
    required this.content,
    required this.icon,
  });
}

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final List<Lesson> lessons = [
    Lesson(
      title: 'Introduction to Investing',
      description: 'Learn the basics of investing and how to get started',
      icon: Icons.account_balance,
      content: [
        'What is Investing?',
        'Investing is the act of allocating resources, usually money, with the expectation of generating an income or profit. You can invest in stocks, bonds, real estate, or even a business.',
        'Why Should You Invest?',
        'Investing helps you grow your wealth and beat inflation. It\'s a way to put your money to work for you and build long-term financial security.',
        'Key Investment Terms',
        '• Stocks: Ownership shares in a company\n• Bonds: Loans to companies or governments\n• Dividends: Portion of profits paid to shareholders\n• Portfolio: Collection of investments',
        'Getting Started',
        'Start by determining your investment goals, risk tolerance, and time horizon. Consider working with a financial advisor or using a robo-advisor for guidance.',
      ],
    ),
    // Add more lessons here
  ];

  int? selectedLessonIndex;

  @override
  Widget build(BuildContext context) {
    if (selectedLessonIndex != null) {
      return LessonDetailPage(
        lesson: lessons[selectedLessonIndex!],
        onBack: () => setState(() => selectedLessonIndex = null),
      );
    }

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          title: Text('Learn'),
          centerTitle: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final lesson = lessons[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(lesson.icon, size: 40),
                    title: Text(
                      lesson.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      lesson.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => setState(() => selectedLessonIndex = index),
                  ),
                );
              },
              childCount: lessons.length,
            ),
          ),
        ),
      ],
    );
  }
}

class LessonDetailPage extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onBack;

  const LessonDetailPage({
    super.key,
    required this.lesson,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onBack,
        ),
        title: Text(lesson.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: lesson.content.length,
        itemBuilder: (context, index) {
          final text = lesson.content[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: index % 2 == 0
                ? Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
                : Text(text, style: Theme.of(context).textTheme.bodyLarge),
          );
        },
      ),
    );
  }
}