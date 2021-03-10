import 'package:chatAppStream/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsChat extends StatefulWidget {
  FriendsChat({Key key}) : super(key: key);

  @override
  _FriendsChatState createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  final _keyChannel = GlobalKey<ChannelsBlocState>();

  Future<void> _onCreateChannel() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        final channelController = TextEditingController();
        return AlertDialog(
          title: Text('Create Channel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome to the public chat'),
              TextField(
                controller: channelController,
                decoration: InputDecoration(
                  hintText: 'Channel Name',
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(channelController.text),
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
    if (result != null) {
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging', id: result, extraData: {
        'image': DataUtils.getChannelImage(),
      });
      await channel.create();
      _keyChannel.currentState.queryChannels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Chat'),
      ),
      body: ChannelsBloc(
        key: _keyChannel,
        child: ChannelListView(
          channelWidget: ChannelPage(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onCreateChannel,
        label: Text('Create Channel'),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
