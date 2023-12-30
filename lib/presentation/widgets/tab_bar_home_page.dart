// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TabBarHomePage extends StatefulWidget {
  final List<Widget> widgets;
  const TabBarHomePage({
    Key? key,
    required this.widgets,
  }) : super(key: key);

  @override
  State<TabBarHomePage> createState() => _TabBarHomePageState();
}

class _TabBarHomePageState extends State<TabBarHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  ValueNotifier<int> indexTab = ValueNotifier(0);

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if (indexTab.value != controller.indexIsChanging) {
        indexTab.value = controller.index;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<int>(
            valueListenable: indexTab,
            builder: (context, value, _) {
              return Row(
                children: List.generate(
                  2,
                  (index) {
                    return tabBarWidget(
                      isClick: value == index,
                      title: index == 0 ? "Movie" : "TV Series",
                      onTap: () {
                        setState(() {
                          controller.animateTo(index);
                        });
                      },
                    );
                  },
                ),
              );
            }),
        SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: widget.widgets,
          ),
        ),
      ],
    );
  }
}

Widget tabBarWidget({
  required bool isClick,
  required String title,
  required void Function() onTap,
}) {
  return IntrinsicHeight(
    child: Stack(
      children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Color.fromARGB(255, 24, 22, 22), width: 4),
                ),
              ),
            )),
        Align(
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: isClick
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 3,
                        ),
                      )
                    : Border(),
              ),
              padding:
                  const EdgeInsets.only(right: 8, bottom: 19, top: 1),
              child: Text(
                title,
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
