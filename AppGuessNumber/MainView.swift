import SwiftUI

struct MainView: View {
    @State private var firstValue: String = ""
    @State private var lastValue: String = ""
    @State private var valueOfPlayer: String = ""
    @State private var generatedNumber: Int?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let fromText = "від"
    let toText = "до"
    
    let firstButtonText = "Задати діапазон"
    let secondButtonText = "Перевірити"
    
    let rangeTitleText = "Діапазон чисел:"
    let inputNumberText = "Ввести число:"
    
    let resultText = "Результат"
    let okText = "OK"
    let validNumberAlertMessage = "Число задане!"
    
    let outOfRangeAlertMessage = "Число не в діапазоні. Будь ласка, введіть число в заданому діапазоні."
    let invalidRangeAlertMessage = "Будь ласка, введіть правильні значення діапазону."
    let invalidGuessAlertMessage = "Будь ласка, введіть правильне число."
    
    let successAlertMessage = "Вітаємо! Ви вгадали число."
    let lowerGuessAlertMessage = "Ваше число менше за вгадуване число. Спробуйте ще раз."
    let higherGuessAlertMessage = "Ваше число більше за вгадуване число. Спробуйте ще раз."
    
    var body: some View {
        // MARK: Background
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                // MARK: Range Setting Section
                
                setText(someText: rangeTitleText)
                HStack {
                    Text(fromText)
                        .font(.title)
                    setTextField(value: $firstValue)
                }
                HStack {
                    Text(toText)
                        .font(.title)
                    setTextField(value: $lastValue)
                }
                Button(action: {
                    createRange()
                }, label: {
                    setLabelOfButton(labelText: firstButtonText)
                })
                
                .padding(50)
                
                VStack {
                    // MARK: Guessing Section
                    setText(someText: inputNumberText)
                    setTextField(value: $valueOfPlayer)
                        .disabled(generatedNumber == nil)
                    
                    Button(action: {
                        checkGuess()
                    }, label: {
                        setLabelOfButton(labelText: secondButtonText)
                    })
                    .disabled(generatedNumber == nil)
                    
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(resultText), message: Text(alertMessage), dismissButton: .default(Text(okText)))
                }
            }
        }
    }
    
    // MARK: Helper Methods
    private func createRange() {
       guard let firstValueInt = Int(firstValue), let lastValueInt = Int(lastValue), firstValueInt <= lastValueInt else {
           alertMessage = invalidRangeAlertMessage
           showAlert = true
           firstValue = ""
           lastValue = ""
           return
       }
       generatedNumber = Int.random(in: firstValueInt...lastValueInt)
       alertMessage = validNumberAlertMessage
       showAlert = true
    }
    
    private func checkGuess() {
        guard let guess = Int(valueOfPlayer), let generatedNumber = generatedNumber else {
            alertMessage = invalidGuessAlertMessage
            valueOfPlayer = ""
            showAlert = true
            return
        }
        
        guard guess >= (Int(firstValue) ?? 0), guess <= (Int(lastValue) ?? 0) else {
            alertMessage = outOfRangeAlertMessage
            valueOfPlayer = ""
            showAlert = true
            return
        }
        
        if guess == generatedNumber {
            alertMessage = successAlertMessage
            resetGame()
        } else if guess < generatedNumber {
            alertMessage = lowerGuessAlertMessage
        } else {
            alertMessage = higherGuessAlertMessage
        }
        showAlert = true
    }
    
    private func resetGame() {
           firstValue = ""
           lastValue = ""
           valueOfPlayer = ""
           generatedNumber = nil
       }
    }

    @ViewBuilder
    private func setText(someText: String) -> some View {
        Text(someText)
            .font(.title2)
            .bold()
    }

    @ViewBuilder
    private func setTextField(value: Binding<String>) -> some View {
        TextField("", text: value)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.leading)
            .background(Color.white)
            .padding(10)
            .frame(width: 200)
            .font(.system(size: 24))
    }


    @ViewBuilder
    private func setLabelOfButton(labelText: String) -> some View {
        Text(labelText)
            .font(.title2)
            .foregroundColor(.white)
            .bold()
            .frame(width: 200, height: 50)
            .background(Color.black)
            .cornerRadius(10)
    }

#Preview {
    MainView()
}
