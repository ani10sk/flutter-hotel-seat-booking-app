import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class Register extends StatefulWidget{
  static const rout='register';
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var iswaiting=false;
  @override
  Widget build(BuildContext context){
    var det={'email':'','password':''};
    final form=GlobalKey<FormState>();
    void save()async{
      form.currentState.save();
      if(form.currentState.validate()){
        try{
          setState(() {
            iswaiting=true;
          });
          await Provider.of<Auth>(context,listen:false).authe(det['email'],det['password'],'signUp');
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
        title:Text('Sign Up'),
      ),
      body: Form(
        key: form,
        child:Padding(
          padding:EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children:[
                SizedBox(height:60,),
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
                    det['email']=value;
                  }
                    

                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Enter your password'
                  ),
                  obscureText: true,
                  textInputAction:TextInputAction.next,
                  validator:(val){
                    if(val.isEmpty){
                      return 'Enter a valid password';
                    }else{
                      return null;
                    }
                  },
                  onSaved:(value){
                    det['password']=value;
                  },
                ),
                TextFormField(
                  decoration:InputDecoration(
                    labelText:'Re enter your password'
                  ),
                  obscureText: true,
                  textInputAction:TextInputAction.done,
                  validator:(val){
                    if(val==det['password']){
                      return null;
                    }else{
                      return 'Passwords do not match';
                    }
                  },
                  onSaved:(value){
                    det['password']=value;
                  },
                ),
                SizedBox(height:30),
                iswaiting?CircularProgressIndicator():FlatButton(
                  onPressed:save, 
                  child: Text(
                    'Sign Up',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold)
                  ))
              ]
            ),
          ),
        )),
    );
  }
}