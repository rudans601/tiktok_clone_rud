import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/features/users/views/widgets/user_account.dart';
import 'package:tiktok_clone/features/users/views/widgets/user_profile_setting_screen.dart';
import 'package:tiktok_clone/utils.dart';

import '../../../constants/sizes.dart';
import '../../settings/settings_screen.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  void _onProfileSetting() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const UserProfileSettingScreen());
  }

//데이터 자동 갱신만 찾아보기 https://seosh817.tistory.com/284

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        backgroundColor:
                            Theme.of(context).appBarTheme.backgroundColor,
                        actions: [
                          IconButton(
                            onPressed: _onProfileSetting,
                            icon: const FaIcon(FontAwesomeIcons.link),
                          ),
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
                              Avatar(
                                name: data.name,
                                uid: data.uid,
                                hasAvatar: data.hasAvatar,
                              ),
                              Gaps.v20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "@${data.name}",
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size32,
                                ),
                                child: Text(
                                  data.bio,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gaps.v14,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.link,
                                    size: Sizes.size12,
                                  ),
                                  Gaps.h4,
                                  Text(
                                    data.link,
                                    style: const TextStyle(
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
                                    placeholder:
                                        "assets/images/placeholder.jpg",
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
                                borderRadius:
                                    BorderRadius.circular(Sizes.size4),
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
          ),
        );
  }
}
