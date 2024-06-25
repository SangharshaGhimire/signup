import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> Itemname = ["Fast food", "Vegetarian", "Cafe", "Buffet"];
  List<Food> fooditem = [
    Food(
        name: "Sandar Momo",
        image: "assets/images/momo.jpg",
        distance: "0.5 km",
        rating: "4.9"),
    Food(
        name: "Bajeko Sekuwa",
        image: "assets/images/baje.jpg",
        distance: "1.5 km",
        rating: "4.8"),
    Food(
        name: "Subway",
        image: "assets/images/subway.jpg",
        distance: "2.0 km",
        rating: "4.5"),
    Food(
        name: "Vip",
        image: "assets/images/kurkure-momos.jpg",
        distance: "0.5 km",
        rating: "4.9")
  ];
  List<Popular> popularList = [
    Popular(
        Mainname: "McDonald's",
        name: "Burger",
        rating: "4.4",
        distance: "1 KM",
        delivery: "Free Delivary",
        time: "20m",
        image: "assets/images/mc.jpg"),
    Popular(
        Mainname: "Burger House",
        name: "Burger & Fast food",
        rating: "4.0",
        distance: "1 KM",
        delivery: "Free Delivary",
        time: "20m",
        image: "assets/images/burg.jpg"),
    Popular(
        Mainname: "Central Peak",
        name: "Bakery & Cake",
        rating: "3.9",
        distance: "0.5 KM",
        delivery: "Free Delivary",
        time: "15m",
        image: "assets/images/central.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Hi,Sangharsha",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text("   Panauti 8, Nepal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.grey))
                    ],
                  ),
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/images/searchs.jpg")),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Itemname.length,
                  itemBuilder: (context, index) => Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "${Itemname[index]}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ],
                      )),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Recommended",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: fooditem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: SizedBox(
                              height: 110,
                              width: 110,
                              child: Image.asset(
                                "${fooditem[index].image}",
                                fit: BoxFit.cover,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "${fooditem[index].name}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${fooditem[index].distance}"),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("."),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text("${fooditem[index].rating}"),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 300,
              width: 400,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: popularList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "${popularList[index].image}",
                                  width: 110,
                                  height: 110,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${popularList[index].Mainname}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        Text("${popularList[index].rating}"),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            ".",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                              "${popularList[index].name}"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${popularList[index].time}"),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text("."),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                "${popularList[index].distance}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.bike_scooter),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                "${popularList[index].delivery}"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
            )
          ],
        ),
      )),
    );
  }
}

class Food {
  String? image, name, distance, rating;
  Food({this.image, this.distance, this.name, this.rating});
}

class Popular {
  String? image, name, distance, rating, delivery, Mainname, time;
  Popular(
      {this.image,
      this.distance,
      this.name,
      this.rating,
      this.Mainname,
      this.delivery,
      this.time});
}
