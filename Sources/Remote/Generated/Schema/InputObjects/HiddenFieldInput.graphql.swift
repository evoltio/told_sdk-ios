// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension ToldAPI {
  struct HiddenFieldInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      key: GraphQLNullable<String> = nil,
      value: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "key": key,
        "value": value
      ])
    }

    var key: GraphQLNullable<String> {
      get { __data["key"] }
      set { __data["key"] = newValue }
    }

    var value: GraphQLNullable<String> {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }
  }

}