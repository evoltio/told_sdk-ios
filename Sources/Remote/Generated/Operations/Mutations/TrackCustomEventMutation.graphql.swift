// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ToldAPI {
  class TrackCustomEventMutation: GraphQLMutation {
    static let operationName: String = "TrackCustomEvent"
    static let operationDocument: Apollo.OperationDocument = .init(
      definition: .init(
        #"mutation TrackCustomEvent($anonymousId: UUID, $name: EventName!, $sourceId: ID!, $primaryData: PrimaryEventDataInput, $customName: String!, $customData: JSON) { addCustomEvent( anonymousID: $anonymousId name: $name sourceID: $sourceId primaryData: $primaryData customName: $customName customData: $customData ) { __typename triggerInfo { __typename activate surveyId activateParam { __typename delay } customizationParam { __typename overlay { __typename active color blur { __typename active number } } } } } }"#
      ))

    public var anonymousId: GraphQLNullable<UUID>
    public var name: GraphQLEnum<EventName>
    public var sourceId: ID
    public var primaryData: GraphQLNullable<PrimaryEventDataInput>
    public var customName: String
    public var customData: GraphQLNullable<JSON>

    public init(
      anonymousId: GraphQLNullable<UUID>,
      name: GraphQLEnum<EventName>,
      sourceId: ID,
      primaryData: GraphQLNullable<PrimaryEventDataInput>,
      customName: String,
      customData: GraphQLNullable<JSON>
    ) {
      self.anonymousId = anonymousId
      self.name = name
      self.sourceId = sourceId
      self.primaryData = primaryData
      self.customName = customName
      self.customData = customData
    }

    public var __variables: Variables? { [
      "anonymousId": anonymousId,
      "name": name,
      "sourceId": sourceId,
      "primaryData": primaryData,
      "customName": customName,
      "customData": customData
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ToldAPI.Objects.Mutation }
      static var __selections: [Apollo.Selection] { [
        .field("addCustomEvent", AddCustomEvent?.self, arguments: [
          "anonymousID": .variable("anonymousId"),
          "name": .variable("name"),
          "sourceID": .variable("sourceId"),
          "primaryData": .variable("primaryData"),
          "customName": .variable("customName"),
          "customData": .variable("customData")
        ]),
      ] }

      var addCustomEvent: AddCustomEvent? { __data["addCustomEvent"] }

      /// AddCustomEvent
      ///
      /// Parent Type: `EventData`
      struct AddCustomEvent: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { ToldAPI.Objects.EventData }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("triggerInfo", TriggerInfo.self),
        ] }

        var triggerInfo: TriggerInfo { __data["triggerInfo"] }

        /// AddCustomEvent.TriggerInfo
        ///
        /// Parent Type: `TriggerInfo`
        struct TriggerInfo: ToldAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ToldAPI.Objects.TriggerInfo }
          static var __selections: [Apollo.Selection] { [
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

          /// AddCustomEvent.TriggerInfo.ActivateParam
          ///
          /// Parent Type: `TriggerActivateParam`
          struct ActivateParam: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ToldAPI.Objects.TriggerActivateParam }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("delay", Int?.self),
            ] }

            var delay: Int? { __data["delay"] }
          }

          /// AddCustomEvent.TriggerInfo.CustomizationParam
          ///
          /// Parent Type: `TriggerCustomizationParam`
          struct CustomizationParam: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ToldAPI.Objects.TriggerCustomizationParam }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("overlay", Overlay?.self),
            ] }

            var overlay: Overlay? { __data["overlay"] }

            /// AddCustomEvent.TriggerInfo.CustomizationParam.Overlay
            ///
            /// Parent Type: `SurveyOverlay`
            struct Overlay: ToldAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyOverlay }
              static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("active", Bool?.self),
                .field("color", String?.self),
                .field("blur", Blur?.self),
              ] }

              var active: Bool? { __data["active"] }
              var color: String? { __data["color"] }
              var blur: Blur? { __data["blur"] }

              /// AddCustomEvent.TriggerInfo.CustomizationParam.Overlay.Blur
              ///
              /// Parent Type: `SurveyOverlayBlur`
              struct Blur: ToldAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: Apollo.ParentType { ToldAPI.Objects.SurveyOverlayBlur }
                static var __selections: [Apollo.Selection] { [
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