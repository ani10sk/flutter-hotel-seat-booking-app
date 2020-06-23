import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './view_reservation.dart';
import '../providers/auth.dart';
import './reservations.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        title:Text('Home'),
        actions: <Widget>[
              InkWell(
                onTap:()=>Provider.of<Auth>(context,listen:false).logout(),
                child:SizedBox(
                  height:height/15,width:width/8,
                  child:Image.asset('assets/logout.jfif',fit:BoxFit.fill,)
                )
              )
            ] 
          ),
      body:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          Component('Make Reservation',1),
          Component('View Reservations',2)
        ],
      ),
    );
  }
}

class Component extends StatelessWidget {
  final String content;
  final double option;
  Component(this.content,this.option);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: option==1?()=>Navigator.of(context).pushNamed(MReservation.rout):option==2?()=>Navigator.of(context).pushNamed(ViewReservation.rout):(){},
      child: Container(
        alignment:Alignment.center,
        margin:EdgeInsets.all(10),
        padding:EdgeInsets.all(10),
        width:double.infinity,
        decoration:BoxDecoration(
          borderRadius:BorderRadius.circular(40),
          color:Colors.teal[200]
        ),
        child:Text(content,style:TextStyle(fontSize:30,fontWeight:FontWeight.bold))
      ),
    );
  }
}