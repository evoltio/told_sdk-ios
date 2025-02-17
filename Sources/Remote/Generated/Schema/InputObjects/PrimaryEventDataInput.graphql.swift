// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension ToldAPI {
  struct PrimaryEventDataInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      language: GraphQLNullable<String> = nil,
      deviceType: GraphQLNullable<GraphQLEnum<DeviceType>> = nil,
      os: GraphQLNullable<GraphQLEnum<OS>> = nil,
      version: GraphQLNullable<String> = nil,
      hiddenFields: GraphQLNullable<[HiddenFieldInput?]> = nil,
      url: GraphQLNullable<String> = nil,
      pageName: GraphQLNullable<String> = nil,
      survey: GraphQLNullable<ID> = nil
    ) {
      __data = InputDict([
        "language": language,
        "deviceType": deviceType,
        "os": os,
        "version": version,
        "hiddenFields": hiddenFields,
        "url": url,
        "pageName": pageName,
        "survey": survey
      ])
    }

    var language: GraphQLNullable<String> {
      get { __data["language"] }
      set { __data["language"] = newValue }
    }

    var deviceType: GraphQLNullable<GraphQLEnum<DeviceType>> {
      get { __data["deviceType"] }
      set { __data["deviceType"] = newValue }
    }

    var os: GraphQLNullable<GraphQLEnum<OS>> {
      get { __data["os"] }
      set { __data["os"] = newValue }
    }

    var version: GraphQLNullable<String> {
      get { __data["version"] }
      set { __data["version"] = newValue }
    }

    var hiddenFields: GraphQLNullable<[HiddenFieldInput?]> {
      get { __data["hiddenFields"] }
      set { __data["hiddenFields"] = newValue }
    }

    var url: GraphQLNullable<String> {
      get { __data["url"] }
      set { __data["url"] = newValue }
    }

    var pageName: GraphQLNullable<String> {
      get { __data["pageName"] }
      set { __data["pageName"] = newValue }
    }

    var survey: GraphQLNullable<ID> {
      get { __data["survey"] }
      set { __data["survey"] = newValue }
    }
  }

}