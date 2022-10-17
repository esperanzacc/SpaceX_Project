// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// GQL namespace
public extension GQL {
  final class GetLaunchesQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query GetLaunches($limit: Int!, $offset: Int!) {
        launches(limit: $limit, offset: $offset) {
          __typename
          id
          details
          mission_name
          rocket {
            __typename
            rocket_name
          }
          ships {
            __typename
            home_port
            id
            image
            name
          }
        }
      }
      """

    public let operationName: String = "GetLaunches"

    public var limit: Int
    public var offset: Int

    public init(limit: Int, offset: Int) {
      self.limit = limit
      self.offset = offset
    }

    public var variables: GraphQLMap? {
      return ["limit": limit, "offset": offset]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("launches", arguments: ["limit": GraphQLVariable("limit"), "offset": GraphQLVariable("offset")], type: .list(.object(Launch.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(launches: [Launch?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "launches": launches.flatMap { (value: [Launch?]) -> [ResultMap?] in value.map { (value: Launch?) -> ResultMap? in value.flatMap { (value: Launch) -> ResultMap in value.resultMap } } }])
      }

      public var launches: [Launch?]? {
        get {
          return (resultMap["launches"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Launch?] in value.map { (value: ResultMap?) -> Launch? in value.flatMap { (value: ResultMap) -> Launch in Launch(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Launch?]) -> [ResultMap?] in value.map { (value: Launch?) -> ResultMap? in value.flatMap { (value: Launch) -> ResultMap in value.resultMap } } }, forKey: "launches")
        }
      }

      public struct Launch: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Launch"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(GraphQLID.self)),
            GraphQLField("details", type: .scalar(String.self)),
            GraphQLField("mission_name", type: .scalar(String.self)),
            GraphQLField("rocket", type: .object(Rocket.selections)),
            GraphQLField("ships", type: .list(.object(Ship.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID? = nil, details: String? = nil, missionName: String? = nil, rocket: Rocket? = nil, ships: [Ship?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Launch", "id": id, "details": details, "mission_name": missionName, "rocket": rocket.flatMap { (value: Rocket) -> ResultMap in value.resultMap }, "ships": ships.flatMap { (value: [Ship?]) -> [ResultMap?] in value.map { (value: Ship?) -> ResultMap? in value.flatMap { (value: Ship) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID? {
          get {
            return resultMap["id"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var details: String? {
          get {
            return resultMap["details"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "details")
          }
        }

        public var missionName: String? {
          get {
            return resultMap["mission_name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mission_name")
          }
        }

        public var rocket: Rocket? {
          get {
            return (resultMap["rocket"] as? ResultMap).flatMap { Rocket(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "rocket")
          }
        }

        public var ships: [Ship?]? {
          get {
            return (resultMap["ships"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Ship?] in value.map { (value: ResultMap?) -> Ship? in value.flatMap { (value: ResultMap) -> Ship in Ship(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Ship?]) -> [ResultMap?] in value.map { (value: Ship?) -> ResultMap? in value.flatMap { (value: Ship) -> ResultMap in value.resultMap } } }, forKey: "ships")
          }
        }

        public struct Rocket: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["LaunchRocket"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("rocket_name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(rocketName: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "LaunchRocket", "rocket_name": rocketName])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var rocketName: String? {
            get {
              return resultMap["rocket_name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "rocket_name")
            }
          }
        }

        public struct Ship: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Ship"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("home_port", type: .scalar(String.self)),
              GraphQLField("id", type: .scalar(GraphQLID.self)),
              GraphQLField("image", type: .scalar(String.self)),
              GraphQLField("name", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(homePort: String? = nil, id: GraphQLID? = nil, image: String? = nil, name: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Ship", "home_port": homePort, "id": id, "image": image, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var homePort: String? {
            get {
              return resultMap["home_port"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "home_port")
            }
          }

          public var id: GraphQLID? {
            get {
              return resultMap["id"] as? GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var image: String? {
            get {
              return resultMap["image"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "image")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}
