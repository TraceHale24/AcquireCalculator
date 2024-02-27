import SwiftUI

struct ContentView: View {
    @State private var sacksonTotal: Int = 0
    @State private var towerTotal: Int = 0
    @State private var festivalTotal: Int = 0
    @State private var worldwideTotal: Int = 0
    @State private var americanTotal: Int = 0
    @State private var continentalTotal: Int = 0
    @State private var imperialTotal: Int = 0

    @State private var inputValue: String = ""
    @State private var isValidNumber: Bool = true
    
    @State private var total: Int = 0

    var body: some View {
        NavigationStack {
            VStack {
                Text("Final Payout Calculator")
                    .font(.title)
                HStack {
                    Text("Cash:")
                    TextField("Enter number", text: $inputValue)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: inputValue) { newValue in
                            isValidNumber = isNumeric(inputValue)
                            calculateGrandTotal()
                        }
                }
                .padding(.horizontal, 15)
                
                if !isValidNumber {
                    Text("Please enter a valid whole number")
                        .foregroundColor(.red)
                        .padding(.bottom, 8)
                }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $sacksonTotal, companyName: .constant("Sackson"), companyTier: .constant(0))) {
                    Text("Sackson Cashout")
                        .font(.title)
                }
                Text("Sackson Total: $\(sacksonTotal)")
                    .onChange(of: sacksonTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $towerTotal, companyName: .constant("Tower"), companyTier: .constant(0))) {
                    Text("Tower Cashout")
                        .font(.title)
                }
                Text("Tower Total: $\(towerTotal)")
                    .onChange(of: towerTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $festivalTotal, companyName: .constant("Festival"), companyTier: .constant(1))) {
                    Text("Festival Cashout")
                        .font(.title)
                }
                Text("Festival Total: $\(festivalTotal)")
                    .onChange(of: festivalTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $worldwideTotal, companyName: .constant("Worldwide"), companyTier: .constant(1))) {
                    Text("Worldwide Cashout")
                        .font(.title)
                }
                Text("Worldwide Total: $\(worldwideTotal)")
                    .onChange(of: worldwideTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $americanTotal, companyName: .constant("American"), companyTier: .constant(1))) {
                    Text("American Cashout")
                        .font(.title)
                }
                Text("American Total: $\(americanTotal)")
                    .onChange(of: americanTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $continentalTotal, companyName: .constant("Continental"), companyTier: .constant(2))) {
                    Text("Continental Cashout")
                        .font(.title)
                }
                Text("Continental Total: $\(continentalTotal)")
                    .onChange(of: continentalTotal) { _ in
                        calculateGrandTotal()
                    }
                
                NavigationLink(destination: CompanyCashoutView(totalMoney: $imperialTotal, companyName: .constant("Imperial"), companyTier: .constant(2))) {
                    Text("Imperial Cashout")
                        .font(.title)
                }
                Text("Imperial Total: $\(imperialTotal)")
                    .onChange(of: imperialTotal) { _ in
                        calculateGrandTotal()
                    }
                
                Text("Grand Total: $\(total)")
                    .font(.title)
            }
            Button {
                sacksonTotal = 0
                towerTotal = 0
                festivalTotal = 0
                worldwideTotal = 0
                americanTotal = 0
                imperialTotal = 0
                continentalTotal = 0
            } label: {
                Text("Reset")
                    .frame(width:200, height:50)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.blue)
                    )
                    .foregroundColor(.white)
            }.padding(.bottom, 20)
            Spacer()
        }
    }
    
    func calculateGrandTotal() {
        total = sacksonTotal + towerTotal + festivalTotal + worldwideTotal + americanTotal + continentalTotal + imperialTotal
        if let inputValue = Int(inputValue), isValidNumber {
            total += inputValue
        }
    }
}

func isNumeric(_ value: String) -> Bool {
    return Int(value) != nil
}
