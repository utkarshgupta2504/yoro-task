import 'package:flutter/material.dart';
import 'package:yoro_task/components/data_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> leftOffsetAnimation = Tween<Offset>(
    begin: Offset(-1.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  late Animation<Offset> rightOffsetAnimation = Tween<Offset>(
    begin: Offset(1.0, 0.0),
    end: const Offset(0.0, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  List<int> generatedNumbers = List.generate(10, (i) => i);

  Future<void> generateNewList() async {
    Future.delayed(Duration(seconds: 1));

    _controller.reset();

    setState(() {
      generatedNumbers.shuffle();
    });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _controller.forward();

    generateNewList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Yoro"),
      ),
      body: Container(
        height: double.infinity,
        child: RefreshIndicator(
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: generatedNumbers
                      .sublist(0, 3)
                      .asMap()
                      .entries
                      .map((e) => SlideTransition(
                            position: e.key % 2 == 0
                                ? leftOffsetAnimation
                                : rightOffsetAnimation,
                            child: DataItem(
                              isRightAligned: e.key % 2 == 1,
                              image: "images/bg${e.value}.jpeg",
                              title: "Hello no.${e.value + 1}, how are you?",
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          onRefresh: generateNewList,
        ),
      ),
    );
  }
}
