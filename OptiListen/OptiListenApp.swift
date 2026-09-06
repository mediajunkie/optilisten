import SwiftUI
import SwiftData

@main
struct OptiListenApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Practice.self)
    }
}
