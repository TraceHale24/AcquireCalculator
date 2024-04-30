//
//  LoginView.swift
//  AcquireCashout
//
//  Created by Trace Hale on 4/17/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var loginErrorMessage: String = ""
    @State private var loginError: Bool = false
    @State private var isRegister: Bool = false
    @Binding var userId: String?
    @Binding var userData: PlayerStructure
    var body: some View {
        NavigationStack {
            if !isRegister {
                VStack {
                        TextField("", text: $email, prompt: Text("Email"))
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.black, lineWidth: 1)
                            ).padding(.horizontal, 15)
                    
                        SecureInputView("Password", text: $password)
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.black, lineWidth: 1)
                            ).padding(.horizontal, 15)
                    
                    Button {
                        Task {
                            try await loginUser()
                        }
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .cornerRadius(3)
                    .padding(.horizontal, 10)
                    
                    Button {
                        isRegister = true
                    } label: {
                        Text("Register")
                    }
                    
                    
                    VStack(alignment: .center) {
                        if (loginError) {
                            Text(loginErrorMessage).foregroundColor(.red)
                        }
                    }
                }
            } else {
                RegisterView(userId: $userId, isRegister: $isRegister)
            }
        }
    }
    
    func loginUser() async throws {
        do {
            let result = try await FirestoreManager().loginUser(email: email.lowercased(), password: password)
            userId = result.uid
            userData = try await FirestoreManager().getUserDocument(userId: userId!)
        }
        catch {
            loginError = true
            loginErrorMessage = error.localizedDescription
            if (loginErrorMessage == "The supplied auth credential is malformed or has expired.") {
                loginErrorMessage = "Username or Password Incorrect";
            }
        }
    }
}
