import 'package:flutter/material.dart';
import 'package:flutter_getstream_demo/src/widgets/channel_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelListPage extends StatelessWidget {
  const ChannelListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          filter: Filter.in_(
            'members',
            [StreamChat.of(context).currentUser!.id]
          ),
          sort: const [SortOption('last_message_at')],
          // channelPreviewBuilder: _channelPreviewBuilder,
          pagination: const PaginationParams(limit: 20),
          channelWidget: const ChannelPage(),
        ),
      ),
    );
  }

  Widget _channelPreviewBuilder(BuildContext context, Channel channel) {
    final lastMessage = channel.state?.messages.reversed.firstWhere(
      (message) => !message.isDeleted
    );

    final subtitle = lastMessage == null ? 'nothing yet' : lastMessage.text!;
    final opacity = (channel.state!.unreadCount) > 0 ? 1.0 : 0.5;

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
      subtitle: Text(subtitle),
      trailing: (channel.state?.unreadCount ?? 0) > 0
          ? CircleAvatar(radius: 10, child: Text(channel.state!.unreadCount.toString()))
          : const SizedBox()
    );
  }
}
