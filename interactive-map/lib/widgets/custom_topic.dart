import 'package:flutter/material.dart';
import 'package:interactive_map/constants/constants.dart';
import 'package:interactive_map/utills/utils.dart';

class CustomTopic extends StatelessWidget {
  const CustomTopic({
    Key? key,
    required this.topic,
    required this.subTopic,
    required this.screenSize,
  }) : super(key: key);

  final String topic;
  final String subTopic;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10 * (screenSize.height / VideoAspectRatio.height),
        horizontal: 10 * (screenSize.width / VideoAspectRatio.width),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            topic,
            style: TextStyle(
              color: AppColors.night,
              fontSize: screenSize.width > 500
                  ? 35 *
                      (screenSize.width / VideoAspectRatio.width) *
                      Utils.getMultiplier(screenSize.width)
                  : 27 *
                      (screenSize.width / VideoAspectRatio.width) *
                      Utils.getMultiplier(screenSize.width),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
              fontFamily: Fonts.regular,
            ),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: screenSize.height * (15 / VideoAspectRatio.height),
          ),
          Text(
            subTopic,
            style: TextStyle(
              color: AppColors.sea,
              fontSize: screenSize.width > 500
                  ? 22 *
                      (screenSize.width / VideoAspectRatio.width) *
                      Utils.getMultiplier(screenSize.width)
                  : 20 *
                      (screenSize.width / VideoAspectRatio.width) *
                      Utils.getMultiplier(screenSize.width),
              fontWeight: FontWeight.w600,
              fontFamily: Fonts.bold,
            ),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
