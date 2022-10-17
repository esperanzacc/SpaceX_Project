//
//  LaunchDetailView.swift
//  SpaceXProject
//
//  Created by Esperanza on 2022-10-14.
//

import SwiftUI
struct LaunchDetailView: View {
  
  var launches: GQL.GetLaunchesQuery.Data.Launch?
  var rocket: GQL.GetLaunchesQuery.Data.Launch.Rocket?
  var ships: [GQL.GetLaunchesQuery.Data.Launch.Ship]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .center) {
        launchList
        shipList
        rocketNameView
        VStack(alignment: .center) {
          Text("Details:")
            .font(.headline)
            .bold()
            .padding([.bottom, .top], 10)
          Text(launches?.details ?? "Not Available")
        }.padding(.horizontal)
      }
    }.navigationBarTitle(launches?.missionName ?? "")
  }
  
  @ViewBuilder
  var launchList: some View {
    VStack(alignment: .center) {
      Text("Launch ID:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(launches?.id ?? "")
    }
    VStack(alignment: .center) {
      Text("Mission Name:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(launches?.missionName ?? "")
    }
  }
  
  @ViewBuilder
  var rocketNameView: some View {
    VStack(alignment: .center) {
      Text("Rocket Name:")
        .font(.headline)
        .bold()
        .padding([.bottom, .top], 10)
      Text(rocket?.rocketName ?? "")
    }
  }
  
  @ViewBuilder
  var shipList: some View {
    ForEach(ships, id: \.id) { ship in
      AsyncImage(url: URL(string: ship.image ?? "exclamationmark.circle" )) { image in
        image.resizable()
        image.scaledToFill()
      } placeholder: {
        Image(systemName: "exclamationmark.circle")
      }
      .frame(width: 300, height: 300)
      .clipShape(RoundedRectangle(cornerRadius: 25))
      
      VStack(alignment: .center) {
        Text("Ship Id :")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.id ?? "")
      }
      
      VStack(alignment: .center) {
        Text("Ship Name:")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.name ?? "")
      }
      
      VStack(alignment: .center) {
        Text("Ship Home_Port:")
          .font(.headline)
          .bold()
          .padding([.bottom, .top], 10)
        Text(ship.homePort ?? "")
      }
    }
  }
}
  
struct LaunchDetailView_Previews: PreviewProvider {
  static var previews: some View {
    let model = LaunchViewModel()
    LaunchDetailView(launches: .init(), rocket: .init(rocketName: "Demo RocketName"), ships: .init())
  }
}
 
