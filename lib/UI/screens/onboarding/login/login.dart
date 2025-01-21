import 'package:expense_app/data/local/db/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../expenses.dart';
import '../register/register.dart';

class loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController unameController = TextEditingController();
    TextEditingController pwordController = TextEditingController();
    DBHelper dbHelper = DBHelper.getInstance();

    return Scaffold(
      body:
      SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("lib/domain/app/assets/images/bg.png"),fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/domain/app/assets/images/icon.png",
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      "Monety",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30, vertical: 10),
                      child: Column(
                        children: [
                          Text("Login", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,),),
                          Text.rich(TextSpan(text: "Don't have an account?  ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                              children: [TextSpan(text: "Sign Up", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),recognizer: TapGestureRecognizer()
                                ..onTap = ()  {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  register(),
                                    ),
                                  );
                                })])
                          ),
                          SizedBox(height: 20,),
                          Align(alignment:Alignment.centerLeft, child: Text("User Email", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: unameController,
                            decoration: InputDecoration(
                              hintText: "Enter your Email",
                              hintStyle: TextStyle(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(11)),
                                  borderSide: BorderSide(
                                    color: Color(0xffdfd3d3),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(11)),
                                  borderSide: BorderSide(
                                    color: Color(0xffdfd3d3),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Align(alignment:Alignment.centerLeft, child: Text("Password", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: pwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              hintText: "Enter your Password",
                              hintStyle: TextStyle(color: Colors.grey),
                              suffixIcon: Icon(Icons.visibility_off,color: Colors.grey,),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(11)),
                                  borderSide: BorderSide(
                                    color: Color(0xffdfd3d3),
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(11)),
                                  borderSide: BorderSide(
                                    color: Color(0xffdfd3d3),
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("     ",style: TextStyle(fontSize: 15, color: Colors.grey,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                              Text("Forgot Password?",style: TextStyle(fontSize: 15, color: Colors.blueAccent,fontWeight: FontWeight.w600),textAlign: TextAlign.left,)
                            ],
                          ),
                          SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(11.0),
                                ),
                              ),
                              onPressed: () async {
                                 bool auth_login = await dbHelper.authenticate_login(email: unameController.text, password: pwordController.text);

                                 if(auth_login) {
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                       content:
                                       Text("User Logged-in successfully!!")));

                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ExpensePage()));
                                 }
                                 else {
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                       content:
                                       Text("Invalid Email or Password.")));
                                 }

                              },
                              child: Text("Log In", style: TextStyle(color: Colors.white, fontSize: 20),),),
                          ),
                          SizedBox(height: 15,),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Divider(color: Colors.grey.shade200,)),
                                SizedBox(width: 15,),
                                Text("Or"),
                                SizedBox(width: 15,),
                                Expanded(child: Divider(color: Colors.grey.shade200,)),
                              ],
                            ),
                          ),
                          SizedBox(height: 15,),
                          Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(11.0),
                                      side: BorderSide(color: Colors.grey.shade200)
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>  register(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.assignment_ind, color: Colors.blueAccent,),
                                    Text(" Create Account ", style: TextStyle(color: Colors.black, fontSize: 17),),
                                  ],
                                ),
                              )
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}