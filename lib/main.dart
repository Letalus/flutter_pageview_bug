import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const PremiumTileSlider(),
    );
  }
}

class PremiumTileSlider extends StatefulWidget {
  const PremiumTileSlider({Key? key}) : super(key: key);

  @override
  State<PremiumTileSlider> createState() => _PremiumTileSliderState();
}

class _PremiumTileSliderState extends State<PremiumTileSlider> {
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.75);
  final double _height = 400;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentVal = _pageController.hasClients ? _pageController.page ?? 0 : 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bug'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
                height: _height,
                child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return _animateWidget(
                          tilePosition: index,
                          currentPosition: currentVal,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            color: Colors.red,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Expanded(child: Text('1')),
                                Expanded(child: Text('2')),
                              ],
                            ),
                          ));
                    })),
          )
        ],
      ),
    );
  }

  Widget _animateWidget({required Widget child, required int tilePosition, required double currentPosition}) {

    double difference = (tilePosition - currentPosition).abs();
    final scale = difference > 1 ? 0.7 : 0.7 + 0.3 * (1 - difference);
    final opacity = difference > 1 ? 0.6 : 0.6 + 0.4 * (1 - difference);

    return Transform.scale(
      scale: scale,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
