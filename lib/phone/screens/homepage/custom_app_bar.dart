// ignore_for_file: unnecessary_cast
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:ski_resorts_app/phone/screens/user_data_model.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  ImageProvider<Object> getTypeOfImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else if (path.startsWith('/')) {
      return FileImage(File(path));
    } else {
      return AssetImage(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context); // Get UserModel

    return Container(
        color: const Color.fromRGBO(12, 56, 177, 1),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(80.0 / 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(80.0 / 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/ProfilePageScreen',
                            );
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(80.0 / 8),
                              child: Center(
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: CircleAvatar(
                                    backgroundImage: getTypeOfImageProvider(
                                        userModel.avatarPath),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${userModel.name} ${userModel.surname}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Transform(
                    transform: Matrix4.rotationY(math.pi),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onTap: () {
                        //index

                        Navigator.pushNamed(
                          context,
                          '/SettingsPage',
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
