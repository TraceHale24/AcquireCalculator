import SwiftUI


struct TurnView: View {
    @Binding var gameData: GameStructure
    @Binding var username: String
    @State private var isShowingStartACompanyView = false
    @State private var isShowingMergeView = false
    @State private var canStartCompany = true
    
    @State var isShowingPopup = false
    @State var selectedKey = ""
    @State var modifiedValue = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Step 1: Place a tile, grow a company, start a company, merge?")
                    .onAppear {
                        calculateIfCanStartNewCompany()
                    }

                Text("Select a company to grow")
                ForEach(gameData.companySizes.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                    if (value != 0) {
                        Button {
                            selectedKey = key
                            isShowingPopup = true
                            modifiedValue = value
                        } label: {
                            Text("Grow \(key)")
                        }
                    }
                }

                
                
                if canStartCompany {
                    Button {
                        isShowingStartACompanyView = true
                    } label: {
                        Text("Start a Company")
                            .foregroundColor(.white)
                            .frame(maxWidth:.infinity)
                            .padding(.vertical, 5)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .cornerRadius(3)
                    .padding(.horizontal, 10)
                }
                
                Button {
                    isShowingMergeView = true
                } label: {
                    Text("Merge")
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .padding(.vertical, 5)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .cornerRadius(3)
                .padding(.horizontal, 10)
            }.padding(.horizontal, 15)
        }
        .sheet(isPresented: $isShowingStartACompanyView) {
            StartACompanyView(gameData: $gameData, isShowing: $isShowingStartACompanyView, username: $username)
        }
        .sheet(isPresented: $isShowingMergeView) {
            MergerView(gameData: $gameData, isShowing: $isShowingMergeView)
        }
        .sheet(isPresented: $isShowingPopup, content: {
            VStack {
                Text("What is \(selectedKey)'s new size?")
                    .font(.title)
                PlusMinusInputView(value: $modifiedValue)
                Button {
                    gameData.companySizes[selectedKey] = modifiedValue
                    FirestoreManager().updateCompanySizes(gameData: gameData)
                    isShowingPopup = false
                } label: {
                    Text("Save")
                }
            }
            .presentationDetents([.fraction(0.25)])
        })
    }

    
    func calculateIfCanStartNewCompany() {
        let options = gameData.companySizes.sorted(by: { $0.key < $1.key })
        let optionNames = options.filter { $0.value == 0 }.map { $0.key }
        
        if optionNames.isEmpty {
            canStartCompany = false
        }
    }
}
