import SwiftUI

struct InGameView: View {
    @Binding var userId: String?
    @Binding var username: String
    @State var userIndex: Int?
    @State var gameName: String
    @State var sacksonStock: Int = 0
    @State var towerStock: Int = 0
    @State var americanStock: Int = 0
    @State var festivalStock: Int = 0
    @State var worldwideStock: Int = 0
    @State var continentalStock: Int = 0
    @State var imperialStock: Int = 0
    
    @State var gameData: GameStructure = GameStructure(name: "Loading...", gameName: "Loading...", owner: "Loading...", passcode: "", turnPlayerId: "Loading...", players: [PlayerGameData(name: "Loading...", username:"Loading...", towerStock: 0, sacksonStock: 0, festivalStock: 0, worldwideStock: 0, americanStock: 0, continentalStock: 0, imperialStock: 0, cash: 0)], companySizes: [:], turnOrder: [:], stockRemaining: [:], gameOver: false)

    var body: some View {
        NavigationStack {
            VStack {
                if gameData.gameOver {
                    Text("Game is completed! You placed: \(determinePlacement())")
                }
                HStack {
                    Text("Cash Count: $\(gameData.players[0].cash)")
                }
                Text("My Stock Count")
                    .task {
                        await getGame(gameName:gameName)
                    }
                HStack {
                    Text("Sackson")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].sacksonStock)")
                }.padding(.bottom, 0)
                
                HStack {
                    Text("Tower")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].towerStock)")
                }.padding(.horizontal, 0)
                
                HStack {
                    Text("American")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].americanStock)")
                }
                
                HStack {
                    Text("Festival")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].festivalStock)")
                }
                
                HStack {
                    Text("Worldwide")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].worldwideStock)")
                }
                
                HStack {
                    Text("Continental")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].continentalStock)")
                }
                
                HStack {
                    Text("Imperial")
                    Spacer()
                    Text("\(gameData.players[userIndex ?? 0].imperialStock)")
                }
            }.padding(.horizontal, 15)
            if (gameData.turnPlayerId == username && !gameData.gameOver) {
                NavigationLink(destination: TurnView(gameData: $gameData, username: $username))  {
                    Text("Take Turn")
                }
            }
            Spacer()
        }
    }
    
    
    func getGame(gameName: String) async {
        try await FirestoreManager().addGameListener(gameId: gameName) { result in
            switch result {
            case.success(let successFullResult):
                gameData = successFullResult
                userIndex = gameData.players.firstIndex { player in
                    player.username == username
                }
            case.failure(_):
                print("Error, something broke, whoops")
            }
        }
    }
    
    func determinePlacement() -> String {
        let place = gameData.players[userIndex!].placement ?? 6
        let intToStringPlacement = [1:"First", 2:"Second", 3:"Third", 4:"Fourth", 5:"Fifth", 6:"Sixth"]
        
        return intToStringPlacement[place] ?? "Error Occurred, try again later"
    }
}
