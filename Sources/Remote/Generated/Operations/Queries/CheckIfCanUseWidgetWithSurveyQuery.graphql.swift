// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension ToldAPI {
  class CheckIfCanUseWidgetWithSurveyQuery: GraphQLQuery {
    static let operationName: String = "CheckIfCanUseWidgetWithSurvey"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query CheckIfCanUseWidgetWithSurvey($surveyID: ID!, $hostname: String, $port: String, $preview: Boolean, $os: String, $mobileApp: String) { checkIfCanUseWidgetWithSurvey( surveyID: $surveyID hostname: $hostname port: $port preview: $preview os: $os mobileApp: $mobileApp ) { __typename canUse overlay { __typename active color blur { __typename number active } } } }"#
      ))

    public var surveyID: ID
    public var hostname: GraphQLNullable<String>
    public var port: GraphQLNullable<String>
    public var preview: GraphQLNullable<Bool>
    public var os: GraphQLNullable<String>
    public var mobileApp: GraphQLNullable<String>

    public init(
      surveyID: ID,
      hostname: GraphQLNullable<String>,
      port: GraphQLNullable<String>,
      preview: GraphQLNullable<Bool>,
      os: GraphQLNullable<String>,
      mobileApp: GraphQLNullable<String>
    ) {
      self.surveyID = surveyID
      self.hostname = hostname
      self.port = port
      self.preview = preview
      self.os = os
      self.mobileApp = mobileApp
    }

    public var __variables: Variables? { [
      "surveyID": surveyID,
      "hostname": hostname,
      "port": port,
      "preview": preview,
      "os": os,
      "mobileApp": mobileApp
    ] }

    struct Data: ToldAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("checkIfCanUseWidgetWithSurvey", CheckIfCanUseWidgetWithSurvey?.self, arguments: [
          "surveyID": .variable("surveyID"),
          "hostname": .variable("hostname"),
          "port": .variable("port"),
          "preview": .variable("preview"),
          "os": .variable("os"),
          "mobileApp": .variable("mobileApp")
        ]),
      ] }

      var checkIfCanUseWidgetWithSurvey: CheckIfCanUseWidgetWithSurvey? { __data["checkIfCanUseWidgetWithSurvey"] }

      /// CheckIfCanUseWidgetWithSurvey
      ///
      /// Parent Type: `CanUseSurvey`
      struct CheckIfCanUseWidgetWithSurvey: ToldAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.CanUseSurvey }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("canUse", Bool?.self),
          .field("overlay", Overlay?.self),
        ] }

        var canUse: Bool? { __data["canUse"] }
        var overlay: Overlay? { __data["overlay"] }

        /// CheckIfCanUseWidgetWithSurvey.Overlay
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

          /// CheckIfCanUseWidgetWithSurvey.Overlay.Blur
          ///
          /// Parent Type: `SurveyOverlayBlur`
          struct Blur: ToldAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: ApolloAPI.ParentType { ToldAPI.Objects.SurveyOverlayBlur }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("number", Int?.self),
              .field("active", Bool?.self),
            ] }

            var number: Int? { __data["number"] }
            var active: Bool? { __data["active"] }
          }
        }
      }
    }
  }

}