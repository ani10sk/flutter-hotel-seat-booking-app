import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';
import '../widgets/item.dart';

class ViewReservation extends StatefulWidget{
  static const rout='view-reservation';
  @override
  _ViewReservationState createState() => _ViewReservationState();
}

class _ViewReservationState extends State<ViewReservation> {
  List<Reservation> res=[];
  var isloading=false;
  var isinit=true;
  @override
  void didChangeDependencies() {
    if(isinit){
      setState(() {
        isloading=true;
      });
      Provider.of<Reservations>(context,listen:false).fetchAndSet().then((_){
        setState((){
          isloading=false;
        });
      });
    }
    isinit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context){
    final res=Provider.of<Reservations>(context,listen:true).reservations;
    return Scaffold(
      appBar: AppBar(
        title:Text('View reservations made')
      ),
      body:isloading?Center(child: CircularProgressIndicator()):
      res.length==0?Column(children: <Widget>[Center(child:Text('You have not made any reservation so far',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)))],):
      ListView.builder(
        itemBuilder:(ctx,i)=>Item(res[i]),
        itemCount:res.length,),//SizedBox()
    );
  }
}