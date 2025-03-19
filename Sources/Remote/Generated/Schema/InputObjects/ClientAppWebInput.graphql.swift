// @generated
// This file was automatically generated and should not be edited.

import Apollo

extension ToldAPI {
  struct ClientAppWebInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      hostname: GraphQLNullable<String> = nil,
      port: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "hostname": hostname,
        "port": port
      ])
    }

    var hostname: GraphQLNullable<String> {
      get { __data["hostname"] }
      set { __data["hostname"] = newValue }
    }

    var port: GraphQLNullable<String> {
      get { __data["port"] }
      set { __data["port"] = newValue }
    }
  }

}