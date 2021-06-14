import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/models/entity/storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class StorageProtectingWidget extends StatelessWidget {
  final Storage data;
  final Size deviceSize;

  StorageProtectingWidget({@required this.data, @required this.deviceSize});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => DetailProtectingServiceScreen(
        //             data: data,
        //           )),
        // );
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          height: deviceSize.height / 2.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CustomColor.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 6),
                    color: Color(0xFF000000).withOpacity(0.06))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Container(
                    width: deviceSize.width,
                    height: deviceSize.height / 5.2,
                    child: Image.network(
                      data.picture,
                      fit: BoxFit.cover,
                    )),
              ),
              CustomSizedBox(
                height: 16,
                context: context,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomText(
                  text: data.name == null ? 'Storage' : data.name,
                  color: CustomColor.black,
                  textAlign: TextAlign.start,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16),
                  child: CustomText(
                      text: data.address,
                      color: CustomColor.black[2],
                      context: context,
                      maxLines: 2,
                      fontSize: 14)),
              CustomSizedBox(
                context: context,
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBarIndicator(
                      rating: data.rating * 1.0,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Color(0xFFFFCC1F),
                      ),
                      itemCount: 5,
                      itemSize: 18,
                      direction: Axis.horizontal,
                    ),
                    CustomText(
                      text: '${data.priceFrom} -  ${data.priceTo} VND',
                      color: CustomColor.purple,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
