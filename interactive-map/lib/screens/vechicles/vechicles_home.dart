import 'package:flutter/material.dart';
import 'package:interactive_map/constants/constants.dart';
import 'package:get/get.dart';
import 'package:interactive_map/controller/controller.dart';
import 'package:interactive_map/screens/vechicles/avgNarm.dart';
import 'package:interactive_map/screens/vechicles/bus.dart';
import 'package:interactive_map/screens/vechicles/excavator.dart';
import 'package:interactive_map/screens/vechicles/sportsCar.dart';
import 'package:interactive_map/screens/vechicles/tractor.dart';
import 'package:interactive_map/screens/vechicles/train.dart';
import 'package:interactive_map/screens/vechicles/truck.dart';
import 'package:interactive_map/utills/utils.dart';
import 'package:interactive_map/widgets/custom_button_label_mobile.dart';
import 'package:interactive_map/widgets/custom_button_label_with_clip.dart';
import 'package:interactive_map/widgets/shared_widgets.dart';
import 'package:interactive_map/widgets/text_area_small_with_clip.dart';
import 'package:interactive_map/widgets/text_area_with_QR_with_clip.dart';
import 'package:video_player/video_player.dart';
import 'package:interactive_map/widgets/full_screen_button.dart';

class VechiclesHomeVideo extends StatefulWidget {
  const VechiclesHomeVideo({Key? key, this.offsetHor, this.offsetVer})
      : super(key: key);
  final offsetHor;
  final offsetVer;
  @override
  _VechiclesHomeVideoState createState() => _VechiclesHomeVideoState();
}

class _VechiclesHomeVideoState extends State<VechiclesHomeVideo> {
  bool loading = false;

  late VideoPlayerController _timerVideoController;

  late VideoPlayerController _trainVideoController;
  bool _trainVideoPlaying = false;
  late VideoPlayerController _sportsCarVideoController;
  bool _sportsCarVideoPlaying = false;
  late VideoPlayerController _avgNarmVideoController;
  bool _avgNarmVideoPlaying = false;
  late VideoPlayerController _busVideoController;
  bool _busVideoPlaying = false;
  late VideoPlayerController _tractorVideoController;
  bool _tractorVideoPlaying = false;
  late VideoPlayerController _excavatorVideoController;
  bool _excavatorVideoPlaying = false;
  late VideoPlayerController _truckVideoController;
  bool _truckVideoPlaying = false;

  bool _isPlaying = false;
  int index = 0;
  bool show = false;

  final String timerVideoUrl = 'assets/videos/vehicles/Vehicles_Main_Loop.m4v';

  final String trainVideoUrl = 'assets/videos/vehicles/Veh_To_Train.m4v';
  final String sportsCarVideoUrl = 'assets/videos/vehicles/Veh_To_Car.m4v';
  final String avgNarmVideoUrl = 'assets/videos/vehicles/Veh_To_AGV.m4v';
  final String busVideoUrl = 'assets/videos/vehicles/Veh_To_Bus.m4v';
  final String tractorVideoUrl = 'assets/videos/vehicles/Veh_To_Tractor.m4v';
  final String excavatorVideoUrl = 'assets/videos/vehicles/Veh_To_Exc.m4v';
  final String truckVideoUrl = 'assets/videos/vehicles/Veh_To_Truck.m4v';

  final String buildingImage = 'assets/videos/vehicles/Vehicles_Still.png';
  final String qrBackgroundImage =
      'assets/tempory images/Buildings_menu_QR.png';

  bool timerOFF = false;

  bool showQR = false;
  bool showTextAreaSmall = false;
  bool showNext = false;
  late String nextPage;

  double width = 0;

  setIndex(value) {
    index = value;
    setState(() {});
  }

  setShow() {
    setState(() {
      show = !show;
    });
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });

    index = 0;
    show = true;

    videoHandler();

    super.initState();
  }

  videoHandler() async {
    _timerVideoController = VideoPlayerController.asset(timerVideoUrl);
    await _timerVideoController.initialize();
    setState(() {
      _timerVideoController.setVolume(0);
      _timerVideoController.play();
      _timerVideoController.setLooping(true);
      setShow();
    });

    _trainVideoController = VideoPlayerController.asset(trainVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _trainVideoController.setVolume(0);
              _trainVideoController.setLooping(false);
            })
          });
    _sportsCarVideoController = VideoPlayerController.asset(sportsCarVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _sportsCarVideoController.setVolume(0);
              _sportsCarVideoController.setLooping(false);
            })
          });
    _avgNarmVideoController = VideoPlayerController.asset(avgNarmVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _avgNarmVideoController.setVolume(0);
              _avgNarmVideoController.setLooping(false);
            })
          });
    _busVideoController = VideoPlayerController.asset(busVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _busVideoController.setVolume(0);
              _busVideoController.setLooping(false);
            })
          });
    _tractorVideoController = VideoPlayerController.asset(tractorVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _tractorVideoController.setVolume(0);
              _tractorVideoController.setLooping(false);
            })
          });
    _excavatorVideoController = VideoPlayerController.asset(excavatorVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _excavatorVideoController.setVolume(0);
              _excavatorVideoController.setLooping(false);
            })
          });
    _truckVideoController = VideoPlayerController.asset(truckVideoUrl)
      ..initialize().then((_) => {
            setState(() {
              _truckVideoController.setVolume(0);
              _truckVideoController.setLooping(false);
            })
          });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _timerVideoController.dispose();
    _trainVideoController.dispose();
    _sportsCarVideoController.dispose();
    _avgNarmVideoController.dispose();
    _busVideoController.dispose();
    _tractorVideoController.dispose();
    _excavatorVideoController.dispose();
    _truckVideoController.dispose();

    super.dispose();
  }

  bool h = false;
  bool v = false;

  final ScrollController _scrollControllerHrizontal = ScrollController(
    initialScrollOffset: Get.find<Controller>().horizontalOffset.value,
  );

  final ScrollController _scrollControllerVertical = ScrollController(
    initialScrollOffset: Get.find<Controller>().verticalOffset.value,
  );
  static double offsetHor = 0;
  static double offsetVer = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_scrollControllerHrizontal.hasClients) {
      _scrollControllerHrizontal.animateTo(
          _scrollControllerHrizontal.position.maxScrollExtent / 2,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut);
      offsetHor = _scrollControllerHrizontal.position.maxScrollExtent / 2;
      Get.find<Controller>().horizontalOffset.value = offsetHor;
    }

    if (_scrollControllerVertical.hasClients) {
      _scrollControllerVertical.animateTo(
          _scrollControllerVertical.position.maxScrollExtent / 2,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut);
      offsetVer = _scrollControllerVertical.position.maxScrollExtent / 2;
      Get.find<Controller>().verticalOffset.value = offsetVer;
    }

    if (screenSize.height < 500 && screenSize.width > 500) {
      if (screenSize.width - screenSize.width * 0.3 / screenSize.height ==
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = false;
      } else if (screenSize.width - screenSize.width * 0.3 / screenSize.height <
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = true;
      } else {
        v = true;
        h = false;
      }
      var screenSizeMobile1 =
          Size(screenSize.width - screenSize.width * 0.3, screenSize.height);
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingButtonPanel(),
        body: Row(
          children: [
            Container(
              width: screenSize.width - screenSize.width * 0.3,
              height: screenSize.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollControllerHrizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollControllerVertical,
                  child: SizedBox(
                    width: Utils.getVideoScreenWidth(screenSizeMobile1),
                    height: Utils.getVideoScreenHeight(screenSizeMobile1),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: Utils.getVideoScreenWidth(screenSizeMobile1),
                          height: Utils.getVideoScreenHeight(screenSizeMobile1),
                          child: VideoPlayer(_timerVideoController),
                        ),
                        SizedBox(
                          width: Utils.getVideoScreenWidth(screenSizeMobile1),
                          height: Utils.getVideoScreenHeight(screenSizeMobile1),
                          child: Stack(
                            children: [
                              _trainVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child: VideoPlayer(_trainVideoController),
                                    )
                                  : Container(),
                              _sportsCarVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child: VideoPlayer(
                                          _sportsCarVideoController),
                                    )
                                  : Container(),
                              _avgNarmVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child:
                                          VideoPlayer(_avgNarmVideoController),
                                    )
                                  : Container(),
                              _busVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child: VideoPlayer(_busVideoController),
                                    )
                                  : Container(),
                              _tractorVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child:
                                          VideoPlayer(_tractorVideoController),
                                    )
                                  : Container(),
                              _excavatorVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child: VideoPlayer(
                                          _excavatorVideoController),
                                    )
                                  : Container(),
                              _truckVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile1),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile1),
                                      child: VideoPlayer(_truckVideoController),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        loading
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: Image.asset(
                                  buildingImage,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(),
                        showQR
                            ? GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    width = 0;
                                  });

                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  setState(() {
                                    showQR = false;
                                  });
                                  setShow();
                                },
                                child: SizedBox(
                                  width: Utils.getVideoScreenWidth(screenSize),
                                  height:
                                      Utils.getVideoScreenHeight(screenSize),
                                  child: Image.asset(
                                    qrBackgroundImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenSize.height,
                width: screenSize.width - screenSize.width * 0.3,
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: screenSize.width - screenSize.width * 0.3,
                      child: Column(
                        children: [
                          showNext
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      switch (nextPage) {
                                        case Pages.avgNarm:
                                          customPushReplacement(
                                              context,
                                              AvgNArmVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.train:
                                          customPushReplacement(
                                              context,
                                              TrainVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.excavator:
                                          customPushReplacement(
                                              context,
                                              ExcavatorVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.sportsCar:
                                          customPushReplacement(
                                              context,
                                              SportsCarVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.truck:
                                          customPushReplacement(
                                              context,
                                              TruckVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.tractor:
                                          customPushReplacement(
                                              context,
                                              TractorVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.bus:
                                          customPushReplacement(
                                              context,
                                              BusVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        default:
                                      }
                                      setState(() {
                                        showNext = false;
                                      });
                                    },
                                    child: Container(
                                      width: screenSize.width *
                                          0.091 *
                                          Utils.getMultiplier(screenSize.width),
                                      height: screenSize.width *
                                          0.040 *
                                          Utils.getMultiplier(screenSize.width),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(nextImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          show
                              ? Container()
                              : avgNarmMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : trainMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : sportsCarMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : busMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : tractorMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : excavatorMobile(
                                  screenSize.width - screenSize.width * 0.3),
                          show
                              ? Container()
                              : truckMobile(
                                  screenSize.width - screenSize.width * 0.3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (screenSize.width < 500) {
      if (screenSize.width / screenSize.height - screenSize.height * 0.3 ==
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = false;
      } else if (screenSize.width / screenSize.height -
              screenSize.height * 0.3 <
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = true;
      } else {
        v = true;
        h = false;
      }
      var screenSizeMobile2 =
          Size(screenSize.width, screenSize.height - screenSize.height * 0.3);
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingButtonPanel(),
        body: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height - screenSize.height * 0.3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollControllerHrizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _scrollControllerVertical,
                  child: SizedBox(
                    width: Utils.getVideoScreenWidth(screenSizeMobile2),
                    height: Utils.getVideoScreenHeight(screenSizeMobile2),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: Utils.getVideoScreenWidth(screenSizeMobile2),
                          height: Utils.getVideoScreenHeight(screenSizeMobile2),
                          child: VideoPlayer(_timerVideoController),
                        ),
                        SizedBox(
                          width: Utils.getVideoScreenWidth(screenSizeMobile2),
                          height: Utils.getVideoScreenHeight(screenSizeMobile2),
                          child: Stack(
                            children: [
                              _trainVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child: VideoPlayer(_trainVideoController),
                                    )
                                  : Container(),
                              _sportsCarVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child: VideoPlayer(
                                          _sportsCarVideoController),
                                    )
                                  : Container(),
                              _avgNarmVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child:
                                          VideoPlayer(_avgNarmVideoController),
                                    )
                                  : Container(),
                              _busVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child: VideoPlayer(_busVideoController),
                                    )
                                  : Container(),
                              _tractorVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child:
                                          VideoPlayer(_tractorVideoController),
                                    )
                                  : Container(),
                              _excavatorVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child: VideoPlayer(
                                          _excavatorVideoController),
                                    )
                                  : Container(),
                              _truckVideoPlaying
                                  ? SizedBox(
                                      width: Utils.getVideoScreenWidth(
                                          screenSizeMobile2),
                                      height: Utils.getVideoScreenHeight(
                                          screenSizeMobile2),
                                      child: VideoPlayer(_truckVideoController),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        loading
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: Image.asset(
                                  buildingImage,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(),
                        showQR
                            ? GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    width = 0;
                                  });

                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  setState(() {
                                    showQR = false;
                                  });
                                  setShow();
                                },
                                child: SizedBox(
                                  width: Utils.getVideoScreenWidth(screenSize),
                                  height:
                                      Utils.getVideoScreenHeight(screenSize),
                                  child: Image.asset(
                                    qrBackgroundImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: screenSize.width,
                      child: Column(
                        children: [
                          showNext
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      switch (nextPage) {
                                        case Pages.avgNarm:
                                          customPushReplacement(
                                              context,
                                              AvgNArmVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.train:
                                          customPushReplacement(
                                              context,
                                              TrainVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.excavator:
                                          customPushReplacement(
                                              context,
                                              ExcavatorVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.sportsCar:
                                          customPushReplacement(
                                              context,
                                              SportsCarVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.truck:
                                          customPushReplacement(
                                              context,
                                              TruckVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.tractor:
                                          customPushReplacement(
                                              context,
                                              TractorVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        case Pages.bus:
                                          customPushReplacement(
                                              context,
                                              BusVideo(
                                                from: Pages.vehicle,
                                                offsetHor: offsetHor,
                                                offsetVer: offsetVer,
                                              ));
                                          break;
                                        default:
                                      }
                                      setState(() {
                                        showNext = false;
                                      });
                                    },
                                    child: Container(
                                      width: screenSize.width *
                                          0.091 *
                                          Utils.getMultiplier(screenSize.width),
                                      height: screenSize.width *
                                          0.040 *
                                          Utils.getMultiplier(screenSize.width),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(nextImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          show ? Container() : avgNarmMobile(screenSize.width),
                          show ? Container() : trainMobile(screenSize.width),
                          show
                              ? Container()
                              : sportsCarMobile(screenSize.width),
                          show ? Container() : busMobile(screenSize.width),
                          show ? Container() : tractorMobile(screenSize.width),
                          show
                              ? Container()
                              : excavatorMobile(screenSize.width),
                          show ? Container() : truckMobile(screenSize.width),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (screenSize.width / screenSize.height ==
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = false;
      } else if (screenSize.width / screenSize.height <
          VideoAspectRatio.width / VideoAspectRatio.height) {
        v = false;
        h = true;
      } else {
        v = true;
        h = false;
      }
      return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: floatingButtonPanel(),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollControllerHrizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: _scrollControllerVertical,
            child: SizedBox(
              width: Utils.getVideoScreenWidth(screenSize),
              height: Utils.getVideoScreenHeight(screenSize),
              child: Stack(
                children: [
                  SizedBox(
                    width: Utils.getVideoScreenWidth(screenSize),
                    height: Utils.getVideoScreenHeight(screenSize),
                    child: VideoPlayer(_timerVideoController),
                  ),
                  show ? Container() : train(),
                  show ? Container() : sportsCar(),
                  show ? Container() : avgNarm(),
                  show ? Container() : bus(),
                  show ? Container() : tractor(),
                  show ? Container() : excavator(),
                  show ? Container() : truck(),
                  SizedBox(
                    width: Utils.getVideoScreenWidth(screenSize),
                    height: Utils.getVideoScreenHeight(screenSize),
                    child: Stack(
                      children: [
                        _trainVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_trainVideoController),
                              )
                            : Container(),
                        _sportsCarVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_sportsCarVideoController),
                              )
                            : Container(),
                        _avgNarmVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_avgNarmVideoController),
                              )
                            : Container(),
                        _busVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_busVideoController),
                              )
                            : Container(),
                        _tractorVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_tractorVideoController),
                              )
                            : Container(),
                        _excavatorVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_excavatorVideoController),
                              )
                            : Container(),
                        _truckVideoPlaying
                            ? SizedBox(
                                width: Utils.getVideoScreenWidth(screenSize),
                                height: Utils.getVideoScreenHeight(screenSize),
                                child: VideoPlayer(_truckVideoController),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  loading
                      ? SizedBox(
                          width: Utils.getVideoScreenWidth(screenSize),
                          height: Utils.getVideoScreenHeight(screenSize),
                          child: Image.asset(
                            buildingImage,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(),
                  showQR
                      ? GestureDetector(
                          onTap: () async {
                            setState(() {
                              width = 0;
                            });

                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            setState(() {
                              showQR = false;
                            });
                            setShow();
                          },
                          child: SizedBox(
                            width: Utils.getVideoScreenWidth(screenSize),
                            height: Utils.getVideoScreenHeight(screenSize),
                            child: Image.asset(
                              qrBackgroundImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget floatingButtonPanel() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          FullScreenButton(),
          Padding(
            padding:
                EdgeInsets.only(bottom: Utils.getBottomPadding(screenSize, 50)),
            child: Container(
              alignment: Alignment.centerLeft,
              height: screenSize.width * (0.2),
              child: showQR
                  ? TextAreaWithQRWithClip(
                      screenSize: screenSize,
                      width: width == 0 ? 0 : screenSize.width * (0.2),
                      height: screenSize.width * (0.2),
                    )
                  : Container(),
            ),
          ),
          showQR ? qrButton() : Container(),
          show ? Container() : qrButton(),
          showTextAreaSmall && _avgNarmVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText: TextsConstants
                          .avgNarmTexts["TextAreaSmallWithClip"][0],
                      description: TextsConstants
                          .avgNarmTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _truckVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText:
                          TextsConstants.truckTexts["TextAreaSmallWithClip"][0],
                      description:
                          TextsConstants.truckTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _trainVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText:
                          TextsConstants.trainTexts["TextAreaSmallWithClip"][0],
                      description:
                          TextsConstants.trainTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _busVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText:
                          TextsConstants.busTexts["TextAreaSmallWithClip"][0],
                      description:
                          TextsConstants.busTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _tractorVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText: TextsConstants
                          .tractorTexts["TextAreaSmallWithClip"][0],
                      description: TextsConstants
                          .tractorTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _sportsCarVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText: TextsConstants
                          .sportsCarTexts["TextAreaSmallWithClip"][0],
                      description: TextsConstants
                          .sportsCarTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showTextAreaSmall && _excavatorVideoPlaying
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: Utils.getBottomPadding(screenSize, 200)),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: TextAreaSmallWithClip(
                      width: screenSize.width * 0.35,
                      screenSize: screenSize,
                      prefixText: TextsConstants
                          .excavatorTexts["TextAreaSmallWithClip"][0],
                      description: TextsConstants
                          .excavatorTexts["TextAreaSmallWithClip"][1],
                    ),
                  ),
                )
              : Container(),
          showNext && screenSize.width >= 500 && screenSize.height >= 500
              ? Positioned(
                  right: 0,
                  bottom: Utils.getBottomPadding(screenSize, 200),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        switch (nextPage) {
                          case Pages.avgNarm:
                            customPushReplacement(
                                context,
                                AvgNArmVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.train:
                            customPushReplacement(
                                context,
                                TrainVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.excavator:
                            customPushReplacement(
                                context,
                                ExcavatorVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.dataCenter:
                            customPushReplacement(
                                context,
                                SportsCarVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.truck:
                            customPushReplacement(
                                context,
                                TruckVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.tractor:
                            customPushReplacement(
                                context,
                                TractorVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          case Pages.bus:
                            customPushReplacement(
                                context,
                                BusVideo(
                                  from: Pages.vehicle,
                                  offsetHor: offsetHor,
                                  offsetVer: offsetVer,
                                ));
                            break;
                          default:
                        }
                        setState(() {
                          showNext = false;
                        });
                      },
                      child: Container(
                        width: screenSize.width *
                            0.091 *
                            Utils.getMultiplier(screenSize.width),
                        height: screenSize.width *
                            0.040 *
                            Utils.getMultiplier(screenSize.width),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(nextImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget qrButton() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
      right: Utils.getRightPadding(screenSize, 0),
      child: Container(
        alignment: Alignment.topRight,
        height:
            screenSize.width * 0.050 * Utils.getMultiplier(screenSize.width),
        width: screenSize.width * 0.050 * Utils.getMultiplier(screenSize.width),
        child: GestureDetector(
          onTap: () async {
            if (showQR) {
              setState(() {
                width = 0;
              });

              await Future.delayed(const Duration(milliseconds: 200));
              setState(() {
                showQR = false;
              });
              setShow();
            } else {
              setShow();
              setState(() {
                width = 0;
                showQR = true;
              });

              await Future.delayed(const Duration(milliseconds: 200));

              setState(() {
                width = screenSize.width * 0.2;
              });
            }
          },
          child: Container(
            height: screenSize.width *
                0.050 *
                Utils.getMultiplier(screenSize.width),
            width: screenSize.width *
                0.050 *
                Utils.getMultiplier(screenSize.width),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: showQR
                    ? const AssetImage(homeImage)
                    : const AssetImage(moreImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget avgNarm() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.445,
        top: Utils.getVideoScreenHeight(screenSize) * 0.825,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _avgNarmVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _avgNarmVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });

                _avgNarmVideoController.addListener(() {
                  final bool isPlaying =
                      _avgNarmVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _avgNarmVideoController.removeListener(() {});

                      setState(() {
                        showNext = true;
                        nextPage = Pages.avgNarm;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.avgNarmTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget avgNarmMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.avgNarmTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _avgNarmVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _avgNarmVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.2;
        });

        _avgNarmVideoController.addListener(() {
          final bool isPlaying = _avgNarmVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _avgNarmVideoController.removeListener(() {});

              setState(() {
                showNext = true;
                nextPage = Pages.avgNarm;
              });
            }
          }
        });
      },
    );
  }

  Widget train() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.615,
        top: Utils.getVideoScreenHeight(screenSize) * 0.75,
        child: Stack(
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  setShow();
                  setState(() {
                    timerOFF = true;
                  });

                  _timerVideoController.pause();

                  setState(() {
                    _trainVideoPlaying = true;
                  });

                  setState(() {
                    width = 0;
                  });

                  _trainVideoController.play();

                  setState(() {
                    showTextAreaSmall = true;
                  });

                  await Future.delayed(const Duration(milliseconds: 200));

                  setState(() {
                    width = screenSize.width * 0.25;
                  });

                  _trainVideoController.addListener(() {
                    final bool isPlaying =
                        _trainVideoController.value.isPlaying;
                    print(isPlaying);
                    if (isPlaying != _isPlaying) {
                      setState(() {
                        _isPlaying = isPlaying;
                        setIndex(++index);
                      });
                      if (index > 1) {
                        _trainVideoController.removeListener(() {});
                        setState(() {
                          showNext = true;
                          nextPage = Pages.train;
                        });
                      }
                    }
                  });
                },
                child: CustomButtonLabelWithClip(
                  screenSize: screenSize,
                  text: TextsConstants.trainTexts["topic"],
                  type: 0,
                ),
              ),
            ),
          ],
        ));
  }

  Widget trainMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.trainTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _trainVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _trainVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });

        _trainVideoController.addListener(() {
          final bool isPlaying = _trainVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _trainVideoController.removeListener(() {});
              setState(() {
                showNext = true;
                nextPage = Pages.train;
              });
            }
          }
        });
      },
    );
  }

  Widget sportsCar() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.12,
        top: Utils.getVideoScreenHeight(screenSize) * 0.459,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _sportsCarVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _sportsCarVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });
                _sportsCarVideoController.addListener(() {
                  final bool isPlaying =
                      _sportsCarVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _sportsCarVideoController.removeListener(() {});
                      setState(() {
                        showNext = true;
                        nextPage = Pages.dataCenter;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.sportsCarTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget sportsCarMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.sportsCarTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _sportsCarVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _sportsCarVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });
        _sportsCarVideoController.addListener(() {
          final bool isPlaying = _sportsCarVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _sportsCarVideoController.removeListener(() {});
              setState(() {
                showNext = true;
                nextPage = Pages.dataCenter;
              });
            }
          }
        });
      },
    );
  }

  Widget tractor() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.269,
        top: Utils.getVideoScreenHeight(screenSize) * 0.22,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _tractorVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _tractorVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });

                _tractorVideoController.addListener(() {
                  final bool isPlaying =
                      _tractorVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _tractorVideoController.removeListener(() {});
                      setState(() {
                        showNext = true;
                        nextPage = Pages.tractor;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.tractorTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget tractorMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.tractorTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _tractorVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _tractorVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });

        _tractorVideoController.addListener(() {
          final bool isPlaying = _tractorVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _tractorVideoController.removeListener(() {});
              setState(() {
                showNext = true;
                nextPage = Pages.tractor;
              });
            }
          }
        });
      },
    );
  }

  Widget bus() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.62,
        top: Utils.getVideoScreenHeight(screenSize) * 0.13,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _busVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _busVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });

                _busVideoController.addListener(() {
                  final bool isPlaying = _busVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _busVideoController.removeListener(() {});

                      setState(() {
                        showNext = true;
                        nextPage = Pages.bus;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.busTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget busMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.busTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _busVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _busVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });

        _busVideoController.addListener(() {
          final bool isPlaying = _busVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _busVideoController.removeListener(() {});

              setState(() {
                showNext = true;
                nextPage = Pages.bus;
              });
            }
          }
        });
      },
    );
  }

  Widget excavator() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.75,
        top: Utils.getVideoScreenHeight(screenSize) * 0.64,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _excavatorVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _excavatorVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });

                _excavatorVideoController.addListener(() {
                  final bool isPlaying =
                      _excavatorVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _excavatorVideoController.removeListener(() {});
                      setState(() {
                        showNext = true;
                        nextPage = Pages.excavator;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.excavatorTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget excavatorMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.excavatorTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _excavatorVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _excavatorVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });

        _excavatorVideoController.addListener(() {
          final bool isPlaying = _excavatorVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _excavatorVideoController.removeListener(() {});
              setState(() {
                showNext = true;
                nextPage = Pages.excavator;
              });
            }
          }
        });
      },
    );
  }

  Widget truck() {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
        left: Utils.getVideoScreenWidth(screenSize) * 0.346,
        top: Utils.getVideoScreenHeight(screenSize) * 0.35,
        child: Stack(
          children: [
            InkWell(
              onTap: () async {
                setShow();
                setState(() {
                  timerOFF = true;
                });

                _timerVideoController.pause();

                setState(() {
                  _truckVideoPlaying = true;
                });

                setState(() {
                  width = 0;
                });

                _truckVideoController.play();

                setState(() {
                  showTextAreaSmall = true;
                });

                await Future.delayed(const Duration(milliseconds: 200));

                setState(() {
                  width = screenSize.width * 0.25;
                });

                _truckVideoController.addListener(() {
                  final bool isPlaying = _truckVideoController.value.isPlaying;
                  print(isPlaying);
                  if (isPlaying != _isPlaying) {
                    setState(() {
                      _isPlaying = isPlaying;
                      setIndex(++index);
                    });
                    if (index > 1) {
                      _truckVideoController.removeListener(() {});
                      setState(() {
                        showNext = true;
                        nextPage = Pages.truck;
                      });
                    }
                  }
                });
              },
              child: CustomButtonLabelWithClip(
                screenSize: screenSize,
                text: TextsConstants.truckTexts["topic"],
                type: 0,
              ),
            ),
          ],
        ));
  }

  Widget truckMobile(width) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButtonLabelMobile(
      width: width,
      title: TextsConstants.truckTexts["topic"],
      onPressed: () async {
        setShow();
        setState(() {
          timerOFF = true;
        });

        _timerVideoController.pause();

        setState(() {
          _truckVideoPlaying = true;
        });

        setState(() {
          width = 0;
        });

        _truckVideoController.play();

        setState(() {
          showTextAreaSmall = true;
        });

        await Future.delayed(const Duration(milliseconds: 200));

        setState(() {
          width = screenSize.width * 0.25;
        });

        _truckVideoController.addListener(() {
          final bool isPlaying = _truckVideoController.value.isPlaying;
          print(isPlaying);
          if (isPlaying != _isPlaying) {
            setState(() {
              _isPlaying = isPlaying;
              setIndex(++index);
            });
            if (index > 1) {
              _truckVideoController.removeListener(() {});
              setState(() {
                showNext = true;
                nextPage = Pages.truck;
              });
            }
          }
        });
      },
    );
  }
}
