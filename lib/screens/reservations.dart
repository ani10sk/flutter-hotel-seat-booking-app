import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';

class MReservation extends StatefulWidget{
  static const rout='makereservation';

  @override
  _MReservationState createState() => _MReservationState();
}

class _MReservationState extends State<MReservation> {
  var iswaiting=false;
  @override
  Widget build(BuildContext context){
    var res=Reservation(
      creatorid:'',
      id:DateTime.now().toIso8601String(),
      mno:'',
      email:'',
      dob:'',
      seats:'',
      time:''
    );
    final form=GlobalKey<FormState>();
    void save()async{
      form.currentState.save();
      if(form.currentState.validate()){
        try{
          setState(() {
            iswaiting=true;
          });
          await Provider.of<Reservations>(context,listen:false).makeRes(res);
          setState(() {
            iswaiting=false;
          }); 
        }catch(error){
          print('error');
          showDialog(
          context:context,
          builder:(ctx)=>AlertDialog(
            title:Text('Error',style:TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Reservation not succesful,try again later'),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=>Navigator.of(context).pop(), 
                child: Text('OK'))
            ],
          ));
        }
      }
    }
    return Scaffold(
      appBar:AppBar(
        title:Text('Make Reservation')
      ),
      body: Form(
        key: form,
        child:Padding(
          padding:EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children:[
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter your email id'
                  ),
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.contains('@email.com')){
                      return null;
                    }
                    else{
                      return 'Enter an email id that ends @email.com';
                    }
                  },
                  onSaved:(value){
                    res=Reservation(
                      creatorid:res.creatorid,
                      id:res.id,
                      mno:res.mno,
                      email:value,
                      dob:res.dob,
                      seats:res.seats,
                      time: res.time
                    );
                  },
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter your mobile no.'
                  ),
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.length<10){
                      return 'Enter valid mobile no.';
                    }else{
                      return null;
                    }
                  },
                  onSaved:(value){
                    res=Reservation(
                      creatorid:res.creatorid,
                      id:res.id,
                      mno:value,
                      email:res.email,
                      dob:res.dob,
                      seats:res.seats,
                      time:res.time
                    );
                  },
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter your DOB in dd/mm/yy format'
                  ),
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.isEmpty){
                      return 'Enter a date of birth';
                    }else{
                      return null;
                    }
                  },
                  onSaved:(value){
                    res=Reservation(
                      creatorid:res.creatorid,
                      id:res.id,
                      mno:res.mno,
                      email:res.email,
                      dob:value,
                      seats:res.seats,
                      time:res.time
                    );
                  },
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter date and time in dd/mm/yy hh:mm'
                  ),
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.isEmpty){
                      return 'Enter a valid date time';
                    }else{
                      return null;
                    }
                  },
                  onSaved:(value){
                    res=Reservation(
                      creatorid:res.creatorid,
                      id:res.id,
                      mno:res.mno,
                      email:res.email,
                      dob:res.dob,
                      seats:res.seats,
                      time:value
                    );
                  },
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter the no. of seats you wish to book'
                  ),
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.isEmpty){
                      return 'Enter a number';
                    }else{
                      return null;
                    }
                  },
                  onSaved:(value){
                    res=Reservation(
                      creatorid:res.creatorid,
                      id:res.id,
                      mno:res.mno,
                      email:res.email,
                      dob:res.dob,
                      seats:value,
                      time:res.time
                    );
                  },
                ),
                SizedBox(height:30),
                iswaiting?CircularProgressIndicator():FlatButton(
                  onPressed:save, 
                  child: Text(
                    'SUBMIT',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold)
                  ))
              ]
            ),
          ),
        )),
    );
  }
}