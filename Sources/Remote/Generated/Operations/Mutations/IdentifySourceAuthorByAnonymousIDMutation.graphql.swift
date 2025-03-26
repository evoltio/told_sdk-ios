// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ToldAPI {
  class IdentifySourceAuthorByAnonymousIDMutation: GraphQLMutation {
    static let operationName: String = "IdentifySourceAuthorByAnonymousID"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation IdentifySourceAuthorByAnonymousID($anonymousID: UUID!, $sourceID: ID!, $customData: JSON!) { identifySourceAuthorByAnonymousID( anonymousID: $anonymousID sourceID: $sourceID customData: $customData ) }"#
      ))

    public var anonymousID: UUID
    public var sourceID: ID
    public var customData: JSON

    public init(
      anonymousID: UUID,
      sourceID: ID,
      customData: JSON
    ) {
      self.anonymousID = anonymousID
      self.sourceID = sourceID
      self.customData = customData
    }

    public var __variables: Variables? { [
      "anonymousID": anonymousID,
      "sourceID": sourceID,
      "customData": customData
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ToldAPI.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("identifySourceAuthorByAnonymousID", ToldAPI.UUID?.self, arguments: [
          "anonymousID": .variable("anonymousID"),
          "sourceID": .variable("sourceID"),
          "customData": .variable("customData")
        ]),
      ] }

      var identifySourceAuthorByAnonymousID: ToldAPI.UUID? { __data["identifySourceAuthorByAnonymousID"] }
    }
  }

}