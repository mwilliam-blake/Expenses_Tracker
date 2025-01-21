import 'package:expense_app/data/local/db/db_helper.dart';
import 'package:expense_app/data/local/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../expenses.dart';

class register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController unameController = TextEditingController();
    TextEditingController pwordController = TextEditingController();
    TextEditingController conf_pwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController mobController = TextEditingController();
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
                SizedBox(height: 10,),
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
                SizedBox(height: 20,),
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
                          Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30,),),
                          Text.rich(TextSpan(text: "Already have an account?  ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),
                              children: [TextSpan(text: "Login", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500), recognizer: TapGestureRecognizer()
                                ..onTap = ()  {
                                  Navigator.pop(
                                    context
                                  );
                                })])
                          ),
                          SizedBox(height: 20,),
                          Align(alignment:Alignment.centerLeft, child: Text("Username", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: unameController,
                            decoration: InputDecoration(
                              hintText: "Enter your Username",
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
                          Align(alignment:Alignment.centerLeft, child: Text("Confirm Password", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: conf_pwordController,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              hintText: "Enter your Password Again",
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
                          Align(alignment:Alignment.centerLeft, child: Text("Email", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter your Email Address",
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
                          Align(alignment:Alignment.centerLeft, child: Text("Mobile Number", style: TextStyle(fontSize: 17, color: Colors.grey,),textAlign: TextAlign.left,)),
                          TextField(
                            controller: mobController,
                            decoration: InputDecoration(
                              hintText: "Enter your Mobile Number",
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
                          SizedBox(height: 25,),
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
                                 if(!await dbHelper.check_email_exists(email: emailController.text)) {
                                    UserModel New_user = UserModel(uname: unameController.text, passwd: pwordController.text, email: emailController.text, mobile: mobController.text, created_at: DateTime.now().microsecondsSinceEpoch.toString());

                                    bool check_register = await dbHelper.store_user_details(User: New_user);

                                    if(check_register) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Registered Successfully. Please login now. ")));
                                      Navigator.pop(context);
                                    }
                                    else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong. Please try again later. ")));
                                      Navigator.pop(context);
                                    }
                                 }
                                 else {
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email already exists. Please login now.")));
                                   Navigator.pop(context);
                                 }
                              },
                              child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20),),),
                          ),
                          SizedBox(height: 25,),
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