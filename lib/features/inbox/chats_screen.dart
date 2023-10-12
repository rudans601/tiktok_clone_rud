import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

import '../../constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        //KEY에다가 아이템을 추가한다
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length); //리스트에다가 아이템 추가
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => Container(
          color: Colors.red,
          child: SizeTransition(
            sizeFactor: animation,
            child: _makeTile(index), //다시 만들어서 보여준다
          ),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(ChatDetailScreen.routeName, params: {"chatId": "$index"});
  }

  Widget _makeTile(int index) {
    //메세지를 위젯으로 따로 만들어준다
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/48172755?v=4"),
        child: Text('갱문'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "하하 ($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '2:16 PM',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text("Don't forget to make video"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            key: UniqueKey(),
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
