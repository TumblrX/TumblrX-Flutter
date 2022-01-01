/*
Description: this class for create new tumblr for the same user
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/edit_blog_screen/edit.dart';
import 'package:tumblrx/models/user/user.dart';
class CreateNewTumblrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Controller for text field
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xff0c1b3b),
      appBar: AppBar(
          backgroundColor: Color(0xff0c1b3b),
          title: Text('Create a new Tumblr'),
          actions: [
            TextButton(
              ///function for create new blog 
                onPressed: () async {
                  await Provider.of<User>(context, listen: false)
                      .createNewlog(_controller.value.text, context);
                  ///return after creating to blog screen     
                  Navigator.pop(context);
                  ///show edit screen for user
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Edit()),
                  );
                },
                child: Text('Save'))
          ],
          elevation: 0.0),
      body: Center(
          child: Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: TextFormField(
                  controller: _controller,
                  onFieldSubmitted: (value){
                   
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      icon: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/avatar.png'))),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        ///if your pressed if (x) while clear 
                        onPressed: _controller.clear,
                      ),
                      hintText: 'name',
                      hintStyle: TextStyle(
                        color: Color(0xff665e5e),
                      ))))),
    );
  }
}
