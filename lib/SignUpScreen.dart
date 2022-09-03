import 'package:final_project/DBHelper.dart';
import 'package:final_project/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController passRCont = TextEditingController();
  String warnText = '';
  TextStyle warnStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            //name field
            SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: nameCont,
              ),
            ),
            //pass field
            SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: passCont,
              ),
            ),
            SizedBox(
              width: 300,
              height: 40,
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Repeat Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: passRCont,
              ),
            ),
            Text(
              warnText,
              style: warnStyle,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                String name = nameCont.text;
                String pass = passCont.text;
                String passr = passRCont.text;

                if (name == '' || pass == '' || passr == '') {
                  setState(() {
                    warnText = 'fill the fields';
                    warnStyle = TextStyle(color: Colors.red);
                  });
                  return;
                }

                if (pass != passr) {
                  setState(() {
                    warnText = "password doesn't match";
                    warnStyle = TextStyle(color: Colors.red);
                  });
                  return;
                }

                //insert user to database
                int id = await DataBaseHelper.instance.getUsersCount();
                Database? db = await DataBaseHelper.instance.database;

                User user = User(id: id, name: name, password: pass);

                await DataBaseHelper.instance.insertUser(user);


                setState(() {
                  warnText = "You Signed Up";
                  warnStyle = TextStyle(color: Colors.green);
                });
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }

}
