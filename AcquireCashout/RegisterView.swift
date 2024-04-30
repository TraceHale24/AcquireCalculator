//
//  RegisterView.swift
//  AcquireCashout
//
//  Created by Trace Hale on 4/19/24.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var name: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var errorMessage: Bool = false
    @State var errorMessageText: String = ""
    @Binding var userId: String?
    @Binding var isRegister: Bool
    
    var body: some View {
        Text("Register")
            .font(.title)
        HStack {
            TextField("", text: $email, prompt: Text("Email"))
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black, lineWidth: 1)
                )
        }.padding(.horizontal, 15)

        HStack {
            TextField("", text: $name, prompt: Text("Name"))
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black, lineWidth: 1)
                )
        }.padding(.horizontal, 15)

        HStack {
            TextField("", text: $username, prompt: Text("Username"))
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black, lineWidth: 1)
                )
            
            
        }
        .padding(.horizontal, 15)

        HStack {
            SecureInputView("Password", text: $password)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black, lineWidth: 1)
                )
        }
        .padding(.horizontal, 15)
        
        HStack {
            SecureInputView("Confirm Password", text: $confirmPassword)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black, lineWidth: 1)
                )
        }
        .padding(.horizontal, 15)
        
        Button {
            Task {
                try await registerUser()
            }
        } label: {
            Text("Register")
                .foregroundColor(.white)
                .frame(maxWidth:.infinity)
                .padding(.vertical, 5)
        }
        .buttonStyle(.borderedProminent)
        .tint(.blue)
        .cornerRadius(3)
        .padding(.horizontal, 15)
        
        Button {
            isRegister = false
        } label: {
            Text("Back")
                .underline()
        }
        
        VStack(alignment: .center) {
            if (errorMessage) {
                Text(errorMessageText).foregroundColor(.red)
            }
        }
    }
    
    private func registerUser() async throws {
        do {
            let exists = try await FirestoreManager().checkDocumentExists(username: username.lowercased())
            if !exists {
                let user = try await FirestoreManager().registerUser(email: email.lowercased(), password: password)
                userId = user.uid
                await FirestoreManager().addUserToFirestore(player: PlayerStructure(name: name, username: username.lowercased(), games: [], wins: 0, losses: 0), userId: userId!)
            } else {
                // Handle case where username already exists
                errorMessageText = "Username already taken"
                errorMessage = true
            }
        } catch {
            errorMessageText = error.localizedDescription
            errorMessage = true
        }
    }


}
