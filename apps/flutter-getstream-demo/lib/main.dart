import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_getstream_demo/src/config/theme.dart';
import 'package:flutter_getstream_demo/src/widgets/channel_list_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  final client = StreamChatClient(
    dotenv.env['GETSTREAM_APIKEY']!,
    logLevel: Level.INFO
  );

  // final userToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.vsG7AdEuh6f7f9K54Hd4BtFtSSaHAK9a3aYc_0SEz5Y';
  final userToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';
  await client.connectUser(
    User(id: 'tutorial-flutter'),
    userToken
  );

  /*final channel = client.channel('messaging', id: 'flutterdevs');
  channel.watch();*/

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    final defaultTheme = StreamChatThemeData.fromTheme(theme);
    final colorTheme = defaultTheme.colorTheme;
    final customTheme = defaultTheme.merge(StreamChatThemeData(
      otherMessageTheme: MessageThemeData(
        messageBackgroundColor: colorTheme.textHighEmphasis,
        messageTextStyle: TextStyle(
          color: colorTheme.barsBg,
        ),
      ),
    ));

    return MaterialApp(
      theme: theme,
      builder: (context, widget) {
        return StreamChat(
          streamChatThemeData: customTheme,
          client: client,
          child: widget
        );
      },
      home: const ChannelListPage(),
    );
  }
}

