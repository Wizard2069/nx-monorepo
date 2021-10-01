import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_encrypted_chat_demo/src/modules/home/screens/home_page.dart';
import 'package:flutter_encrypted_chat_demo/src/utils/encryption/app_e2ee.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  final client = StreamChatClient(
    dotenv.env['GETSTREAM_APIKEY']!,
    logLevel: Level.OFF
  );

  await AppE2EE().generateKeys();
  Map<String, dynamic> publicKeyJwk = await AppE2EE().keyPair.publicKey.exportJsonWebKey();

  await client.connectUser(
    User(
      id: 'John',
      extraData: {
        'image': 'https://picsum.photos/id/1006/200/300',
        'publicKey': publicKeyJwk
      }
    ),
    client.devToken('John').rawValue
  );

  final channel = client.channel(
    'messaging',
    id: 'guitarist',
    extraData: {
      'name': 'Guitarist',
      'image': 'https://source.unsplash.com/5HltXT-6Vgw',
      'members': ['John', 'Mike']
    }
  );
  await channel.watch();

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);

  final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(primarySwatch: Colors.blue);

    return MaterialApp(
      title: 'Flutter Chat App',
      theme: theme,
      builder: (context, child) => StreamChat(
          streamChatThemeData: StreamChatThemeData.fromTheme(theme),
          client: client,
          child: child
      ),
      home: HomePage()
    );
  }
}

