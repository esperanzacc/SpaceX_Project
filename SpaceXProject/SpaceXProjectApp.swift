//
//  SpaceXProjectApp.swift
//  SpaceXProject
//
//  Created by Esperanza on 2022-10-12.
//

import SwiftUI

@main
struct SpaceXProjectApp: App {
//  @StateObject var launchViewModel = LaunchViewModel()
    var body: some Scene {
        WindowGroup {
          LaunchListView()
//            .environmentObject(launchViewModel)
        }
    }
}
