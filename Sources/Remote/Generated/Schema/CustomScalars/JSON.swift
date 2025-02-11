// Do not delete this file, you can use `generate_apollo_files.sh` to generate the apollo files for spm or cocoapods without deleted this CustomScalarType

#if canImport(ApolloAPI)
import ApolloAPI
#endif

#if canImport(Apollo)
import Apollo
#endif

extension ToldAPI {
    public enum JSON: CustomScalarType, Hashable {
        case dictionary([String: AnyHashable])
        case array([AnyHashable])

        public init(_jsonValue value: JSONValue) throws {
            if let dict = value as? [String: AnyHashable] {
                self = .dictionary(dict)
            } else if let array = value as? [AnyHashable] {
                self = .array(array)
            } else {
                throw JSONDecodingError.couldNotConvert(value: value, to: JSON.self)
            }
        }

        public var _jsonValue: JSONValue {
            switch self {
            case let .dictionary(json as AnyHashable),
                 let .array(json as AnyHashable):
                return json
            }
        }

        public static func == (lhs: JSON, rhs: JSON) -> Bool {
            lhs._jsonValue == rhs._jsonValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(_jsonValue)
        }
    }
}
