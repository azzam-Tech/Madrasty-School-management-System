import 'package:flutter/material.dart';
import 'package:graduation_project/constant/fontstyle.dart';

class searchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
   bool noResults;

   searchBar({
    required this.controller,
    required this.onChanged,
    this.noResults =false,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 10,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: Colors.black),
                      onChanged: onChanged,
                      decoration: InputDecoration(
                        hintText: 'ابحث...',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    onChanged(controller.text);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          if (noResults)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('لا توجد نتائج', style: fontstyle.fontheading),
              ),
            ),
        ],
      ),
    );
  
  }
}


// Widget searchBar({
//     required TextEditingController controller,
//     required Function(String)  onChanged,
//     bool noResults = false,
//   }){
//  return   Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Card(
//             elevation: 10,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 6),
//                     child: TextField(
//                       controller: controller,
//                       style: TextStyle(color: Colors.black),
//                       onChanged: onChanged,
//                       decoration: InputDecoration(
//                         hintText: 'ابحث...',
//                         hintStyle: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     onChanged(controller.text);
//                   },
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (noResults)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Center(
//                 child: Text('لا توجد نتائج', style: fontstyle.fontheading),
//               ),
//             ),
//         ],
//       ),
//     );
  
// }