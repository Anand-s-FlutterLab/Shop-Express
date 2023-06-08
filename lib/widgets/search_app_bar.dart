import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/widgets/custom_search_view.dart';

import 'common_image_view.dart';

class SearchAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBarWidget()
      : preferredSize = Size.fromHeight(75),
        super();

  @override
  final Size preferredSize;

  @override
  State<StatefulWidget> createState() {
    return _SearchAppBarWidgetState();
  }
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 75,
      flexibleSpace: Container(decoration: AppDecoration.primaryBoxDecoration),
      title: CustomSearchView(
        width: Get.width,
        focusNode: FocusNode(),
        // controller: globalSearchController,
        hintText: "Search Here",
        alignment: Alignment.center,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(19, 13, 18, 13),
          child: Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
        ),
        prefixConstraints: BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
      ),
    );
  }
}