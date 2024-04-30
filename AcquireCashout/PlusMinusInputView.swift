import SwiftUI

struct PlusMinusInputView: View {
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Button(action: {
                if self.value > 0 {
                    self.value -= 1
                }
            }) {
                Image(systemName: "minus.circle")
                    .font(.title)
            }
            
            TextField("Enter value", value: $value, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .frame(width: 50)
            
            Button(action: {
                if self.value < 25 {
                    self.value += 1
                }
            }) {
                Image(systemName: "plus.circle")
                    .font(.title)
            }
        }
        .padding(.trailing, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
