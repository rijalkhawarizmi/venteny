import 'package:flutter/material.dart';

import '../../core/config/color_app.dart';
import 'custom_snackbar.dart';

class AlertSuccess {
  AlertSuccess._();

  static final AlertSuccess _instance = AlertSuccess._();

  factory AlertSuccess(){
    return _instance;
  }

  static void show(BuildContext context,String? message){
    CustomSnackbar.customSnackBar(context,
     customSnackBar: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Yeay",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorApp.white),
                            ),
                            Text(
                              message  ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: ColorApp.white),
                            )
                          ],
                        ),
                      ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.close,
                      color: ColorApp.slate800,
                      size: 23,
                    )
                  ],
                ),
              ),
              duration: const Duration(seconds: 4),
              backgroundColor: ColorApp.green400, 
              margin: const EdgeInsets.symmetric(horizontal: 10));
  }

}

//   static show(BuildContext context, String? text) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             // elevation: 0,
//             backgroundColor: Colors.transparent,
//             child: _customDialog(context, translateFromPattern(text ?? "")),
//           );
//         });
//   }

//   static _customDialog(BuildContext context, String? text) {
//     Future.delayed(Duration(seconds: 2), () async {
//       context.pop();
//     });
//     return Center(
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset('assets/icons/error.png'),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 text ?? "",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
