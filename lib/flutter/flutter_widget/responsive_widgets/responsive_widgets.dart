import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/flexible_expanded_widget.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/layout_builder_widget.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/media_query_widget.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/orientation_builder_widget.dart';
import 'package:learning_flutter/flutter/flutter_widget/responsive_widgets/safe_area_widget.dart';

class ResponsiveWidgets extends StatelessWidget {
  const ResponsiveWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,

      child: Scaffold(
        appBar: AppBar(
          title: Text("Responsive Widgets"),
          bottom: TabBar(
            tabs: [
              Tab(text: 'LayoutBuilder'),
              Tab(text: 'MediaQuery'),
              Tab(text: 'SafeArea'),
              Tab(text: 'OrientationBuilder'),
              Tab(text: 'Flexible / Expanded'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            LayoutBuilderWidget(),
            MediaQueryWidget(),
            SafeAreaWidget(),
            OrientationBuilderWidget(),
            FlexibleExpandedWidget(),
          ],
        ),
      ),
    );
  }
}
