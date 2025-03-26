// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ToldAPI {
  class CheckIfAppIsAllowedQuery: GraphQLQuery {
    static let operationName: String = "CheckIfAppIsAllowed"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"query CheckIfAppIsAllowed($sourceId: ID!, $host: ClientAppWebInput, $mobile: ClientAppMobileInput) { checkIfAppIsAllowed(sourceID: $sourceId, url: $host, mobile: $mobile) { __typename allowed } }"#
      ))

    public var sourceId: ID
    public var host: GraphQLNullable<ClientAppWebInput>
    public var mobile: GraphQLNullable<ClientAppMobileInput>

    public init(
      sourceId: ID,
      host: GraphQLNullable<ClientAppWebInput>,
      mobile: GraphQLNullable<ClientAppMobileInput>
    ) {
      self.sourceId = sourceId
      self.host = host
      self.mobile = mobile
    }

    public var __variables: Variables? { [
      "sourceId": sourceId,
      "host": host,
      "mobile": mobile
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ToldAPI.Objects.Query }
      static var __selections: [Apollo.Selection] { [
        .field("checkIfAppIsAllowed", CheckIfAppIsAllowed?.self, arguments: [
          "sourceID": .variable("sourceId"),
          "url": .variable("host"),
          "mobile": .variable("mobile")
        ]),
      ] }

      var checkIfAppIsAllowed: CheckIfAppIsAllowed? { __data["checkIfAppIsAllowed"] }

      /// CheckIfAppIsAllowed
      ///
      /// Parent Type: `CheckIfAppIsAllowed`
      struct CheckIfAppIsAllowed: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { ToldAPI.Objects.CheckIfAppIsAllowed }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("allowed", Bool?.self),
        ] }

        var allowed: Bool? { __data["allowed"] }
      }
    }
  }

}