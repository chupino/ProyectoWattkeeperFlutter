import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/groups/details/devices/devicesGroupScheme.dart';
import 'package:wattkeeperr/components/groups/details/home/homeScheme.dart';
import 'package:wattkeeperr/components/groups/details/ahorro/savingPlanGroupScheme.dart';
import 'package:wattkeeperr/components/groups/details/tamagochi/tamagotchiGroupScheme.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/components/navBar/navBar.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';

class GroupDetailPage extends StatefulWidget {
  final int groupId;
  final String token;
  const GroupDetailPage(
      {super.key, required this.groupId, required this.token});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  final controller = GroupController();
  final sessionController = SessionController();
  int currentIndex = 0;
  late GroupDetails groupDetails;
  bool isInitialized = false;
  void selectDrawerItem(int index) {
    setState(() {
      currentIndex = index;
      Navigator.pop(context);
    });
  }

  Future<void> initializeData(bool refresh) async {
    groupDetails =
        await controller.getDetailsGroup(widget.token, widget.groupId);
    setState(() {
      isInitialized = true;
    });
  }

  Future<void> handleRefresh() async {
    await initializeData(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              isInitialized ? Text(groupDetails.nombre) : Text('Cargando...')),
      drawer: isInitialized
          ? Drawer(
              child: Container(
                height: double.infinity,
                child: Column(
                  children: [
                    DrawerHeader(
                        decoration: BoxDecoration(color: Color(0xFF1C2434)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/images/logo_icon.png',
                                height: 50,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                'Grupo ${groupDetails.nombre}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Inicio',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        selectDrawerItem(0);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.device_unknown),
                      title: Text(
                        'Dispositivos',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        selectDrawerItem(1);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.safety_check),
                      title: Text(
                        'Plan de Ahorro',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        selectDrawerItem(2);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.pets),
                      title: Text(
                        'Tamagotchi',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        selectDrawerItem(3);
                      },
                    ),
                    Spacer(),
                    ListTile(
                      leading: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Abandonar Grupo',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.redAccent),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Abandonar Grupo'),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Estas seguro que quieres abandonar ${groupDetails.nombre}?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Lottie.asset(
                                          'assets/animations/left.json'),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancelar'),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors.redAccent)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .leaveGroup(widget.token,
                                                          widget.groupId)
                                                      .then((value) {
                                                    if (value == true) {
                                                      final snackbar = SnackBar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          content:
                                                              AwesomeSnackbarContent(
                                                            contentType:
                                                                ContentType
                                                                    .help,
                                                            title:
                                                                "Abandonaste",
                                                            message:
                                                                "Saliste del grupo",
                                                          ));
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackbar);
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  NavBarWattKeeper(
                                                                      initialIndex:
                                                                          1)),
                                                          (route) => false);
                                                    } else {
                                                      print("Error");
                                                      final snackbar = SnackBar(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          content:
                                                              AwesomeSnackbarContent(
                                                            contentType:
                                                                ContentType
                                                                    .failure,
                                                            title:
                                                                "Ocurrio algo mal",
                                                            message:
                                                                "Algo salio mal",
                                                          ));
                                                      ScaffoldMessenger.of(
                                                          context)
                                                        ..hideCurrentSnackBar()
                                                        ..showSnackBar(
                                                            snackbar);
                                                      Navigator.pop(context);
                                                    }
                                                  }).catchError((e) {
                                                    print(e);
                                                    final snackbar = SnackBar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        content:
                                                            AwesomeSnackbarContent(
                                                          contentType:
                                                              ContentType
                                                                  .failure,
                                                          title:
                                                              "Ocurrio algo mal",
                                                          message:
                                                              "Algo salio mal",
                                                        ));
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(snackbar);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text('Confirmar')),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    )
                  ],
                ),
              ),
            )
          : null,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isInitialized
              ? IndexedStack(
                  index: currentIndex,
                  children: [
                    HomeGroupScheme(
                        token: widget.token,
                        onRefresh: handleRefresh,
                        groupDetails: groupDetails),
                    DevicesGroupScheme(
                        token: widget.token,
                        onRefresh: handleRefresh,
                        groupDetails: groupDetails),
                    SavingPlanScheme(
                      groupDetails: groupDetails,
                      onRefresh: handleRefresh,
                    ),
                    TamagotchiGroupScheme(
                      groupDetails: groupDetails,
                      onRefresh: handleRefresh,
                      token: widget.token,
                    ),
                  ],
                )
              : LoadingAnimation()),
    );
  }
}
