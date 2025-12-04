import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:saveon_frontend/models/common/coming_soon_alert.dart';
import 'package:saveon_frontend/services/user_service.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (context, userService, child) {
        final user = userService.currentUser;
        return SizedBox(
          width: double.infinity,
          height: 122,

          child: Stack(
            fit: StackFit.expand,

            children: [
              //Background Image
              Positioned.fill(
                child: SvgPicture.asset(
                  "lib/assets/header_profile/top_bar_background.svg",
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomCenter,
                ),
              ),

              //Content of Header Profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Left Part
                    Row(
                      children: [
                        SvgPicture.asset(
                          "lib/assets/header_profile/profile_image.svg", //MOCKED
                        ),
                        SizedBox(width: 10),
                        Text(
                          user?.fullName ?? 'Loading...',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),

                    //Right Part
                    IconButton(
                      onPressed: () => showComingSoonDialog(context),
                      icon: SvgPicture.asset(
                        "lib/assets/header_profile/icon_settings.svg",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
