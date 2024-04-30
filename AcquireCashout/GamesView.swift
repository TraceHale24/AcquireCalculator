//
//  GamesView.swift
//  AcquireCashout
//
//  Created by Trace Hale on 4/17/24.
//

import SwiftUI

struct GamesView: View {
    @Binding var userId: String?
    @Binding var userData: PlayerStructure
    @State var games: [String] = ["Game One", "Game Two"]
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Welcome back, \(userData.name)!")
                        .font(.title)
                        .padding(.top, 15)
                        .padding(.horizontal, 15)
                    
                    Text("Games")
                        .font(.title)
                    
                    ForEach(userData.games, id: \.self) {game in
                        HStack { 
                            NavigationLink(destination: InGameView(userId: $userId, username: .constant(userData.username), gameName: game))  {
                                Text(game)
                            }

                        }
                        .padding(.horizontal, 15)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Create Game")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .cornerRadius(3)
                    .padding(.horizontal, 10)
                    
                    Button {
                        
                    } label: {
                        Text("Join Game")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .cornerRadius(3)
                    .padding(.horizontal, 10)
                }
            }
        }
        .onAppear {
            Task {
                if userData.name.isEmpty {
                    try await getUser()
                    games = userData.games
                }
            }
        }
        .safeAreaInset(edge: .top) {
            HStack(alignment: .bottom) {
                Text("Your Games")
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.leading, 15)
                    .font(.system(size:20))
                Image(systemName: "person.3")
                    .foregroundColor(.white)
                    .font(.system(size:20))

                Spacer()

                Button {
                    userId = nil
                } label: {
                    Text("Logout")
                        .foregroundColor(.white)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .font(.system(size:20))
                        .padding(.trailing, 15)
                        .padding(.leading, 5)
                        .padding(.vertical, 0)
                }
            }
            .background(Rectangle()
                .fill(LinearGradient(gradient: .init(colors:[.blue, .yellow]), startPoint: .init(x:0.0, y:0), endPoint: .init(x:1.0, y:1.0)))
                .frame(width: 450, height: 75, alignment: .top))
            .background(Rectangle()
                .fill(LinearGradient(gradient: .init(colors:[.blue, .yellow]), startPoint: .init(x:0.0, y:0), endPoint: .init(x:1.0, y:1.0)))
                .frame(width:450, height:90)
                .padding(.bottom, 110))
            .padding(0)
        }
    }
    
    func getUser() async throws {
        userData = try await FirestoreManager().getUserDocument(userId: userId!)
    }
}
