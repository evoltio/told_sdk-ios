// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class GetAnonymousIdMutation: GraphQLMutation {
    static let operationName: String = "GetAnonymousId"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation GetAnonymousId($anonymousId: UUID, $sourceId: ID!, $hiddenFields: [hiddenFieldInput], $preview: Boolean) { getAuthor( anonymousID: $anonymousId sourceID: $sourceId hiddenFields: $hiddenFields preview: $preview ) { __typename anonymousID } }"#
      ))

    public var anonymousId: GraphQLNullable<UUID>
    public var sourceId: ID
    public var hiddenFields: GraphQLNullable<[HiddenFieldInput?]>
    public var preview: GraphQLNullable<Bool>

    public init(
      anonymousId: GraphQLNullable<UUID>,
      sourceId: ID,
      hiddenFields: GraphQLNullable<[HiddenFieldInput?]>,
      preview: GraphQLNullable<Bool>
    ) {
      self.anonymousId = anonymousId
      self.sourceId = sourceId
      self.hiddenFields = hiddenFields
      self.preview = preview
    }

    public var __variables: Variables? { [
      "anonymousId": anonymousId,
      "sourceId": sourceId,
      "hiddenFields": hiddenFields,
      "preview": preview
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { ToldAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("getAuthor", GetAuthor.self, arguments: [
          "anonymousID": .variable("anonymousId"),
          "sourceID": .variable("sourceId"),
          "hiddenFields": .variable("hiddenFields"),
          "preview": .variable("preview")
        ]),
      ] }

      var getAuthor: GetAuthor { __data["getAuthor"] }

      /// GetAuthor
      ///
      /// Parent Type: `SourceAuthor`
      struct GetAuthor: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { ToldAPI.Objects.SourceAuthor }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("anonymousID", String?.self),
        ] }

        var anonymousID: String? { __data["anonymousID"] }
      }
    }
  }

}