import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondsmart/common/common_constant/color_constants.dart';

class CustomSlider extends StatefulWidget {
  final Function onRepair;
  final Function onSale;
  const CustomSlider({required this.onRepair, required this.onSale, Key? key})
      : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  String bucketName = 'Bucket';
  int milliSeconds = 0;
  double buttonWidth = 90;
  double dx = 0;
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constrain) {
            if (dx == 0) dx = (constrain.maxWidth / 2) - (buttonWidth / 2);
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('Repair',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Spacer(),
                      Text('Sales',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ),
                AnimatedPositioned(
                    left: dx,
                    child: GestureDetector(
                      onHorizontalDragStart: (s) {
                        milliSeconds = 1;
                      },
                      onHorizontalDragUpdate: (s) {
                        var value = (((constrain.maxWidth) / Get.width) *
                                s.globalPosition.dx) -
                            (buttonWidth / 2);
                        dx = value;
                        if (value > (constrain.maxWidth - buttonWidth)) {
                          dx = constrain.maxWidth - buttonWidth;
                        }
                        if (dx < 1) {
                          dx = 1;
                        }
                        setState(() {});
                      },
                      onHorizontalDragEnd: (e) {
                        if (dx == 1) {
                          bucketName = 'Repair';
                          widget.onRepair();
                        } else if (dx == constrain.maxWidth - buttonWidth) {
                          bucketName = 'Sales';
                          widget.onSale();
                        } else {
                          dx = (constrain.maxWidth / 2) - (buttonWidth / 2);
                          milliSeconds = 300;
                          bucketName = 'Bucket';
                        }
                        setState(() {});
                      },
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 5,
                        child: Container(
                          height: 58,
                          width: buttonWidth,
                          decoration: BoxDecoration(
                              color: kPrimaryLightGreen,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(bucketName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white))
                            ],
                          )),
                        ),
                      ),
                    ),
                    duration: Duration(milliseconds: milliSeconds))
              ],
            );
          },
          // child:
        ),
      ),
    );
  }
}
