// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol ToldAPI_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == ToldAPI.SchemaMetadata {}

protocol ToldAPI_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == ToldAPI.SchemaMetadata {}

extension ToldAPI {
  typealias ID = String

  typealias SelectionSet = ToldAPI_SelectionSet

  typealias InlineFragment = ToldAPI_InlineFragment

  typealias MutableSelectionSet = ToldAPI_MutableSelectionSet

  typealias MutableInlineFragment = ToldAPI_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Apollo.Object? {
      switch typename {
      case "Query": return ToldAPI.Objects.Query
      case "CanUseSurvey": return ToldAPI.Objects.CanUseSurvey
      case "SurveyOverlay": return ToldAPI.Objects.SurveyOverlay
      case "SurveyOverlayBlur": return ToldAPI.Objects.SurveyOverlayBlur
      case "Mutation": return ToldAPI.Objects.Mutation
      case "EventData": return ToldAPI.Objects.EventData
      case "TriggerInfo": return ToldAPI.Objects.TriggerInfo
      case "triggerActivateParam": return ToldAPI.Objects.TriggerActivateParam
      case "triggerCustomizationParam": return ToldAPI.Objects.TriggerCustomizationParam
      case "CheckIfAppIsAllowed": return ToldAPI.Objects.CheckIfAppIsAllowed
      case "Author": return ToldAPI.Objects.Author
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}