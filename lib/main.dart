import 'package:flutter/material.dart';
import 'api_service.dart';

void main() => runApp(MyApp());

class Urls {
  static const BASE_API_URL = "https://jsonplaceholder.typicode.com";
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      title: 'Api Consume',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();

}
class _LoginState extends State<Login> {
  bool _isLoading = false;
  TextEditingController _usernameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Login'),),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Username'
              ),
              controller: _usernameController,
            ),
            Container(height: 20,),
            SizedBox(
              height: 40,
              width: double.infinity,
               child: RaisedButton(
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: () async {

                    setState(()
                    {
                      _isLoading = true;
                    }
                    );
                    final users = await ApiService.getUserList();
                     setState(()
                    {
                      _isLoading = false;
                    }
                    );
                    if(users == null){
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text("Check internet Connection"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },

                              )
                            ],
                          );
                        }
                      );
                      return;
                    } else {

                   final userWithUsernameExists = users.any((u) => u['username']
                    == _usernameController.text);
                      if(userWithUsernameExists){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Posts()
                          )
                          );
                      }else
                      {

                      }
                    }
                  },
                ),

            ),
          ],
        ),
      ),
    );
  }
}



class Posts extends StatelessWidget{
  @override
 Widget build(BuildContext context){
    return Scaffold(
      //floatingActionButton:FloatingActionButton(child: Icon(Icons.add), onPressed: () {
        // Navigator.push(context, MaterialPageRoute( builder: (context) => NewPost(),))}) ,
      appBar: AppBar(title: Text('Posts'),),
      body: FutureBuilder(
        future: ApiService.getPostList(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            final posts = snapshot.data;
            return ListView.separated(
              separatorBuilder: (context, index){
                return Divider(height: 2, color: Colors.black,);
              },
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(
                    posts[index]['title']!=null?posts[index]['title']:'Default Title',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),

                  ),
                  subtitle: Text(posts[index]['body']!=null?posts[index]['body']:'default value'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (contex) => Post(posts[index]['id']!=null?posts[index]['id']:'No id')
                                          )
                                          );
                                        },
                                      );
                                    },
                                    itemCount: posts.length,
                                  );
                                }
                                return Center(child: CircularProgressIndicator(),);

                              },
                            ),
                          );

                        }
                        }
class Post extends StatelessWidget{
  final int _id;

  Post(this._id);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Post'),),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: ApiService.getPost(_id),
            builder: (context, snapshot){
            // builder: (context, AsyncSnapshot snapshot){
              //if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                return Column(
                    children: <Widget>[
                      FutureBuilder(
                        future: ApiService.getPost(_id),

                        builder: (context , snapshot){
                           // future: Future.delayed(Duration(seconds: 3));
                          //if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasData){
                            return Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data['title']!=null?snapshot.data['title']:'Loading',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(snapshot.data['body']!=null?snapshot.data['body']:'No Data')
                              ],
                            );
                          }
                          else
                          {return Center(child: CircularProgressIndicator(),);}
                        },
                      ),

                      Container(height: 20,),
                      Divider(color: Colors.black, height: 3,),
                      Container(height: 20,),
                      FutureBuilder(
                        future: ApiService.getCommentsForPost(_id),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.done){
                            final comments = snapshot.data;
                            return Expanded(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) => Divider
                                  (height: 2, color: Colors.black,) ,
                                  itemBuilder: (context, index){
                                    return ListTile(
                                      title: Text(
                                        comments[index]['name']!=null?comments[index]['name']:'Loading',
                                        style: TextStyle(color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        comments[index]['body']!=null? comments[index]['body']:'No Comment'),
                                    );
                                  },
                                  itemCount: comments.length,
                              ),
                            );
                          } else
                          {return Center(child: CircularProgressIndicator(),);}
                        },
                      )
                    ],
                );
              }
              else
                          {return Center(child: CircularProgressIndicator(),);}
            },
          )
        ],
      ),
    );
  }
}
/*
class NewPost extends StatefulWidget{
  @override
  _NewPostState createtate() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  @override
  Widget build(BuildContext context){
    return Container();
  }
}
*/