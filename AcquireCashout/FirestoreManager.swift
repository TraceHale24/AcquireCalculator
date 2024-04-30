//
//  FirestoreManager.swift
//  AcquireCashout
//
//  Created by Trace Hale on 4/17/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseFirestore

class FirestoreManager: ObservableObject {

    init() {}
    
    func registerUser(email: String, password: String) async throws -> User {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return authResult.user
    }
    
    func loginUser(email: String, password: String) async throws -> User {
        try await Auth.auth().signIn(withEmail: email, password: password).user
    }
    
    func addUserToFirestore(player: PlayerStructure, userId: String?) async {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "name": player.name,
            "username": player.username.lowercased(),
            "games": player.games,
            "wins": player.wins,
            "losses": player.losses
        ]
    
        let userDocRef = db.collection("Users").document(userId!)
        do {
            try await userDocRef.setData(data)
        }
        catch {
            print(error.localizedDescription)
        }
    }

    func checkDocumentExists(username: String) async -> Bool {
        let db = Firestore.firestore()
        let collection = db.collection("Users")
        let query = collection.whereField("username", isEqualTo: username.lowercased())
        
        do {
            let snapshot = try await query.getDocuments()
            return !snapshot.documents.isEmpty
        } catch {
            print("Error checking document existence: \(error.localizedDescription)")
            return false
        }
    }
    
    func getUserDocument(userId: String) async -> PlayerStructure {
        let db = Firestore.firestore()
        let collection = db.collection("Users").document(userId)
        
        return try! await collection.getDocument(as: PlayerStructure.self)
    }
    
    private var gameListener: ListenerRegistration? = nil
    enum acquireErrors: Error { case GameNotFound; }

    func addGameListener(gameId: String, completion: @escaping (Result<GameStructure, Error>) -> Void) {
        gameListener = Firestore.firestore().collection("Games").document(gameId).addSnapshotListener { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let snapshot else {
                completion(.failure(acquireErrors.GameNotFound))
                return
            }
            do {
                let userData = try snapshot.data(as: GameStructure.self)
                completion(.success(userData))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func removeUserListener() {
        gameListener?.remove()
        gameListener = nil
    }
    
    func updateCompanySizes(gameData: GameStructure) {
        let db = Firestore.firestore()
        
        let collection = db.collection("Games").document(gameData.gameName)
        do {
            try collection.setData(from: gameData, merge: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func joinGame(gameName: String, gamePassword: String) {
        print("Joining Game")
    }
    
    
}
