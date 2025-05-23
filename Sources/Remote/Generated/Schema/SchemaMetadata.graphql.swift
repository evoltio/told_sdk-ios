// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol ToldAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

extension ToldAPI {
  typealias SelectionSet = ToldAPI_SelectionSet

  typealias InlineFragment = ToldAPI_InlineFragment

  typealias MutableSelectionSet = ToldAPI_MutableSelectionSet

  typealias MutableInlineFragment = ToldAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "CanUseSurvey": return ToldAPI.Objects.CanUseSurvey
      case "CheckIfAppIsAllowed": return ToldAPI.Objects.CheckIfAppIsAllowed
      case "EventData": return ToldAPI.Objects.EventData
      case "Mutation": return ToldAPI.Objects.Mutation
      case "Query": return ToldAPI.Objects.Query
      case "SourceAuthor": return ToldAPI.Objects.SourceAuthor
      case "SurveyOverlay": return ToldAPI.Objects.SurveyOverlay
      case "SurveyOverlayBlur": return ToldAPI.Objects.SurveyOverlayBlur
      case "TriggerInfo": return ToldAPI.Objects.TriggerInfo
      case "triggerActivateParam": return ToldAPI.Objects.TriggerActivateParam
      case "triggerCustomizationParam": return ToldAPI.Objects.TriggerCustomizationParam
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}