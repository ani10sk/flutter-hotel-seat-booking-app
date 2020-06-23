import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/login.dart';
import './screens/register.dart';
import './providers/auth.dart';
import './screens/home.dart';
import './providers/reservation.dart';
import './screens/reservations.dart';
import './screens/view_reservation.dart';
import './screens/edit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth()),
        ChangeNotifierProxyProvider<Auth,Reservations>(
          update: (ctx, auth, previousReservations) => Reservations(
                auth.token,
                auth.userId,
              ),
        ),  
      ],
      child: Consumer<Auth>(
        builder:(ctx,auth,_)=> MaterialApp(
          debugShowCheckedModeBanner:false,
          title: 'Booking app',
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.token!=null?Home():Login(),
          routes: {
            Register.rout:(ctx)=>Register(),
            MReservation.rout:(ctx)=>MReservation(),
            ViewReservation.rout:(ctx)=>ViewReservation(),
            Edit.rout:(ctx)=>Edit(),
          },
        ),
      ),
    );
  }
}
