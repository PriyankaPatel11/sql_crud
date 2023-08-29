import 'package:flutter/material.dart';
import 'package:sql_crud/show_details.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<ShowDetails> details = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter Your Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String password = passwordController.text.trim();
                    if (name.isNotEmpty && password.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        passwordController.text = '';     
                        details.add(ShowDetails(name: name, password: password));
                      });
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String password = passwordController.text.trim();
                    if(name.isNotEmpty && password.isNotEmpty){
                      setState(() {
                        nameController.text = '';
                        passwordController.text = '';
                        details[selectedIndex].name = name;
                        details[selectedIndex].password = password;
                        selectedIndex = -1;
                      });
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            details.isEmpty
                ? const Text(
                    "No Details yet....",
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                      child: ListView.builder(
                        itemCount: details.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),

                     )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
            index % 2 == 0 ? Colors.deepPurpleAccent: Colors.purple,
          foregroundColor: Colors.white,
          child: Text(details[index].name[0],
          style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(details[index].name, 
              style: const TextStyle(
              fontWeight: FontWeight.bold),
            ),
            Text(details[index].password),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                onTap: ((){
                  nameController.text = details[index].name;
                  passwordController.text = details[index].password;
                  setState(() {
                    selectedIndex = index;
                  },
                  );
                }),
                  child: const Icon(Icons.edit)),
              const SizedBox(width: 12,),
              InkWell(
                onTap: ((){
                  setState(() {
                    details.removeAt(index);
                  });
                }),
                  child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
