import 'package:bluppi/generated/party.pb.dart' as proto;

class ServerResponse {
  final int serverReceiveUs;
  final int serverSendUs;

  ServerResponse({
    required this.serverReceiveUs,
    required this.serverSendUs,
  });

  factory ServerResponse.fromProto(proto.SyncResponse response) {
    return ServerResponse(
      serverReceiveUs: response.serverReceiveUs.toInt(),
      serverSendUs: response.serverSendUs.toInt(),
    );
  }
}