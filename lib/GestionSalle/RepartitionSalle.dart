import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'GestionSalle.dart';

class RepertitionSalle extends StatefulWidget {
  const RepertitionSalle({super.key});

  @override
  State <RepertitionSalle> createState() =>  RepertitionSalleState();
}

class  RepertitionSalleState extends State <RepertitionSalle> {
  @override
  Widget build(BuildContext context) {
    return MainScreenRoom ();
  }
}