// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ToldAPI {
  class DebugWidgetQuery: GraphQLQuery {
    static let operationName: String = "DebugWidget"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"query DebugWidget($id: ID!, $type: String, $hostname: String, $port: String) { debugWidget(id: $id, type: $type, hostname: $hostname, port: $port) }"#
      ))

    public var id: ID
    public var type: GraphQLNullable<String>
    public var hostname: GraphQLNullable<String>
    public var port: GraphQLNullable<String>

    public init(
      id: ID,
      type: GraphQLNullable<String>,
      hostname: GraphQLNullable<String>,
      port: GraphQLNullable<String>
    ) {
      self.id = id
      self.type = type
      self.hostname = hostname
      self.port = port
    }

    public var __variables: Variables? { [
      "id": id,
      "type": type,
      "hostname": hostname,
      "port": port
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ToldAPI.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("debugWidget", String?.self, arguments: [
          "id": .variable("id"),
          "type": .variable("type"),
          "hostname": .variable("hostname"),
          "port": .variable("port")
        ]),
      ] }

      var debugWidget: String? { __data["debugWidget"] }
    }
  }

}