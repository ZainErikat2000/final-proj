import 'package:final_project/UserModel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({required this.user,required this.logOut, Key? key}) : super(key: key);
  final User? user;
  final void Function() logOut;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = <Widget> [Center(child: Text('''
  User: ${widget.user?.name}
  ID: ${widget.user?.id}
  ''',style: TextStyle(fontWeight: FontWeight.bold)),),
      Center(child: Text('events',style: TextStyle(fontWeight: FontWeight.bold)),),
      Center(child: Text('here add events',style: TextStyle(fontWeight: FontWeight.bold),))];

    return Scaffold(body: tabs[currentIndex],
      appBar: AppBar(
        centerTitle: true,
        leading: FittedBox(child: TextButton(
          child: Text(
            'Log Out',
            style: TextStyle(color: Colors.white,fontSize: 24),
          ),
          onPressed: widget.logOut,
        ),),
        title: Text('Final Project'),
      ),
      bottomNavigationBar: BottomNavigationBar(type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled_outlined),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Event',
          ),
        ],
      onTap: (index) {
          print(index);
        setState(() {currentIndex = index;});

      },),
    );
  }
}
