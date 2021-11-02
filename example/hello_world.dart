class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child:Text(
      'Hello, World!',
      style: Theme.of(context).textTheme.headline4,
    ) );
  }
}

