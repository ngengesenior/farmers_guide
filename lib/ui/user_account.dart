import 'package:farmers_guide/components.dart';
import 'package:farmers_guide/services/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAccountUi extends ConsumerStatefulWidget {
  static const routeName = "/account_details";
  const UserAccountUi({super.key});

  @override
  ConsumerState<UserAccountUi> createState() => _UserAccountUIState();
}

class _UserAccountUIState extends ConsumerState<UserAccountUi> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    //padding: EdgeInsets.all(deviceSize.width * 0.06),
    final user = userMeState.value;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(deviceSize.width * 0.06),
          child: Column(
            children: [
              const BigTitleText(text: "Your Account"),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Text("Username"),
                subtitle: Text(user?.username ?? ""),
              ),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: const Text("Email"),
                subtitle: Text(user?.email ?? ""),
              ),
              const Divider(
                color: Colors.grey,
              ),
              const Spacer(),
              PrimaryButton(
                  labelText: 'Log Out',
                  onPressed: () {
                    // Implement log out feature
                    userMeState.clearValue();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
