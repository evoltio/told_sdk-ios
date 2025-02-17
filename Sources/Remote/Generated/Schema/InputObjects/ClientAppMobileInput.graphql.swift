// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension ToldAPI {
  struct ClientAppMobileInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      app: GraphQLNullable<String> = nil,
      os: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "app": app,
        "os": os
      ])
    }

    var app: GraphQLNullable<String> {
      get { __data["app"] }
      set { __data["app"] = newValue }
    }

    var os: GraphQLNullable<String> {
      get { __data["os"] }
      set { __data["os"] = newValue }
    }
  }

}