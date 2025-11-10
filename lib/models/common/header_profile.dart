import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saveon_frontend/models/common/coming_soon_alert.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 122,

      child: Stack(
        fit: StackFit.expand,

        children: [
          //Background Image
          Positioned.fill(
            child: SvgPicture.asset(
              "lib/assets/header_profile/top_bar_background.svg",
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
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
                      "lib/assets/header_profile/profile_image.svg",
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Stanislav Poleheshko', //MOCKED
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
  }
}
