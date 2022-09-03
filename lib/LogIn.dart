import 'package:final_project/DBHelper.dart';
import 'package:final_project/SignUpScreen.dart';
import 'package:final_project/UserModel.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({required this.logIn,Key? key}) : super(key: key);
  final void Function(User?) logIn;

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

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
      body: SingleChildScrollView(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
            const Text(
              'Log In',
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
              child: TextFormField(obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                controller: passCont,
              ),
            ),
            SizedBox(height: 30),
            Text(warnText, style: warnStyle,),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                String name  = nameCont.text;
                String pass = passCont.text;

                if(name == '' || pass == ''){
                  setState((){
                    warnText = 'fill the fields';
                    warnStyle = TextStyle(color: Colors.red);
                    return;
                  });
                }

                User? user = await DataBaseHelper.instance.checkPassword(name, pass);
                if(user == null){
                  setState((){
                    warnText = "wrong password or user doesn't exist";
                    warnStyle = TextStyle(color: Colors.red);
                    return;
                  });
                }
                else{
                  print('fuck');
                  widget.logIn(user);
                }
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
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
    ),
    );
  }
}
