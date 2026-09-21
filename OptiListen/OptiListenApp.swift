import SwiftUI
import SwiftData

@main
struct OptiListenApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .tint(Theme.within)
        }
        .modelContainer(for: Practice.self)
    }
}
