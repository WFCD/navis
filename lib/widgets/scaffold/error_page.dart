import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({Key key, this.exception}) : super(key: key);

  final dynamic exception;

  String parseException() {
    final _exception = exception.toString();

    return _exception.split(':').last.trimLeft();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme =
        Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 25);
    final worldstateBloc = BlocProvider.of<WorldstateBloc>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, size: 95, color: Colors.red),
          const SizedBox(height: 8.0),
          Text(
            'There was unexpected error.',
            textAlign: TextAlign.center,
            style: textTheme,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: const Text('Open issue'),
                color: Theme.of(context).primaryColor,
                onPressed: () {},
              ),
              RaisedButton(
                child: const Text('Retry'),
                color: Theme.of(context).primaryColor,
                onPressed: () => worldstateBloc.update(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
