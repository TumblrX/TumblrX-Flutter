import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumblrx/components/edit_blog_screen/edit.dart';
import 'package:tumblrx/models/user/user.dart';

class CreateNewTumblrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = new TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xff0c1b3b),
      appBar: AppBar(
          backgroundColor: Color(0xff0c1b3b),
          title: Text('Create a new Tumblr'),
          actions: [
            TextButton(
                onPressed: () async {
                  await Provider.of<User>(context, listen: false)
                      .createNewlog(_controller.value.text, context);

                  Navigator.pop(context);
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
                  onFieldSubmitted: (value) async {
                    await Provider.of<User>(context, listen: false)
                        .createNewlog(value, context);

                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Edit()),
                    );
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
                        onPressed: _controller.clear,
                      ),
                      hintText: 'name',
                      hintStyle: TextStyle(
                        color: Color(0xff665e5e),
                      ))))),
    );
  }
}
