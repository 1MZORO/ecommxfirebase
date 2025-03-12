import 'package:ecomxfirebase/Provider_Global/UserDataProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? checkUser(){
  return FirebaseAuth.instance.currentUser?.email;
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> categories = [
    {"name": "Hoodies", "image": "assets/img/hoodie.png"},
    {"name": "Shorts", "image": "assets/img/shorts.png"},
    {"name": "Shoes", "image": "assets/img/shoes.png"},
    {"name": "Bag", "image": "assets/img/bag.png"},
    {"name": "Accessories", "image": "assets/img/accessorie.png"},
  ];

  final List<Map<String, String>> topSelling = [
    {"image": "assets/img/jacket.png", "price": "\$148.00"},
    {"image": "assets/img/sleeper.png", "price": "\$55.00"},
    {"image": "assets/img/jacket.png", "price": "\$60.00"},
    {"image": "assets/img/jacket.png", "price": "\$120.00"},
  ];
  late final userId ;
  final user = checkUser();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    final TextEditingController searchClt = TextEditingController();
    final size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Icon(Icons.menu),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18, top: 15),
            child: Image.asset(
              'assets/icons/img.png',
              height: 50,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: searchClt,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  fillColor: Colors.grey.shade100,
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 150,
                child: CarouselView(
                  itemExtent: size.width - 32,
                  padding: EdgeInsets.zero,
                  children: List.generate(6, (int index) {
                    String? url = 'https://picsum.photos/700?random=$index';
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => DetailScreen(url: url),
                        //   ),
                        // );
                      },
                      child: Image.network(
                         url,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) => const Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        // errorWidget: (context, url, error) =>
                        // const Center(child: Icon(Icons.broken_image, size: 50)),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("See All", style: TextStyle(fontSize: 14, color: Colors.blue)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    // log(provider.userData.toString());
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: Image.asset(categories[index]['image']!, height: 40),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(categories[index]['name']!, style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Image.network('https://res.cloudinary.com/zoro1/image/upload/v1741098898/ohrbcsckhygige08rrqg.jpg'),

              SizedBox(height: 20),

              _showProducts()

            ],
          ),
        ),
      ),
    );
  }
  Widget _showProducts(){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemCount: topSelling.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(topSelling[index]['image']!, height: 170, width: double.infinity, fit: BoxFit.fill),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(Icons.favorite_border, color: Colors.black),
                  ),
                ],
              ),
              // SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  topSelling[index]['price']!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}
