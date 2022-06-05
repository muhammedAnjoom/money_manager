import 'package:flutter/material.dart';

class ExponesCategoryList extends StatelessWidget {
  const ExponesCategoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx,index){
        return Card(
          child: ListTile(
            title: Text('expens category \$index'),
            trailing: IconButton(onPressed: (){

            },
            icon: Icon(Icons.delete),
            ),
          ),
        );
      }, 
    separatorBuilder: (ctx,index){
      return const SizedBox(height: 10,);
    },
     itemCount: 10);
  }
}