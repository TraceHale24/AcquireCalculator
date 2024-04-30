import SwiftUI

struct OpeningView: View {
    @EnvironmentObject var firestoreManager: FirestoreManager
    @AppStorage("userId") var userId: String?
    @Binding var userData: PlayerStructure


    var body: some View {
        if userId != nil {
            NavigationStack {
                GamesView(userId: $userId, userData: $userData)
            }
            .transition(.move(edge: .trailing))
        }
        else {
            NavigationStack {
                LoginView(userId: $userId, userData: $userData)
            }
            .transition(.move(edge: .leading))
        }
    }
}
