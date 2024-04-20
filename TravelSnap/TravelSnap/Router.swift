//
//  Router.swift
//  TravelSnap
//
//  Created by Mina on 4/18/24.
//

import SwiftUI

// Observable class responsible for managing navigation within the app
@Observable
class Router {
    
    // Enum defining possible destinations for navigation
    enum Destination: Codable, Hashable {
        case authentication
        case tabBar
        case detailsView
        case settings

    }
    
    // NavigationPath to keep track of navigation history
    var navigationPath = NavigationPath()
    
    // Function to navigate to a specific destination
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    // Function to dismiss the current destination and navigate back
    func dismiss() {
        navigationPath.removeLast()
    }
    
    // Function to navigate back to the root view
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
