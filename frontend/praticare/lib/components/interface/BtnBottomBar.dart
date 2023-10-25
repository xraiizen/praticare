// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class BtnBottomBar extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final String routeName;
//   const BtnBottomBar({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.routeName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//               return Colors.transparent;
//             },
//           ),
//           shadowColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//               return Colors.transparent;
//             },
//           ),
//           surfaceTintColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//               return Colors.transparent;
//             },
//           ),
//           overlayColor: MaterialStateProperty.resolveWith<Color>(
//             (Set<MaterialState> states) {
//               return Colors.transparent;
//             },
//           ),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   side: const BorderSide(color: Colors.transparent))),
//         ),
//         onPressed: () {
//           GoRouter.of(context).pushNamed(routeName);
//         },
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 24,
//             ),
//             Text(title)
//           ],
//         ));
//   }
// }
