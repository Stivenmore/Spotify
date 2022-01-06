import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_exoplayer/audioplayer.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class PlayerWidget extends StatefulWidget {
  final String url;
  final AudioPlayer audioPlayer;
  final bool? isUser;

  PlayerWidget({
    required this.url,
    required this.audioPlayer,
    this.isUser,
  });

  @override
  State<StatefulWidget> createState() {
    return _PlayerWidgetState(url: url, audioPlayer: audioPlayer);
  }
}

class _PlayerWidgetState extends State<PlayerWidget> {
  final String? url;
  AudioPlayer? audioPlayer;
  bool ignored = false;

  Duration? _duration;
  Duration? _position;

  PlayerState _playerState = PlayerState.RELEASED;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerErrorSubscription;
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _playerIndexSubscription;
  StreamSubscription? _playerAudioSessionIdSubscription;

  get _durationText => _duration?.toString().split('.').first ?? '';
  get _positionText => _position?.toString().split('.').first ?? '';

  _PlayerWidgetState({this.url, this.audioPlayer});

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer!.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _playerIndexSubscription?.cancel();
    _playerAudioSessionIdSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _positionText == ''
                          ? ''
                          : '${_positionText[3]}:${_positionText[5] + _positionText[6] ?? ""}',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      _durationText == ''
                          ? ''
                          : '${_durationText[3]}:${_durationText[5] + _durationText[6] ?? ''}',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: responsive.wp(90),
                child: SliderTheme(
                  data: const SliderThemeData(
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
                    trackHeight: 3,
                    thumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey,
                    activeTrackColor: Colors.white,
                    overlayColor: Colors.transparent,
                  ),
                  child: Slider(
                    value: _position?.inMilliseconds.toDouble() ?? 0.0,
                    min: 0.0,
                    max: _duration?.inMilliseconds.toDouble() ?? 0.0,
                    onChanged: (double value) async {
                      final Result result = await audioPlayer!
                          .seekPosition(Duration(milliseconds: value.toInt()));
                      if (result == Result.FAIL) {}
                      _position = Duration(milliseconds: value.toInt());
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff7A7B8C), Color(0xff4D4E65)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    transform: GradientRotation(0.7853982)),
                borderRadius: BorderRadius.circular(48)),
            child: Center(
              child: IgnorePointer(
                ignoring: ignored,
                child: IconButton(
                    onPressed: () async {
                      if (_playerState == PlayerState.PLAYING) {
                        audioPlayer!.pause().whenComplete(() {});
                      } else {
                        if (_duration != null) {
                          if (_playerState == PlayerState.PAUSED) {
                            await audioPlayer!.resume();
                          } else {
                            setState(() {
                              ignored = true;
                            });
                            await audioPlayer!
                                .play(
                              url!,
                            ).whenComplete(() {
                              setState(() {
                                ignored = false;
                              });
                            });
                          }
                        } else {
                          await audioPlayer!.play(
                            url!,
                          );
                        }
                      }
                    },
                    iconSize: 26.0,
                    icon: _playerState == PlayerState.RELEASED
                        ? const Icon(Icons.play_arrow)
                        : _playerState == PlayerState.PLAYING
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _durationSubscription = audioPlayer!.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _positionSubscription = audioPlayer!.onAudioPositionChanged.listen((pos) {
      setState(() {
        _position = pos;
      });
    });
    _playerStateSubscription =
        audioPlayer!.onPlayerStateChanged.listen((playerState) {
      setState(() {
        _playerState = playerState;
      });
    });
    _playerIndexSubscription =
        audioPlayer!.onCurrentAudioIndexChanged.listen((index) {
      setState(() {
        _position = const Duration(milliseconds: 0);
      });
    });
    _playerAudioSessionIdSubscription =
        audioPlayer!.onAudioSessionIdChange.listen((audioSessionId) {});
    _playerCompleteSubscription = audioPlayer!.onPlayerCompletion.listen((a) {
      _position = const Duration(milliseconds: 0);
    });
  }
}
