import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/User.dart';

class AccountScheme extends StatefulWidget {
  const AccountScheme({super.key});

  @override
  State<AccountScheme> createState() => _AccountSchemeState();
}

class _AccountSchemeState extends State<AccountScheme> {
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController fecNacController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
