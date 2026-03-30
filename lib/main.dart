import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('[${record.level.name}] ${record.time}: ${record.message}');
  });
  runApp(const DevStackApp());
}

class DevStackApp extends StatelessWidget {
  const DevStackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B1215),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const FeedScreen(),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  final Color primaryCyan = const Color(0xFF4EE2EC);
  final Color cardColor = const Color(0xFF162126);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'My Feed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Top Tags', style: TextStyle(color: Colors.grey)),
                ),
                _buildTagsRow(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildPostCard(),
                      _buildSimplePostCard("AI integration for prediction modeling in Python"),
                      _buildSimplePostCard("Deploying Docker containers to AWS Lambda"),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _buildFloatingAskButton(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.search, color: Colors.grey),
          Row(
            children: [
              Icon(Icons.psychology, color: primaryCyan),
              const SizedBox(width: 5),
              Text(
                'DevStack',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(' AI', style: TextStyle(color: primaryCyan, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              const Stack(
                children: [
                  Icon(Icons.notifications_none, color: Colors.grey),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
                  )
                ],
              ),
              const SizedBox(width: 15),
               CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=tech'),
                backgroundColor: Colors.cyan,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTagsRow() {
    List<String> tags = ['Python', 'React', 'AI', 'JavaScript'];
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          bool isSelected = tags[index] == 'JavaScript';
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? primaryCyan : Colors.grey.withOpacity(0.3)),
              boxShadow: isSelected ? [BoxShadow(color: primaryCyan.withOpacity(0.3), blurRadius: 8)] : [],
            ),
            child: Text(
              tags[index],
              style: TextStyle(color: isSelected ? primaryCyan : Colors.grey),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=1')),
              const SizedBox(width: 8),
              const Text('@TechEnthusiast', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Spacer(),
              const Text('3h ago', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Optimizing dynamic content loading in React with Hooks?',
            style: TextStyle(color: primaryCyan, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Learn about optimizing dynamic content loading in React hooks.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 12),
          _buildCodeSnippet(),
          const SizedBox(height: 12),
          _buildCardFooter(),
        ],
      ),
    );
  }

  Widget _buildSimplePostCard(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
              const Icon(Icons.more_vert, size: 18, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),
          _buildCodeSnippet(minimized: true),
        ],
      ),
    );
  }

  Widget _buildCodeSnippet({bool minimized = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F171A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'useEffect(() => {',
            style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 12),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'const fetchData = async () => {',
              style: GoogleFonts.firaCode(color: primaryCyan, fontSize: 12),
            ),
          ),
          if (!minimized) ...[
            const Padding(padding: EdgeInsets.only(left: 32), child: Text('...', style: TextStyle(color: Colors.white))),
            Text('}, []);', style: GoogleFonts.firaCode(color: Colors.greenAccent, fontSize: 12)),
          ]
        ],
      ),
    );
  }

  Widget _buildCardFooter() {
    return Row(
      children: [
        Icon(Icons.arrow_upward, size: 16, color: primaryCyan),
        const SizedBox(width: 4),
        const Text('1,489', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 12),
        const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        const Text('42', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 12),
        const Icon(Icons.share_outlined, size: 16, color: Colors.grey),
        const Spacer(),
        _miniTag("React"),
        _miniTag("Hooks"),
      ],
    );
  }

  Widget _miniTag(String label) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: primaryCyan.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(color: primaryCyan, fontSize: 9)),
    );
  }

  Widget _buildFloatingAskButton() {
    final Logger logger = Logger('FeedScreen');
    return GestureDetector(
      onTap: () {
        logger.info('Botão Ask AI clicado!');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: primaryCyan,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primaryCyan.withOpacity(0.6),
              blurRadius: 20,
              spreadRadius: 2,
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.help_outline, color: Colors.black),
            SizedBox(width: 8),
            Text('Ask AI', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF0B1215),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryCyan,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}
