
import 'package:flutter/material.dart';
import 'package:flutter_avataaar/flutter_avataaar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:universal_io/io.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final avatar = Avataaar.random();
  final draggableController = DraggableScrollableController();
  bool isExpand = false;
  bool isAnimate = false;
  double minSnap = 0;

  @override
  void initState() {
    super.initState();

    draggableController.addListener(onSnap);
  }

  void onSnap() {
    if (isAnimate) return;
    if ((draggableController.size - minSnap).abs() < 0.000001) {
      if (isExpand == false) return;
      setState(() => isExpand = false);
    }
  }

  @override
  void dispose() {
    draggableController.removeListener(onSnap);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final md = MediaQuery.of(context);
    final bottomOffset = md.padding.bottom;
    minSnap = (bottomOffset + 80) / (md.size.height - md.padding.top - 56);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: LineIcon.broadcastTower(),
        actions: [
          SizedBox(
            height: 56,
            width: 56,
            child: Center(child: LineIcon.search()),
          ),
        ],
        title: SizedBox(
          height: 42,
          width: 42,
          child: AvataaarPicture.builder(avatar: avatar),
        ),
      ),
      body: ListView(
        children: [
          // TITLE
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text.rich(
              TextSpan(
                text: 'Hello, ',
                style: theme.textTheme.headlineLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w300),
                children: [
                  TextSpan(
                    text: 'JOHN',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CLASSES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Classes',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text('5 classes today'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AspectRatio(
              aspectRatio: 16 / 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFe1e4e3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 52,
                                width: 52,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFd1d7d4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '🏹',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'History',
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Text('8:00 - 8:45'),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: LineIcon.phone(),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    height: 20,
                                    width: 1.5,
                                    child: ColoredBox(color: Colors.white60),
                                  ),
                                ),
                                Text(
                                  'Join now',
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '📔',
                        style: TextStyle(fontSize: Platform.isIOS ? 84 : 56),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // HOMEWORKS
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Homeworks',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text('View all'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF866ee1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFffd2dd),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IntrinsicHeight(
                          child: Column( 
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: Text(
                                          'Physics',
                                          style: theme.textTheme.titleLarge!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          LineIcon.clockAlt(
                                            color:
                                                Colors.black.withOpacity(0.45),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '2 days left',
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                              color: Colors.black
                                                  .withOpacity(0.45),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 90,
                                    height: 72,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: const Color(0xFFfec7d4),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '📚',
                                          style: theme.textTheme.headline2!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Newton\'s low motion',
                                          style: theme.textTheme.headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Read screens 1.1 - 1.2 of',
                                          style: theme.textTheme.subtitle1!
                                              .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  LineIcon.info(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isExpand
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                if (isExpand == false) {
                  setState(() {
                    isAnimate = true;
                    isExpand = true;
                  });
                  Future.microtask(() async {
                    await draggableController.animateTo(
                      0.7,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutBack,
                    );
                    await Future.delayed(Duration.zero);
                    isAnimate = false;
                  });
                }
              },
              icon: LineIcon.arrowCircleUp(),
              label: const Text('Expand'),
            ),
      bottomSheet: DraggableScrollableSheet(
        controller: draggableController,
        expand: false,
        snap: true,
        snapSizes: [minSnap, 0.7, 1],
        minChildSize: minSnap,
        initialChildSize: minSnap,
        builder: (context, scrollController) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (notification) {
              bool newIsExpand = draggableController.size > minSnap;
              if ((draggableController.size - minSnap).abs() < 0.00001) {
                setState(() => isExpand = false);
                return true;
              }
              if (isExpand != newIsExpand) {
                setState(() => isExpand = newIsExpand);
              }
              return true;
            },
            child: ListView(
              controller: scrollController,
              children: [
                DragHeader(isExpand),
                const SizedBox(
                  height: 300,
                  child: Center(
                    child: Text('Doesn\'t have timeline yet'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DragHeader extends StatelessWidget {
  const DragHeader(this.isExpand, {super.key});

  final bool isExpand;

  @override
  Widget build(BuildContext context) {
    final md = MediaQuery.of(context);
    final bottomOffset = md.padding.bottom;
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.ease,
      child: () {
        if (isExpand) return const SizedBox(height: 25);
        return Column(
          children: [
            NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: LineIcon.home(),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: LineIcon.cog(),
                  label: 'Setting',
                ),
              ],
            ),
            SizedBox(height: bottomOffset),
          ],
        );
      }(),
    );
  }
}
