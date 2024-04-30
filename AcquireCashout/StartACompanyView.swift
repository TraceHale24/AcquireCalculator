//
//  StartACompanyView.swift
//  AcquireCashout
//
//  Created by Trace Hale on 4/26/24.
//

import SwiftUI

struct StartACompanyView: View {
    @Binding var gameData: GameStructure    
    @Binding var isShowing: Bool
    @Binding var username: String
    @State private var selectedOption = ""
    @State private var startingSize = 0
    
    @State private var listOptions: [String] = ["Loading..."]
    var body: some View {
        Text("Which Company would you like to start?")
            .onAppear {
                generateListOptions()
            }
        
        Picker("Select a company", selection: $selectedOption) {
            ForEach(listOptions, id: \.self) { key in
                Text(key)
                  .onTapGesture {
                      selectedOption = key
                      print("Start \(key)")
                  }
            }
        }
        HStack {
            Text("Starting Company Size: ")
            PlusMinusInputView(value: $startingSize)
        }
        .padding(.horizontal, 15)
        
        if (startingSize != 0) {
            Button {
                Task {
                    try await saveData()
                    isShowing = false
                }
            } label: {
                Text("Start \(selectedOption)")
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
    
    func generateListOptions() {
        let options = gameData.companySizes.sorted(by: { $0.key < $1.key })
        listOptions = options.filter { $0.value == 0 }.map { $0.key }
        selectedOption = listOptions[0]
    }
    
    func saveData() async {
        gameData.companySizes[selectedOption] = startingSize
        let playerIndex = gameData.players.firstIndex { $0.username == username }!
        
        if (selectedOption == "sackson") {
            gameData.players[playerIndex].sacksonStock += 1
            gameData.stockRemaining["sackson"]! -= 1
        }
        else if (selectedOption == "tower") {
            gameData.players[playerIndex].towerStock += 1
            gameData.stockRemaining["tower"]! -= 1
        }
        else if (selectedOption == "continental") {
            gameData.players[playerIndex].continentalStock += 1
            gameData.stockRemaining["continental"]! -= 1
        }
        else if (selectedOption == "american") {
            gameData.players[playerIndex].americanStock += 1
            gameData.stockRemaining["american"]! -= 1
        }
        else if (selectedOption == "worldwide") {
            gameData.players[playerIndex].worldwideStock += 1
            gameData.stockRemaining["worldwide"]! -= 1
        }
        else if (selectedOption == "festival") {
            gameData.players[playerIndex].festivalStock += 1
            gameData.stockRemaining["festival"]! -= 1
        }
        else if (selectedOption == "imperial") {
            gameData.players[playerIndex].imperialStock += 1
            gameData.stockRemaining["imperial"]! -= 1
        }
        
        
        try await FirestoreManager().updateCompanySizes(gameData: gameData)
    }
}

