import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_encrypted_chat_demo/src/utils/encryption/app_e2ee.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_page.dart';

class ChannelList extends StatelessWidget {
  const ChannelList({Key? key, this.onItemTap}) : super(key: key);

  final ValueChanged<Channel>? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          onChannelTap: onItemTap != null
              ? (channel, _) => onItemTap!(channel)
              : null,
          filter: Filter.in_(
            'members',
            [StreamChat.of(context).currentUser!.id]
          ),
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(limit: 20),
          channelWidget: ChannelPage(),
          channelPreviewBuilder: _channelPreviewBuilder,
        ),
      ),
    );
  }

  Widget _channelPreviewBuilder(BuildContext context, Channel channel) {
    final lastMessage = channel.state!.messages.reversed.firstWhere(
      (message) => !message.isDeleted,
      orElse: () => Message()
    );
    final opacity = (channel.state!.unreadCount) > 0 ? 1.5 : 1.0;

    return FutureBuilder<String>(
      future: lastMessage.text != null
          ? AppE2EE().decrypt(lastMessage.text!)
          : Future<String>.value(''),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          default:
            if (snapshot.hasError) {
              return Text('');
            } else {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StreamChannel(child: const ChannelPage(), channel: channel)
                    ));
                },
                leading: ChannelAvatar(channel: channel),
                title: ChannelName(
                  textStyle: StreamChatTheme.of(context).channelPreviewTheme.titleStyle!.copyWith(
                    color: StreamChatTheme.of(context).colorTheme.textHighEmphasis.withOpacity(opacity)
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(snapshot.data!),
                    snapshot.data != ''
                        ? (channel.state!.unreadCount) > 0
                            ? const Icon(Icons.check_circle_outline, size: 16.0)
                            : const Icon(Icons.check, size: 16.0)
                        : const SizedBox()
                  ],
                ),
              );
            }
        }
      }
    );
  }
}
