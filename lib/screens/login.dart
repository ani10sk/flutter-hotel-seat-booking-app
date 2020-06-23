import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import './register.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          await Provider.of<Auth>(context,listen:false).authe(det['email'],det['password'],'signInWithPassword');
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
        title:Text('Login'),
        actions: <Widget>[
          InkWell(
            onTap:()=>Navigator.of(context).pushReplacementNamed(Register.rout),
            child: Container(
              width:80,
              alignment: Alignment.center,
              margin: EdgeInsets.all(5),
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(60),
                color: Colors.red
              ),
              child:Text('Register')
            ),
          )
        ],
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
                  textInputAction:TextInputAction.done,
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
                SizedBox(height:30),
                iswaiting?CircularProgressIndicator():FlatButton(
                  onPressed:save, 
                  child: Text(
                    'Login',style:TextStyle(fontSize:30,fontWeight:FontWeight.bold)
                  ))
              ]
            ),
          ),
        )),
    );
  }
}