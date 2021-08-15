import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/mall_api_provider.dart';
import 'package:junior_test/tools/CustomNetworkImageLoader.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/tools/Tools.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';

class SingleActionItem extends StatelessWidget {
  static String TAG = "ActionsItemWidget";
  final PromoItem promoItem;

  const SingleActionItem({Key key, this.promoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ActionsItemWidget.TAG,
              arguments: ActionsItemArguments(promoItem.id));
        },
        child: Card(
            child: CachedNetworkImage(
          imageUrl: Tools.getImagePath(promoItem.imgFull),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Image(image: AssetImage('mall_background.png')),
          imageBuilder: (context, imageProvider) => Container(
            child: Column(
              children: [
                Spacer(),
                _promoName(promoItem.name),
                Spacer(),
                _promoShop(promoItem.shop)
              ],
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget _promoShop(String shopName) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        shopName,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MyColors.white,
          fontSize: MyDimens.titleSmall,
        ),
      ),
    );
  }

  Widget _promoName(String name) {
    return Center(
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: MyColors.white,
            fontSize: MyDimens.titleNormal,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
