import 'package:bo_widgets/bo_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:japanese_50/src/rust/frb_generated.dart';
import 'package:japanese_50/src/rust/api/jap_char.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  await RustLib.init();
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      size: Size(392, 513),
      minimumSize: Size(392, 513),
      maximumSize: Size(392, 513),
      center: true,
      titleBarStyle: TitleBarStyle.hidden,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var charIter = charVec().iterator;
  late (String, String) c;
  bool isVisible = false;
  late String visibleString = _s.$1;
  final (String, String) _s = ('查看拼写', '隐藏拼写');
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    charIter.moveNext();
    c = splitJapChar(japChar: charIter.current);
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: TitleBar(),
        body: Center(
          child: Column(
            children: [
              Text(c.$1, style: TextStyle(fontSize: 108)),
              TextButton(
                onPressed: () {
                  _updateC();
                },
                child: Text('随机一个'),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _textController,
                  onChanged: (input) {
                    if (input == c.$1 || input == c.$2) {
                      _updateC();
                      _textController.clear();
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                    if (isVisible) {
                      visibleString = _s.$2;
                    } else {
                      visibleString = _s.$1;
                    }
                  });
                },
                child: Text(visibleString),
              ),

              Visibility(
                visible: isVisible,
                child: Text(c.$2, style: TextStyle(fontSize: 54)),
              ),
              // SizedBox(width: 100, child: TextField()),
            ],
          ),
        ),
      ),
    );
  }

  void _updateC() {
    setState(() {
      if (charIter.moveNext()) {
        c = splitJapChar(japChar: charIter.current);
      } else {
        charIter = charVec().iterator;
        charIter.moveNext();
        c = splitJapChar(japChar: charIter.current);
        if (kDebugMode) {
          print('已完成一轮');
        }
      }
    });
  }
}
