import 'dart:convert';

class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? duration;
  String? lastPacketReceive;

  VpnStatus({
    this.byteIn,
    this.byteOut,
    this.duration,
    this.lastPacketReceive,
  });

  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
        byteIn: jsonData['byte_in'],
        byteOut: jsonData['byte_out'],
        duration: jsonData['duration'],
        lastPacketReceive: jsonData['last_packet_receive'],
      );

  Map<String, dynamic> toJson() => {
        'byte_in': byteIn,
        'byte_out': byteOut,
        'duration': duration,
        'last_packet_receive': lastPacketReceive,
      };
}
