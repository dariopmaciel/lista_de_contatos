import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lista_de_contatos/api.dart';

class ContactPad extends StatefulWidget {
  const ContactPad({super.key});

  @override
  State<ContactPad> createState() => _ContactPadState();
}

class _ContactPadState extends State<ContactPad> {
  List<Api>? _api = [];

  Future<List<Api>?> _getUser() async {
    http.Response response;
    var url1 = Uri.parse("https://jsonplaceholder.typicode.com/users");

    try {
      List<Api>? listUser = [];
      final response = await http.get(url1);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print("Erro ao carregar lista");
        return null;
      }
    } catch (e) {
      print("Erro ao carregar lista");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    


  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 50,
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          color: Colors.redAccent,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 40,
                    right: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.redAccent,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  "https://loremflickr.com/320/32$index"),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 150,
            right: 10,
            bottom: 10,
            left: 20,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height - 260,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: ((BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://loremflickr.com/320/32$index"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "NOme",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Endereço da pessoa que esta vindo me visitar ou que eu tenha contato",
                            style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("17:00"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                  color: index > 0 ? Colors.blue : null,
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  index != 0 ? "$index" : "",
                                  //"$index",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ]),
                    )
                  ],
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}

class $ {}
