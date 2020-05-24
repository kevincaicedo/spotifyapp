class Resource<T> {
  Resource({this.data, this.status, this.message});

  T data;
  StatusResource status;
  MessageResource message;
}

enum StatusResource { OK, FAIL, DEFAULT }

abstract class MessageResource {
  final String text = "";
}

class NetworkError implements MessageResource {
  @override
  String get text =>
      "An error occurred in the network please validate your connection";
}

class UnknowError implements MessageResource {
  @override
  String get text => "An Unknow error occurred";
}

class UnauthorizedError implements MessageResource {
  @override
  String get text => "Unauthorized You need refresh your token";
}

class OkMessage implements MessageResource {
  @override
  String get text => "Ok";
}

class CustomMessage implements MessageResource {
  String _message;
  CustomMessage({message}) {
    this._message = message;
  }

  @override
  String get text => this._message;
}
