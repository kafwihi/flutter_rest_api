import 'dart:convert';
import 'package:flutter_rest_api/main.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
class ApiService{

  static Future<dynamic> _get(String url) async{
    try{
      final response = await http.get(url);
      if(response.statusCode == 200){
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch(ex){
      return null;
    }
  }



  static Future<List<dynamic>> getUserList() async{
   return await _get('${Urls.BASE_API_URL}/users');
   }

   static Future<List<dynamic>> getPostList() async{
   return await _get('https://jsonplaceholder.typicode.com/posts');
   }

   static Future<dynamic> getPost(int postId) async{
   return await _get('https://jsonplaceholder.typicode.com/posts/$postId');
   }
   static Future<dynamic> getCommentsForPost(int postId) async{
   return await _get('https://jsonplaceholder.typicode.com/users');
   }
static Future<bool> addPost(Map<String, dynamic> post) async{

  try{
         final response = await http.post('https://jsonplaceholder.typicode.com/posts',body:post);
          return response.statusCode == 201;
  }catch(e){
        return false;
  }
   }
}