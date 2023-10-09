import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/features/users/widgets/user_account.dart';
import 'package:tiktok_clone/utils.dart';

import '../../constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "likes" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(widget.username),
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gaps.v20,
                      if (MediaQuery.of(context).size.width <
                          Breakpoints.md) ...[
                        const CircleAvatar(
                          radius: 50,
                          foregroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/3612017"),
                          child: Text("니꼬"),
                        ),
                        Gaps.v20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "@${widget.username}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Sizes.size18,
                              ),
                            ),
                            Gaps.h5,
                            FaIcon(
                              FontAwesomeIcons.solidCircleCheck,
                              size: Sizes.size16,
                              color: Colors.blue.shade500,
                            ),
                          ],
                        ),
                        Gaps.v24,
                        SizedBox(
                          height: Sizes.size64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const UserAccount(
                                number: "37",
                                content: "Following",
                              ),
                              VerticalDivider(
                                width: Sizes.size32,
                                thickness: Sizes.size1,
                                color: Colors.grey.shade400,
                                indent: Sizes.size14,
                                endIndent: Sizes.size10,
                              ),
                              const UserAccount(
                                number: "10.5M",
                                content: "Followers",
                              ),
                              VerticalDivider(
                                width: Sizes.size32,
                                thickness: Sizes.size1,
                                color: Colors.grey.shade400,
                                indent: Sizes.size14,
                                endIndent: Sizes.size10,
                              ),
                              const UserAccount(
                                number: "194.3M",
                                content: "Likes",
                              ),
                            ],
                          ),
                        ),
                        Gaps.v14,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200, //여기 다시 손보기
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    Sizes.size4,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Follow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.h3,
                            Container(
                              width: Sizes.size38,
                              height: Sizes.size38,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.youtube,
                                  size: Sizes.size20,
                                ),
                              ),
                            ),
                            Gaps.h3,
                            Container(
                              width: Sizes.size38,
                              height: Sizes.size38,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: Sizes.size10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.v14,
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size32,
                          ),
                          child: Text(
                            "All highlights and where to watch live matches on FIFA+",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gaps.v14,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.link,
                              size: Sizes.size12,
                            ),
                            Gaps.h4,
                            Text(
                              "https://nomadcoders.co",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v20
                      ],
                      if (MediaQuery.of(context).size.width >
                          Breakpoints.md) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              foregroundImage: NetworkImage(
                                  "https://avatars.githubusercontent.com/u/3612017"),
                              child: Text("니꼬"),
                            ),
                            Gaps.h40,
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "@갱문",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: Sizes.size18,
                                      ),
                                    ),
                                    Gaps.h2,
                                    FaIcon(
                                      FontAwesomeIcons.solidCircleCheck,
                                      size: Sizes.size16,
                                      color: Colors.blue.shade500,
                                    ),
                                  ],
                                ),
                                Gaps.v24,
                                SizedBox(
                                  height: Sizes.size48,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const UserAccount(
                                        number: "37",
                                        content: "Following",
                                      ),
                                      VerticalDivider(
                                        width: Sizes.size32,
                                        thickness: Sizes.size1,
                                        color: Colors.grey.shade400,
                                        indent: Sizes.size14,
                                        endIndent: Sizes.size10,
                                      ),
                                      const UserAccount(
                                        number: "10.5M",
                                        content: "Followers",
                                      ),
                                      VerticalDivider(
                                        width: Sizes.size32,
                                        thickness: Sizes.size1,
                                        color: Colors.grey.shade400,
                                        indent: Sizes.size14,
                                        endIndent: Sizes.size10,
                                      ),
                                      const UserAccount(
                                        number: "194.3M",
                                        content: "Likes",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gaps.v20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200, //여기 다시 손보기
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    Sizes.size4,
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Follow",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.h3,
                            Container(
                              width: Sizes.size38,
                              height: Sizes.size38,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.youtube,
                                  size: Sizes.size20,
                                ),
                              ),
                            ),
                            Gaps.h3,
                            Container(
                              width: Sizes.size38,
                              height: Sizes.size38,
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: Sizes.size10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.v20,
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size32,
                          ),
                          child: Text(
                            "All highlights and where to watch live matches on FIFA+",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Gaps.v20,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.link,
                              size: Sizes.size12,
                            ),
                            Gaps.h4,
                            Text(
                              "https://nomadcoders.co",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Gaps.v20
                      ],
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: PersistentTabBar(),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > Breakpoints.md
                            ? 5
                            : 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (context, index) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 14,
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.cover,
                              placeholder: "assets/images/placeholder.jpg",
                              image:
                                  "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: Sizes.size48,
                        height: Sizes.size20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: const Center(
                          child: Text(
                            "Pinned",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size12,
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: Sizes.size4,
                        left: Sizes.size4,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.circlePlay,
                              color: Colors.white,
                            ),
                            Gaps.h5,
                            Text(
                              "4.1M",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text('Page two'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
