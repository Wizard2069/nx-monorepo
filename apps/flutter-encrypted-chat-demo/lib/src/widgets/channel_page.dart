import 'package:flutter/material.dart';
import 'package:flutter_encrypted_chat_demo/src/utils/encryption/app_e2ee.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key, this.showBackButton = true}) : super(key: key);

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(
        showBackButton: showBackButton,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(
              messageBuilder: _messageBuilder,
            )
          ),
          MessageInput(
            disableAttachments: true,
            preMessageSending: (Message message) async {
              String encryptedMessage = await AppE2EE().encrypt(message.text!);
              Message newMessage = message.copyWith(text: encryptedMessage);

              return newMessage;
            },
          )
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
    Message message = details.message;

    return FutureBuilder<String>(
      future: message.text != null && !message.isDeleted
          ? AppE2EE().decrypt(message.text!)
          : Future<String>.value(''),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          default:
            if (snapshot.hasError) {
              return Text('');
            } else {
              return defaultMessageWidget.copyWith(
                message: message.copyWith(text: snapshot.data)
              );
            }
        }
      }
    );
  }
}
