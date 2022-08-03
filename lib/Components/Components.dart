// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:newsapp/Screens/WebViewScreen.dart';

Widget buildArticleItem(context,article)=>Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          NavigateTo(context, WebViewScreen("${article["url"]}"));
        },
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.30,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${article["urlToImage"]}'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                    Text(
                      '${article["title"]}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Published: ${article["publishedAt"].toString().substring(0,16).replaceAll('T', ' ')}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


Widget articleBuilder(list,{isSearch=false,itemCount=10}){
  return list.isEmpty
            ? (isSearch)?Container():Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(context,list[index]),
                separatorBuilder: (context, index) => Divider(),
                itemCount:itemCount);
}



Widget DefaultButton({
  double? height,
  required String text,
  required VoidCallback onpressed,
  double width = double.infinity,
  Color bgColor = Colors.red,
  double radius = 0.0,
}) =>
    Container(
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        // borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        onPressed: onpressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );


String emailPattern =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
    r"{0,253}[a-zA-Z0-9])?)*$";
String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp passwordRegEx = new RegExp(passwordPattern);
RegExp emailRegEx = RegExp(emailPattern);

Widget DefaultFormField({
  required TextEditingController controller,
  TextInputType kbtype = TextInputType.text,
  Color bordercolor = Colors.red,


  TextStyle? style ,
  Color? hintColor ,
  Color? lableColor ,
  String? label,
  Icon? prefixicon,
  String? hint,
  Widget? suffixicon,
  bool obscure = false,
  String? validate,
  Function(String)? onChanged,
  Function(String)? onsubmitted,
}) =>
    Container(
      width: double.infinity,
      // height: 50,
      child: TextFormField(
        // onFieldSubmitted:onsubmitted ,
        style: style,
        obscureText: obscure,
        validator: (value) {
          if (value!.isEmpty) {
            return "Field can't be empty";
          } else if (validate == 'email') {
            if (!emailRegEx.hasMatch(value))
              return 'Enter a valid email address';
          } else if (validate == 'Password') {
            if (!passwordRegEx.hasMatch(value))
              return 'Enter a valid Password ';
          }
        },
        controller: controller,
        keyboardType: kbtype,
        decoration: InputDecoration(
       
          hintStyle: TextStyle(color: hintColor),
          hintText: hint,
          labelStyle: TextStyle(color: lableColor),
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
          labelText: label,
          border: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // errorBorder: InputBorder.none,
        
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(25.0),
          //   borderSide: BorderSide(
          //     color: bordercolor,
          //   ),
          // ),
        ),

        onChanged: onChanged,
      
      ),
    );
void NavigateTo(context,widget){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}