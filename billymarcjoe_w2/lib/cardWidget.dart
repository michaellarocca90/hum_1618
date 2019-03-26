import 'package:flutter/material.dart';
import 'cardPerson.dart';



class CardWidget extends StatefulWidget{

  @override
  State createState(){
    return CardWidgetState();
  }
}

class CardWidgetState extends State<CardWidget>{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: _buildCardWidget(),

      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCardWidget,

        child:Icon(Icons.add),


      ),


    );

  }

  void _addNewCardWidget(){

    setState(() {
      manager.createNewCardPerson();
      
    });

    
  }

  Widget _buildCardWidget(){

    return ListView.builder(

      itemBuilder: (context, i) {

        final index = i % persons.length;

        print(i);
        return _buildCardItem(persons[index]);
      }
    );
  }
    static CardPersonManger manager = CardPersonManger();
    List<CardPerson> persons = manager.createCardPersons();


    Widget _buildCardItem(CardPerson person){

      return Align(alignment: Alignment.center,
        child:Column(
          children: <Widget>[
            Text(person.name),
            Image.asset(person.img_url),
          ],
        ));


    }

}