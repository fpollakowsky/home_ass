/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/05/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:home_ass/utils/res/global.dart';

final client = MqttServerClient(valIP, '');

Future<int> publishMQTT(String topic,String room, String message) async {
  client.logging(on: false);
  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  final connMess = MqttConnectMessage()
      .withClientIdentifier(Random().nextInt(100000).toString())
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;
  try {
    await client.connect();
  } on Exception catch (e) {
    DEBUG ?? print('MQTT:: Client exception - $e');
    client.disconnect();
  }

  String pubTopic = "/$room/$topic/";
  DEBUG ?? print("MQTT:: Topic: $pubTopic");
  final builder = MqttClientPayloadBuilder();
  builder.addString(message);
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);
  return 1;
}

void onDisconnected() {
  if (client.connectionStatus.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
  }
}

void onConnected() {
  DEBUG ?? print('MQTT:: Status: Connected');
}