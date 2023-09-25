import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  void _onStartWriting() {
    setState(() {});
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/48172755?v=4"),
                child: Text("갱문"),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: Sizes.size18,
                  height: Sizes.size18,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
          title: const Text(
            '갱문',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _stopWriting, //추가
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(Sizes.size20),
                          topRight: const Radius.circular(Sizes.size20),
                          bottomLeft: Radius.circular(
                              isMine ? Sizes.size20 : Sizes.size5),
                          bottomRight: Radius.circular(
                              isMine ? Sizes.size5 : Sizes.size20),
                        ),
                      ),
                      child: const Text(
                        "This is a message",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: Sizes.size8,
                        right: Sizes.size4,
                        top: Sizes.size8,
                        bottom: Sizes.size8,
                      ),
                      child: TextField(
                        onTap: _onStartWriting,
                        textInputAction: TextInputAction.newline,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes.size24,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: Sizes.size12,
                            horizontal: Sizes.size14,
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                              right: Sizes.size1,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: Colors.black,
                                size: Sizes.size30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Sizes.size12,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: Sizes.size36,
                          height: Sizes.size36,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(7.0),
                            child: FaIcon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.white,
                              size: Sizes.size20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
