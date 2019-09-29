import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Trailar extends StatefulWidget {
  String ytID = "";

  Trailar(this.ytID);

  @override
  _TrailarState createState() => _TrailarState();
}

class _TrailarState extends State<Trailar> {
  YoutubePlayerController _controller = YoutubePlayerController();
  double _volume = 100;
  bool _muted = false;
  String _playerStatus = "";
  String _errorCode = '0';

  void listener() {
    if (_controller.value.playerState == PlayerState.ENDED) {
    }
    if (mounted) {
      setState(() {
        _playerStatus = _controller.value.playerState.toString();
        _errorCode = _controller.value.errorCode.toString();
      });
    }
  }

  @override
  void deactivate() {
    // This pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Trailar ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            YoutubePlayer(
              context: context,
              videoId: widget.ytID,
              flags: YoutubePlayerFlags(
                mute: false,
                autoPlay: true,
                forceHideAnnotation: true,
                showVideoProgressIndicator: true,
                disableDragSeek: false,
              ),
              videoProgressIndicatorColor: Color(0xFFFF0000),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20.0,
                  ),
                  onPressed: () {},
                ),
                Text(
                  'Hello! This is a test title.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  onPressed: () {},
                ),
              ],
              progressColors: ProgressColors(
                playedColor: Color(0xFFFF0000),
                handleColor: Color(0xFFFF4433),
              ),
              onPlayerInitialized: (controller) {
                _controller = controller;
                _controller.addListener(listener);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.play_arrow
                              : Icons.pause,
                        ),
                        onPressed: () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                        onPressed: () {
                          _muted ? _controller.unMute() : _controller.mute();
                          setState(() {
                            _muted = !_muted;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.fullscreen),
                        onPressed: () => _controller.enterFullScreen(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: (value) {
                            setState(() {
                              _volume = value;
                            });
                            _controller.setVolume(_volume.round());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
