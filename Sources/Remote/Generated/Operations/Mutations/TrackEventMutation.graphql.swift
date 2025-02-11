// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class TrackEventMutation: GraphQLMutation {
    static let operationName: String = "TrackEvent"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation TrackEvent($anonymousId: UUID, $name: EventName!, $sourceId: ID!, $primaryData: PrimaryEventDataInput) { addEvent( anonymousID: $anonymousId name: $name sourceID: $sourceId primaryData: $primaryData ) { __typename triggerInfo { __typename activate surveyId activateParam { __typename delay } customizationParam { __typename overlay { __typename active color blur { __typename active number } } } } } }"#
      ))

    public var anonymousId: GraphQLNullable<UUID>
    public var name: GraphQLEnum<EventName>
    public var sourceId: ID
    public var primaryData: GraphQLNullable<PrimaryEventDataInput>

    public init(
      anonymousId: GraphQLNullable<UUID>,
      name: GraphQLEnum<EventName>,
      sourceId: ID,
      primaryData: GraphQLNullable<PrimaryEventDataInput>
    ) {
      self.anonymousId = anonymousId
      self.name = name
      self.sourceId = sourceId
      self.primaryData = primaryData
    }

    public var __variables: Variables? { [
      "anonymousId": anonymousId,
      "name": name,
      "sourceId": sourceId,
      "primaryData": primaryData
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("addEvent", AddEvent?.self, arguments: [
          "anonymousID": .variable("anonymousId"),
          "name": .variable("name"),
          "sourceID": .variable("sourceId"),
          "primaryData": .variable("primaryData")
        ]),
      ] }

      var addEvent: AddEvent? { __data["addEvent"] }

      /// AddEvent
      ///
      /// Parent Type: `EventData`
      struct AddEvent: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.EventData }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("triggerInfo", TriggerInfo.self),
        ] }

        var triggerInfo: TriggerInfo { __data["triggerInfo"] }

        /// AddEvent.TriggerInfo
        ///
        /// Parent Type: `TriggerInfo`
        struct TriggerInfo: ToldAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.TriggerInfo }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("activate", Bool?.self),
            .field("surveyId", ToldAPI.ID?.self),
            .field("activateParam", ActivateParam?.self),
            .field("customizationParam", CustomizationParam?.self),
          ] }

          var activate: Bool? { __data["activate"] }
          var surveyId: ToldAPI.ID? { __data["surveyId"] }
          var activateParam: ActivateParam? { __data["activateParam"] }
          var customizationParam: CustomizationParam? { __data["customizationParam"] }

          /// AddEvent.TriggerInfo.ActivateParam
          ///
          /// Parent Type: `TriggerActivateParam`
          struct ActivateParam: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.TriggerActivateParam }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("delay", Int?.self),
            ] }

            var delay: Int? { __data["delay"] }
          }

          /// AddEvent.TriggerInfo.CustomizationParam
          ///
          /// Parent Type: `TriggerCustomizationParam`
          struct CustomizationParam: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.TriggerCustomizationParam }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("overlay", Overlay?.self),
            ] }

            var overlay: Overlay? { __data["overlay"] }

            /// AddEvent.TriggerInfo.CustomizationParam.Overlay
            ///
            /// Parent Type: `SurveyOverlay`
            struct Overlay: ToldAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyOverlay }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("active", Bool?.self),
                .field("color", String?.self),
                .field("blur", Blur?.self),
              ] }

              var active: Bool? { __data["active"] }
              var color: String? { __data["color"] }
              var blur: Blur? { __data["blur"] }

              /// AddEvent.TriggerInfo.CustomizationParam.Overlay.Blur
              ///
              /// Parent Type: `SurveyOverlayBlur`
              struct Blur: ToldAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyOverlayBlur }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("active", Bool?.self),
                  .field("number", Int?.self),
                ] }

                var active: Bool? { __data["active"] }
                var number: Int? { __data["number"] }
              }
            }
          }
        }
      }
    }
  }

}