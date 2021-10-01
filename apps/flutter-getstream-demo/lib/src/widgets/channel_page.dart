import 'package:flutter/material.dart';
import 'package:flutter_getstream_demo/src/widgets/thread_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(
        title: const Text('tutorial-flutter'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              // messageBuilder: _messageBuilder,
              threadBuilder: (_, parentMessage) => ThreadPage(
                parent: parentMessage
              ),
            ),
          ),
          MessageInput()
        ],
      ),
    );
  }

  Widget _messageBuilder(
    BuildContext context,
    MessageDetails details,
    List<Message> messages,
    MessageWidget defaultMessageWidget
  ) {
    final message = details.message;
    final isCurrentUser = StreamChat.of(context).currentUser!.id == message.user!.id;
    final textAlign = isCurrentUser ? TextAlign.right : TextAlign.left;
    final color = isCurrentUser ? Colors.blueAccent : Colors.white70;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          ),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: ListTile(
          title: Text(
            message.text!,
            textAlign: textAlign,
          ),
          subtitle: Text(
            message.user!.name,
            textAlign: textAlign,
          ),
        ),
      ),
    );
  }
}
