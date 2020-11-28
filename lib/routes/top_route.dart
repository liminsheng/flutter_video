import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video/common/NetRequest.dart';
import 'package:flutter_video/models/category.dart';
import 'package:flutter_video/models/topSubject.dart';
import 'package:flutter_video/widgets/top_subject_item.dart';

class TopRoute extends StatefulWidget {
  @override
  _TopRouteState createState() => _TopRouteState();
}

class _TopRouteState extends State<TopRoute> {
  Category category;

  @override
  Widget build(BuildContext context) {
    category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(category.title, style: TextStyle(fontFamily: 'ZhiMangXing')),
      ),
      body: InfiniteListView<TopSubject>(
        onRetrieveData: _retrieveData,
        itemBuilder: _buildItem,
        separatorBuilder: (List<TopSubject> list, int index, BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Divider(height: 1),
          );
        },
      ),
    );
  }

  Future<bool> _retrieveData(
      int page, List<TopSubject> items, bool refresh) async {
    var data = await NetRequest(context).getTopList(
      type: category.type,
      start: items.length,
      limit: 20,
      refresh: refresh,
    );
    print(data[0].title);
    //把请求到的新数据添加到items中
    items.addAll(data);
    // 如果接口返回的数量等于'page_size'，则认为还有数据，反之则认为最后一页
    return data.length == 20;
  }

  Widget _buildItem(List<TopSubject> list, int index, BuildContext ctx) {
    return TopSubjectItem(list[index]);
  }
}
