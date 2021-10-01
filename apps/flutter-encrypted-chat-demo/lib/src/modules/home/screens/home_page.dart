import 'package:flutter/material.dart';
import 'package:flutter_encrypted_chat_demo/src/widgets/channel_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          ChannelList(),
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.rss_feed, size: 50),
                    Text('Activity Feed')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Channel'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rss_feed),
            label: 'Feed'
          )
        ],
      ),
    );
  }
}

