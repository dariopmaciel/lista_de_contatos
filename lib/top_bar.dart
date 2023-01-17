import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lista_de_contatos/api.dart';
import 'package:http/http.dart' as http;

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  List<Api> _api = [];
  bool visual = false;

  Future<List<Api>?> _getUser() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users");

    try {
      List<Api> listUser = [];
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listUser.add(Api.fromJson(item)));
        return listUser;
      } else {
        print("Erro ao carregar lista" + response.statusCode.toString());
        return null;
      }
    } catch (e, stracktrace) {
      print("Erro ao carregar lista" + stracktrace.toString());
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser().then(
      (map) {
        _api = map!;
        visual = true;
        print("Quantidade de itens: ${_api.length}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        visual == false
            ? Container()
            : Stack(
                children: <Widget>[
                  Container(
                    height: 50,
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.redAccent,
                  ),
                ],
              ),
//LISTA HORIZONTAL
        Padding(
          padding: const EdgeInsets.only(top: 5),
          //PERFIL ARREDONDADO
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Status"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      //movimenta horizontamente
                      scrollDirection: Axis.horizontal,
                      itemCount: _api.length, //_api.lengt
                      itemBuilder: (BuildContext context, int index) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.redAccent,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 28,
                            backgroundImage: NetworkImage(
                                "https://loremflickr.com/320/32$index"),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
//LISTA VERTICAL
        Padding(
          padding:
              const EdgeInsets.only(top: 140, right: 10, bottom: 10, left: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            //color: Colors.red,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
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
                          children: <Widget>[
                            Text(
                              _api[index].name.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _api[index].address!.street.toString(),
                              style: const TextStyle(fontSize: 17),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
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
                                color: index != 0
                                    ? Colors.blueAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  index > 0 ? "$index" : "0",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
        )
      ],
    );
  }
}
