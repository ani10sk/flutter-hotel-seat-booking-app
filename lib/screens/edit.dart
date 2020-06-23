import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reservation.dart';

class Edit extends StatefulWidget{
  static const rout='edit';

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  var det={'seats':'','dob':'','mno':''};
  var iswaiting=false;
  @override
  Widget build(BuildContext context){
    final id=ModalRoute.of(context).settings.arguments as String;
    final form=GlobalKey<FormState>();
    void save(){
      form.currentState.save();
      if(form.currentState.validate()){
        setState(() {
          iswaiting=true;
        });
        try{
          Provider.of<Reservations>(context,listen:false).edit(id,det['dob'],det['seats'],det['mno']);
        }catch(error){
          showDialog(
          context:context,
          builder:(ctx)=>AlertDialog(
            title:Text('Error',style:TextStyle(fontWeight: FontWeight.bold)),
            content: Text('Editing not succesful please try again later'),
            actions: <Widget>[
              FlatButton(
                onPressed: ()=>Navigator.of(context).pop(), 
                child: Text('OK'))
            ],
          ));
        }
        setState(() {
          iswaiting=false;
        });
      }
    }
    return Scaffold(
      appBar:AppBar(
        title:Text('Edit booking')
      ),
      body: Form(
        key:form,
        child:Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children:[
              TextFormField(
                decoration:InputDecoration(
                  labelText:'Enter new seats booked'
                ),
                validator:(val){
                  if(val.isEmpty){
                    return 'Enter a valid number';
                  }
                  else{
                    return null;
                  }
                },
                onSaved:(val){
                  det['seats']=val;
                },
              ),
              TextFormField(
                decoration:InputDecoration(
                  labelText:'Enter the new booking date and time'
                ),
                validator:(val){
                  if(val.isEmpty){
                    return 'Enter a valid input';
                  }
                  else{
                    return null;
                  }
                },
                onSaved:(val){
                  det['dob']=val;
                },
              ),
              TextFormField(
                decoration:InputDecoration(
                  labelText:'Enter the new mobile no.'
                ),
                validator:(val){
                  if(val.isEmpty){
                    return 'Enter a valid input';
                  }
                  else{
                    return null;
                  }
                },
                onSaved:(val){
                  det['mno']=val;
                },
              ),
              SizedBox(height:40),
              iswaiting?CircularProgressIndicator():FlatButton(
                onPressed:save, 
                child:Text('Edit',style:TextStyle(fontSize:20)))
            ]
          ),
        ),
      ),
    );
  }
}