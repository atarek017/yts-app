import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Trailar extends StatefulWidget {
  String ytCode = "";

  Trailar(this.ytCode);

  @override
  _TrailarState createState() => _TrailarState();
}

class _TrailarState extends State<Trailar> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          "https://r6---sn-p5qs7nee.googlevideo.com/videoplayback?expire=1569139287&ei=99WGXYHwK7qshwaohIqoAg&ip=3.86.249.97&id=o-AFI5r-l1WDgL03HxJ-uJTm77iOXiiCRK_e9JIRWWEter&itag=18&source=youtube&requiressl=yes&mm=31%2C26&mn=sn-p5qs7nee%2Csn-t0a7ln7d&ms=au%2Conr&mv=u&mvi=5&pl=21&mime=video%2Fmp4&gir=yes&clen=25063757&ratebypass=yes&dur=812.257&lmt=1545030586158089&mt=1569116922&fvip=4&txp=5431432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=ALgxI2wwRgIhAPhrFtrq-t_d7xGjUwCMkqMxtjoxHkHR0LPJ_hmL_mKJAiEAvI5XRmRw2xSI8OzpBSBLOU3Q6G_FeB4df0tziTshgz4%3D&lsparams=mm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=AHylml4wRAIgcsN0JuUklzUntQ9teozhEF4_oVB_r4sRTv4y8ckdYBACIFQq10WZJJuv5kqT8hxl-Hh-80l1pRGHAYt5mTyYHkZ7")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play()
      ;
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
          playerController.play();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
