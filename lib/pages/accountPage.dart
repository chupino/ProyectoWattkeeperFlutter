import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/buttons/customButton.dart';
import 'package:wattkeeperr/components/forms/datePickerTextField.dart';
import 'package:wattkeeperr/components/forms/textFieldCustom.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/settings/account/accountScheme.dart';
import 'package:wattkeeperr/components/settings/account/headerAccount.dart';
import 'package:wattkeeperr/components/snackbar/snackbars.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/User.dart';

class AccountPage extends StatelessWidget {
  final String token;
  AccountPage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const HeaderAccount(),
        SliverFillRemaining(
            child: AccountScheme(token: token))
      ],
    ));
  }
}
