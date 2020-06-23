import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';
import '../screens/edit.dart';

class Item extends StatelessWidget{
  final Reservation res;
  Item(this.res);
  @override
  Widget build(BuildContext context){
    void alert(){
      showDialog(
          context:context,
          builder:(ctx)=>AlertDialog(
            title:Text('Error',style:TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Make sure you typed the right password for the admin app'),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=>Navigator.of(context).pop(), 
                child: Text('OK'))
            ],
          ));
    }
    return Container(
      decoration:BoxDecoration(
        color:Colors.purpleAccent,
        borderRadius:BorderRadius.circular(10)
      ),
      margin:EdgeInsets.all(10),
      padding:EdgeInsets.all(10),
      child:SizedBox(
        width:MediaQuery.of(context).size.width-40,
        child: Row(
          children:[
            Text(res.seats,style:TextStyle(fontSize:15,fontWeight:FontWeight.bold),),
            SizedBox(width:20,),
            Text(res.dob),
            Expanded(child:SizedBox(),),
            IconButton(
              icon: Icon(res.isConfirmed=='1'?Icons.check_circle :Icons.edit),
              onPressed:()=>res.isConfirmed=='1'?alert:
              Navigator.of(context).pushNamed(Edit.rout,arguments:res.id),
            ),
            IconButton(
              icon: Icon(Icons.delete), 
              onPressed:()=>Provider.of<Reservations>(context,listen:false).delete(res.id))
          ]
        ),
      )
    );
  }
}