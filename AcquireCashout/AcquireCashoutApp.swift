//
//  AcquireCashoutApp.swift
//  AcquireCashout
//
//  Created by Trace Miller Hale on 2/24/24.
//

import SwiftUI
import Firebase

@main
struct AcquireCashoutApp: App {
    @StateObject var firestoreManager = FirestoreManager()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
