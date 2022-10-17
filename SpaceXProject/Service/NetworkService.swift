//
//  NetworkService.swift
//  SpaceXProject
//
//  Created by Esperanza on 2022/10/13.
//

import Foundation
import Apollo

class NetworkService {
  // static keyword lets properties and methods that belong to a type rather than to instances of a type
  static let shared: NetworkService = NetworkService()
  
  // private(set) limit write access internal, and allow external read.
  private(set) var apolloClient: ApolloClient

  init() {
    apolloClient = ApolloClient(url: URL(string: "https://api.spacex.land/graphql")!)
  }
}
