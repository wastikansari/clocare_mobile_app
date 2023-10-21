// import 'package:flutter/material.dart';

// class DynamicDropdownForm extends StatelessWidget {
//   List data = [

// {'service_id': 0,
//  'service_name': 'Wash',
//  'gtype':[
//   {
//   'gtype_id': 0,
//   'gtype_name':'Men',
//   'item':[
//     {
//       'garment': 'shirt',
//       'price':'10',
//       'qtn':4,
//     },
//         {
//       'garment': 'pent',
//       'price':'15',
//       'qtn':2,
//     }
//   ]
//   },
//     {
//   'gtype_id': 1,
//   'gtype_name':'Woman',
//   'item':[
//     {
//       'garment': 'sout',
//       'price':'5',
//       'qtn':3,
//     },
//         {
//       'garment': 'saree',
//       'price':'12',
//       'qtn':3,
//     }
//   ]
//   }

//  ]
//   },
//   {'service_id': 0,
//  'service_name': 'Iron',
//  'gtype':[
//   {
//   'gtype_id': 0,
//   'gtype_name':'Men',
//   'item':[
//     {
//       'garment': 'jines',
//       'price':'5',
//       'qtn':6,
//     },
//         {
//       'garment': 'pent',
//       'price':'15',
//       'qtn':2,
//     }
//   ]
//   },
//     {
//   'gtype_id': 1,
//   'gtype_name':'Woman',
//   'item':[
//     {
//       'garment': 'sout',
//       'price':'5',
//       'qtn':3,
//     },
//         {
//       'garment': 'saree',
//       'price':'12',
//       'qtn':3,
//     }
//   ]
//   }

//  ]
//   },

// ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('JSON Data Display'),
//         ),
//         body: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             final service = data[index];
//             final serviceName = service['service_name'];
//             final gtypes = service['gtype'];

//             return ListTile(
//               title: Text(serviceName),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: gtypes.map<Widget>((gtype) {
//                   final gtypeName = gtype['gtype_name'];
//                   final items = gtype['item'];
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(gtypeName),
//                       Column(
//                         children: items.map<Widget>((item) {
//                           final garment = item['garment'];
//                           final price = item['price'];
//                           final qtn = item['qtn'];
//                           return ListTile(
//                             title: Text(garment),
//                             subtitle: Text('Price: $price, Quantity: $qtn'),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
