library default_connector;

import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

class DefaultConnector {
  // Configuration for the connector
  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1', // Region
    'default', // Type or environment (e.g., development)
    'truyou', // Your project name
  );

  DefaultConnector({required this.dataConnect});

  // Singleton pattern for DefaultConnector
  static DefaultConnector get instance {
    return DefaultConnector(
      dataConnect: FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
      ),
    );
  }

  // FirebaseDataConnect instance
  FirebaseDataConnect dataConnect;
}
