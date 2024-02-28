//
//  SacksonCashout.swift
//  AcquireCashout
//
//  Created by Trace Miller Hale on 2/24/24.
//

import SwiftUI

struct CompanyCashoutView: View {
    
    @State private var companyStock: String = "0"
    @State private var companyBonus: String = "0"
    @State private var companySize: String = "0"
    @State private var isValidCompanyStock: Bool = true
    @State private var isValidCompanyBonus: Bool = true
    @State private var isValidCompanySize: Bool = true
    @State private var placementOption: Int = 0
    @State private var tiedOption: Int = 1
    @State private var tiedWithOption: Int = 0
    
    @Binding var totalMoney: Int
    @Binding var companyName: String
    @Binding var companyTier: Int
    @Binding var classicMode: Bool

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text("\(companyName) Stock Count")
                    .font(.title)
                VStack {
                    HStack {
                        Text("\(companyName) Stock")
                        TextField("Enter stock", text: $companyStock)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: companyStock) { newValue in
                                isValidCompanyStock = isNumeric(companyStock)
                            }
                        if(!isValidCompanyStock) {
                            Text("Invalid Company Stock")
                                .foregroundColor(.red)
                        }
                    }.padding(.horizontal, 15)
                    
                    VStack {
                        Text("Were you a top stock owner?")

                        Picker("Placement", selection: $placementOption) {
                            Text("None").tag(0)
                            Text("1st").tag(1)
                            Text("2nd").tag(2)
                            if (!classicMode) {
                                Text("3rd").tag(3)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, 10)
                        .padding(.horizontal, 15)

                        if (placementOption != 4) {
                            Text("Did you tie?")
                            Picker("Yes or No", selection: $tiedOption) {
                                Text("Yes").tag(0)
                                Text("No").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 10)
                            .padding(.horizontal, 15)
                        }
                        
                        if (tiedOption == 0) {
                            Text("How many people did you tie with?")
                            Picker("", selection: $tiedWithOption) {
                                Text("1").tag(0)
                                Text("2").tag(1)
                                Text("3").tag(2)
                                Text("4").tag(3)
                                Text("5").tag(4)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.bottom, 10)
                            .padding(.horizontal, 15)
                        }
                    }
                    
                    HStack {
                        Text("Company Size")
                        TextField("Company Size", text: $companySize)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: companySize) { newValue in
                                isValidCompanySize = isNumeric(companySize)
                            }
                        if(!isValidCompanySize) {
                            Text("Invalid Company Size")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal, 15)
                    

                    Button {
                        totalMoney = classicMode ? calculateCompanyTotalClassic() : calculateCompanyTotalTycoon()
                    } label: {
                        Text("Calculate Total For \(companyName)")
                            .frame(width:200, height:50)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.blue)
                            )
                            .foregroundColor(.white)
                    }.padding(.bottom, 20)
                    
                    Text("Total: $\(totalMoney)")
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Confirm and Return")
                            .frame(width:200, height: 50)
                            .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.blue))
                            .foregroundColor(.white)
                    }.padding(.bottom, 20)
                    
                }
            }
            Spacer()
        }
    }
    
    func calculateCompanyTotalClassic() -> Int {
        var total = 0
        var sizeTierValue = 0
        for sizeTier in allCompanyTiers {
            if (Int(companyStock) != 0 && Int(companySize) ?? 0 >= sizeTier.minSize && Int(companySize) ?? 0 <= sizeTier.maxSize)
            {
                sizeTierValue = sizeTier.tier
                total += stockCost.cost[sizeTierValue + companyTier] * (Int(companyStock) ?? 0)
                break
            }
        }
        
        //Bonus
        if (placementOption == 1) {
            if (tiedOption == 1) {
                total += allTycoonMergerPayouts[sizeTierValue + companyTier].primary
            }
            else {
                if (tiedWithOption == 0) {
                    let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].primary + allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
                    total += roundToHundreds(tempTotal / 2)
                }
                else if (tiedWithOption >= 1) {
                    let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].primary + allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
                    total += roundToHundreds(tempTotal / (tiedWithOption + 1))
                }
            }
        }
        else if (placementOption == 2) {
            if (tiedOption == 1) {
                total += allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
            }
            else {
                let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
                total += roundToHundreds(tempTotal / (tiedWithOption + 1))
            }
        }
        
        total += Int(companyBonus) ?? 0
        return total
    }
    
    func calculateCompanyTotalTycoon() -> Int {
        var total = 0
        var sizeTierValue = 0
        for sizeTier in allCompanyTiers {
            if (Int(companyStock) != 0 && Int(companySize) ?? 0 >= sizeTier.minSize && Int(companySize) ?? 0 <= sizeTier.maxSize)
            {
                sizeTierValue = sizeTier.tier
                total += stockCost.cost[sizeTierValue + companyTier] * (Int(companyStock) ?? 0)
                break
            }
        }
        
        //Bonus
        if (placementOption == 1) {
            if (tiedOption == 1) {
                total += allTycoonMergerPayouts[sizeTierValue + companyTier].primary
            }
            else {
                if (tiedWithOption == 0) {
                    let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].primary + allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
                    total += roundToHundreds(tempTotal / 2)
                }
                else if (tiedWithOption >= 1) {
                    let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].primary + allTycoonMergerPayouts[sizeTierValue + companyTier].secondary + (allTycoonMergerPayouts[sizeTierValue + companyTier].tertiary ?? 0)
                    total += roundToHundreds(tempTotal / (tiedWithOption + 1))
                }
            }
        }
        else if (placementOption == 2) {
            if (tiedOption == 1) {
                total += allTycoonMergerPayouts[sizeTierValue + companyTier].secondary
            }
            else {
                let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].secondary + (allTycoonMergerPayouts[sizeTierValue + companyTier].tertiary ?? 0)
                total += roundToHundreds(tempTotal / (tiedWithOption + 1))
            }
        }
        else if (placementOption == 3) {
            if (tiedOption == 1) {
                total += allTycoonMergerPayouts[sizeTierValue + companyTier].tertiary ?? 0
            }
            else {
                let tempTotal = allTycoonMergerPayouts[sizeTierValue + companyTier].tertiary ?? 0
                total += roundToHundreds(tempTotal / (tiedWithOption + 1))
            }
        }
        
        total += Int(companyBonus) ?? 0
        return total
    }
    
    func roundToHundreds(_ value : Int) -> Int {
        var tempValue = String(value)
        
        let index = tempValue.index(tempValue.endIndex, offsetBy: -2)
        if tempValue[index] != "0" {
            let mutableTempValue = NSMutableString(string: tempValue)
            mutableTempValue.replaceCharacters(in: NSRange(location: index.utf16Offset(in: tempValue), length: 1), with: "0")
            tempValue = mutableTempValue as String
            tempValue = String((Int(tempValue) ?? 0) + 100)
        }
        
        return Int(tempValue) ?? 0
    }
}

#Preview {
    CompanyCashoutView(totalMoney: .constant(0), companyName: .constant("Sackson"), companyTier: .constant(1), classicMode: .constant(false))
}
