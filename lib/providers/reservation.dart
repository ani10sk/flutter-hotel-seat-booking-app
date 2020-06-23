import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reservation{
  final String creatorid;
  final String id;
  final String mno;
  final String email;
  final String dob;
  final String seats;
  final String time;
  final String isConfirmed;
  Reservation({
    this.creatorid,
    this.id,
    this.mno,
    this.email,
    this.dob,
    this.seats,
    this.time,
    this.isConfirmed
  });
}

class Reservations extends ChangeNotifier{
  List<Reservation> reservations=[];
  final String userid;
  final String token;
  Reservations(this.token,this.userid);
   Future<void> makeRes(Reservation res)async{
     final url='https://shop-5c954.firebaseio.com/reservation.json?auth=$token';
     try{
       final response=await http.post(
         url,body:json.encode({
           'creatorid':userid,
           'id':res.id,
           'mno':res.mno,
           'email':res.email,
           'dob':res.dob,
           'seats':res.seats,
           'time':res.time,
           'isConfirmed':'0'
         })
       );
       final String id=json.decode(response.body)['name'];
       final url1='https://shop-5c954.firebaseio.com/reservation/$id.json?auth=$token';
       await http.put(
         url1,body:json.encode({
           'creatorid':userid,
           'id':id,
           'mno':res.mno,
           'email':res.email,
           'dob':res.dob,
           'seats':res.seats,
           'time':res.time,
           'isConfirmed':'0'
         })
       );
       print(json.decode(response.body)['name']);
     }catch(error){
       print(error);
     }
   }

   Future<void> fetchAndSet()async{
     reservations=[];
     final url='https://shop-5c954.firebaseio.com/reservation.json?auth=$token';
     try{
       final response=await http.get(url);
       final extractedProduct=json.decode(response.body) as Map<String,dynamic>;
       final reservationss=[];
       extractedProduct.forEach((rid,rdata) {
        reservationss.add(Reservation(
           creatorid:rdata['creatorid'],
           id:rdata['id'],
           mno:rdata['mno'],
           email:rdata['email'],
           dob:rdata['dob'],
           seats:rdata['seats'],
           time:rdata['time'],
           isConfirmed:rdata['isConfirmed']
         ));
       });
       for(int i=0;i<reservationss.length;i++){
         if(reservationss[i].creatorid==userid){
           reservations.add(reservationss[i]);
         }
       }
       notifyListeners();
     }catch(error){
       print('errorr');
     }
   }

   Future<void> edit(String id,String dob,String seats,String mno)async{
     int no;
     for(int i=0;i<reservations.length;i++){
       if(reservations[i].id==id){
         no=i;
         reservations[i]=Reservation(
           creatorid:reservations[i].creatorid,
           id:reservations[i].id,
           mno:mno,
           email:reservations[i].email,
           dob:reservations[i].dob,
           seats:seats,
           time:dob
         );
       }
     }
     notifyListeners();
     final url1='https://shop-5c954.firebaseio.com/reservation/$id.json?auth=$token';
     try{
       final response=await http.put(
         url1,body:json.encode({
           'creatorid':reservations[no].creatorid,
           'id':reservations[no].id,
           'mno':reservations[no].mno,
           'email':reservations[no].email,
           'dob':reservations[no].dob,
           'seats':reservations[no].seats,
           'time':reservations[no].time,
           'isConfirmed':reservations[no].isConfirmed
         })
       );
       print(response.body);
     }catch(error){
       print('errror');
     }
   }

   Future<void> delete(String id)async{
     final url='https://shop-5c954.firebaseio.com/reservation/$id.json?auth=$token';
     try{
       await http.delete(url);
     }catch(error){
       print('derror');
     }
     for(int i=0;i<reservations.length;i++){
       if(reservations[i].id==id){
        reservations.removeAt(i);
       }
     }
     notifyListeners();
   }
}