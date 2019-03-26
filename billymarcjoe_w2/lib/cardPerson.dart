import 'dart:math';

class CardPerson {
  
  String name;

  String img_url;

  CardPerson(String name, String img_url) {
    this.name = name;
    this.img_url = img_url;
}

}

class CardPersonManger {

  int counter = 0;

  List<CardPerson> cardPersons = new List();
  
  List<CardPerson> createCardPersons () {

    cardPersons.add(CardPerson("Jason", "Splash_1.jpg"));

    cardPersons.add(CardPerson("Joe", "Splash_2.jpg"));

    cardPersons.add(CardPerson("Billy", "Splash_3.jpg"));

    return cardPersons;
  }
   void createNewCardPerson(){
    cardPersons.add(CardPerson("New Guy"+counter.toString(),"Splash_4.jpg"));
    counter++;
  }
}