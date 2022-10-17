//
//  LaunchModel.swift
//  SpaceXProject
//
//  Created by Esperanza on 2022-10-13.
//

import Foundation
import Apollo

class LaunchViewModel: ObservableObject {
  
  @Published var launches: [GQL.GetLaunchesQuery.Data.Launch] = []

  private let apolloClient: ApolloClient = NetworkService.shared.apolloClient
  
  init() {
      loadLaunchList()
  }
    
  private func loadLaunchList() {

    apolloClient.fetch(query: GQL.GetLaunchesQuery(limit: 100, offset: 0)) { [weak self] (result) in
      guard let self = self else { return }

      switch result {
      case .success(let queryResult):
        guard let launches = queryResult.data?.launches else { return }
        // -> queryResult.data?.launches get array of json
        self.launches = launches.compactMap { $0 }
        // compactMap - > Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
        print(launches[0]?.ships)
//        print("Sucess! Result: \(queryResult)")
      case .failure(let error):
        print("error: \(error.localizedDescription)")
      }
    }
  }
}
