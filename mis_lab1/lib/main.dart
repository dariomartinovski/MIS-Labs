import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ClothesListScreen(),
    );
  }
}

// CONFIGURATION BELLOW
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'This is a listing app',
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             Text(
//               'This is another text here',
//               style: Theme.of(context).textTheme.headlineSmall,
//             )
//           ],
//         ),
//       )
//     );
//   }
// }


class Cloth{
  final String name, description, imageUrl;
  final double price;

  const Cloth({required this.name, required this.description, required this.imageUrl, required this.price});
}

class ClothesListScreen extends StatefulWidget {
  const ClothesListScreen({super.key});

  @override
  State<ClothesListScreen> createState() => _ClothesListScreenState();
}

class _ClothesListScreenState extends State<ClothesListScreen> {
  final List<Cloth> _clothes = [
    const Cloth(name: "Pants", description: "For legs", imageUrl: "https://images.unsplash.com/photo-1714729382668-7bc3bb261662?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 500.0),
    const Cloth(name: "T-Shirt", description: "For upper body", imageUrl: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 200.0),
    const Cloth(name: "Jacket", description: "Outerwear for warmth", imageUrl: "https://images.unsplash.com/photo-1552327359-d86398116072?q=80&w=1063&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 1200.0),
    const Cloth(name: "Shorts", description: "Casual wear for legs", imageUrl: "https://images.unsplash.com/photo-1591195853828-11db59a44f6b?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 350.0),
    const Cloth(name: "Skirt", description: "For a chic look", imageUrl: "https://images.unsplash.com/photo-1646054224885-f978f5798312?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 450.0),
    const Cloth(name: "Sweater", description: "Warm upper body wear", imageUrl: "https://images.unsplash.com/photo-1541629007334-1f6c44705182?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 900.0),
    const Cloth(name: "Hoodie", description: "Casual and warm", imageUrl: "https://images.unsplash.com/photo-1542406775-ade58c52d2e4?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 800.0),
    const Cloth(name: "Blazer", description: "For formal occasions", imageUrl: "https://images.unsplash.com/photo-1591944489410-16ec1074a18e?q=80&w=1229&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 1500.0),
    const Cloth(name: "Dress", description: "One-piece outfit", imageUrl: "https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?q=80&w=988&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 1700.0),
    const Cloth(name: "Jeans", description: "Classic denim pants", imageUrl: "https://images.unsplash.com/photo-1517453802135-cfebc7c35cc0?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 600.0),
    const Cloth(name: "Cap", description: "Headwear for style", imageUrl: "https://images.unsplash.com/photo-1513105737059-ff0cf0580ae6?q=80&w=1176&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 150.0),
    const Cloth(name: "Scarf", description: "Accessory for neck", imageUrl: "https://images.unsplash.com/photo-1554865422-4f98f0735cbf?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 300.0),
    const Cloth(name: "Gloves", description: "Handwear for cold", imageUrl: "https://images.unsplash.com/photo-1644308977849-45a83bf3b067?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 250.0),
    const Cloth(name: "Boots", description: "Footwear for all terrains", imageUrl: "https://images.unsplash.com/photo-1605812860427-4024433a70fd?q=80&w=1035&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 2000.0),
    const Cloth(name: "Socks", description: "For foot comfort", imageUrl: "https://images.unsplash.com/photo-1505059152565-42971f574ade?q=80&w=1076&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 50.0),
    const Cloth(name: "Belt", description: "Accessory for pants", imageUrl: "https://images.unsplash.com/photo-1702374114952-22041fd8c880?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 400.0),
    const Cloth(name: "Tie", description: "Formal neckwear", imageUrl: "https://images.unsplash.com/photo-1506072590044-75de1b7b7806?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 350.0),
    const Cloth(name: "Coat", description: "Heavy outerwear", imageUrl: "https://images.unsplash.com/photo-1579967323563-49e0e7f33f98?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 2500.0),
    const Cloth(name: "Swimsuit", description: "For water activities", imageUrl: "https://images.unsplash.com/photo-1520065949650-380765513210?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 700.0),
    const Cloth(name: "Sneakers", description: "Casual footwear", imageUrl: "https://images.unsplash.com/photo-1465453869711-7e174808ace9?q=80&w=1176&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", price: 1000.0),
  ];

  void addCloth() {
    String name = "";
    String description = "";
    String imageUrl = "";
    double price = 0.0;

    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Add a New Cloth"),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Name"),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description",),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Image URL",),
                  onChanged: (value) {
                    imageUrl = value;
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Price",),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    price = double.tryParse(value) ?? 0.0;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog without adding
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (name.isNotEmpty && description.isNotEmpty && imageUrl.isNotEmpty && price > 0) {
                setState(() {
                  _clothes.add(Cloth(
                    name: name,
                    description: description,
                    imageUrl: imageUrl,
                    price: price,
                  ));
                });
                Navigator.pop(context); // Close dialog after adding
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields correctly")),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("211174"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Clothes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: ListView.builder(
              itemCount: _clothes.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        _clothes[index].imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(_clothes[index].name, style: const TextStyle(fontSize: 18),),
                      trailing: IconButton(icon: const
                      Icon(Icons.open_in_new), onPressed: () {
                        // Open new screen here with the details of the cloth
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ClothDetailsScreen(cloth: _clothes[index])));
                      },),
                    ),
                  );
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: addCloth,
        backgroundColor: Colors.amberAccent,
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}


class ClothDetailsScreen extends StatelessWidget {
  final Cloth cloth;
  const ClothDetailsScreen({super.key, required this.cloth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${cloth.name} details"),
        backgroundColor: Colors.amber
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              cloth.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              cloth.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Description:", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text(
              cloth.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 50),
            Text(
              "Price: \$${cloth.price.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    );
  }
}


