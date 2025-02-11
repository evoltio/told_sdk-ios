// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class GetAnonymousIdMutation: GraphQLMutation {
    static let operationName: String = "GetAnonymousId"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation GetAnonymousId($anonymousId: UUID, $hiddenFields: [hiddenFieldInput]) { getAuthor(anonymousID: $anonymousId, hiddenFields: $hiddenFields) { __typename anonymousID } }"#
      ))

    public var anonymousId: GraphQLNullable<UUID>
    public var hiddenFields: GraphQLNullable<[HiddenFieldInput?]>

    public init(
      anonymousId: GraphQLNullable<UUID>,
      hiddenFields: GraphQLNullable<[HiddenFieldInput?]>
    ) {
      self.anonymousId = anonymousId
      self.hiddenFields = hiddenFields
    }

    public var __variables: Variables? { [
      "anonymousId": anonymousId,
      "hiddenFields": hiddenFields
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getAuthor", GetAuthor.self, arguments: [
          "anonymousID": .variable("anonymousId"),
          "hiddenFields": .variable("hiddenFields")
        ]),
      ] }

      var getAuthor: GetAuthor { __data["getAuthor"] }

      /// GetAuthor
      ///
      /// Parent Type: `Author`
      struct GetAuthor: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Author }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("anonymousID", ToldAPI.UUID?.self),
        ] }

        var anonymousID: ToldAPI.UUID? { __data["anonymousID"] }
      }
    }
  }

}