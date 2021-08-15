// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/blocs/actions/ActionsItemQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/ui/actions/SingleAction.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';

class ActionsWidget extends StatefulWidget {
  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  ActionsItemQueryBloc bloc;
  int pageNumber = 1;
  int pageCount = 2;
  ScrollController _scrollController;
  List<PromoItem> actions = [];
  bool isRefresh = false;

  _ActionsWidgetState() {
    bloc = ActionsItemQueryBloc();
  }

  @override
  Widget build(BuildContext context) {
    // if (actionId == -1) {
    //   final ActionsItemArguments args =
    //       ModalRoute.of(context).settings.arguments;
    //   actionId = args.actionId;
    // }
    return BlocProvider<ActionsItemQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopItemContentStream));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget onSuccess(RootTypes event, RootResponse response) {
    if (isRefresh) {
      actions.addAll(response.serverResponse.body.promo.list);
    } else {
      actions = response.serverResponse.body.promo.list;
    }

    return Scaffold(
      body: GridView.builder(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          itemCount: actions.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //* Раскомментировать для теста пагинации
            // childAspectRatio: 0.3,
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            return SingleActionItem(
              promoItem: actions[index],
            );
          }),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      isRefresh = true;

      pageNumber++;

      bloc.loadActions(pageNumber, pageCount);
    }
  }

  void runOnWidgetInit() {
    bloc.loadActions(pageNumber, pageCount);

    _scrollController = new ScrollController(initialScrollOffset: 0.0)
      ..addListener(_scrollListener);
  }
}
