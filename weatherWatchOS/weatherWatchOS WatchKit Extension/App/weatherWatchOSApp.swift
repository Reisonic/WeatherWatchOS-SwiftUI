//
//  weatherWatchOSApp.swift
//  weatherWatchOS WatchKit Extension
//
//  Created by Владислав Космачев.
//

import SwiftUI

@main
struct weatherWatchOSApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
