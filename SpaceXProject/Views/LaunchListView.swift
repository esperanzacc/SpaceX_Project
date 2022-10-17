//
//  LaunchListView.swift
//  SpaceXProject
//
//  Created by Esperanza on 2022-10-14.
//

import SwiftUI

struct LaunchListView: View {
  @ObservedObject var launchModel = LaunchViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        LazyVStack(alignment: .center) {
          ForEach(launchModel.launches, id: \.id) { launch in
            NavigationLink {
              LaunchDetailView(launches: launch, rocket: launch.rocket, ships: launch.ships?.compactMap { $0 } ?? [])
            } label: {
              HStack {
                Text("Mission: \n \(launch.missionName ?? "")")
                  .font(.title3)
                  .bold()
                  .foregroundColor(.white)
              }
              .frame(width: 180, height: 100)
              .background(Color.blue)
              .cornerRadius(15)
            }
          }.padding(10)
        }.padding(.horizontal)
      }.navigationTitle("Launches List")
    }
  }
}

struct LaunchListView_Previews: PreviewProvider {

  static var previews: some View {
    LaunchListView()
  }
}
