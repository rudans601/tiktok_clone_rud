import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/utils.dart';

class UserProfileSettingScreen extends ConsumerStatefulWidget {
  const UserProfileSettingScreen({super.key});

  @override
  ConsumerState<UserProfileSettingScreen> createState() =>
      _UserProfileSettingScreenState();
}

class _UserProfileSettingScreenState
    extends ConsumerState<UserProfileSettingScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  late String _bio;
  late String _link;

  void _onCompletePressed() async {
    if (_bio.isNotEmpty && _link.isNotEmpty) {
      await ref.read(usersProvider.notifier).onUpdateUserBio(_bio);
      await ref.read(usersProvider.notifier).onUpdateUserLink(_link);

      context.pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bioController.addListener(() {
      setState(() {
        _bio = _bioController.text;
      });
    });
    _linkController.addListener(() {
      setState(() {
        _link = _linkController.text;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: Breakpoints.md),
        height: size.height * 0.95,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size14),
        ),
        child: Scaffold(
          backgroundColor: isDark ? null : Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: isDark ? null : Colors.grey.shade50,
            title: const Text("Profile Setting"),
            actions: [
              IconButton(
                  onPressed: _onCompletePressed,
                  icon: const FaIcon(FontAwesomeIcons.check)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "bio",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextField(
                  controller: _bioController,
                ),
                Gaps.v10,
                Text(
                  "link",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextField(
                  controller: _linkController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
