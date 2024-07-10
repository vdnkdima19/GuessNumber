import SwiftUI

struct MainView: View {
    @State private var firstValue: String = ""
    @State private var lastValue: String = ""
    @State private var valueOfPlayer: String = ""
    @State private var generatedNumber: Int?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let firstButtonText = "Задати діапазон"
    let secondButtonText = "Перевірити"
    
    let rangeTitleText = "Діапазон чисел:"
    let inputNumberText = "Ввести число:"
    
    var body: some View {
        // MARK: Background
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                // MARK: Range Setting Section
                setText(someText: rangeTitleText)
                HStack {
                    Text("від")
                        .font(.title)
                    setTextField(value: $firstValue)
                }
                HStack {
                    Text("до")
                        .font(.title)
                    setTextField(value: $lastValue)
                }
                Button(action: {
                    createRange()
                }, label: {
                    setLabelOfButton(labelText: firstButtonText)
                })
                Spacer()
            }
            .padding(.top, 100)
            
            VStack {
                // MARK: Guessing Section
                Spacer()
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
            .padding(.bottom, 140)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Результат"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: Helper Methods
    private func createRange() {
            guard let firstValueInt = Int(firstValue), let lastValueInt = Int(lastValue), firstValueInt <= lastValueInt else {
                alertMessage = "Будь ласка, введіть правильні значення діапазону."
                showAlert = true
                firstValue = ""
                lastValue = ""
                return
            }
            generatedNumber = Int.random(in: firstValueInt...lastValueInt)
            alertMessage = "Число задане!"
            showAlert = true
        }
    
    private func checkGuess() {
        if let guess = Int(valueOfPlayer), let generatedNumber = generatedNumber {
            if guess == generatedNumber {
                alertMessage = "Вітаємо! Ви вгадали число."
                resetGame()
            } else if guess < generatedNumber {
                alertMessage = "Ваше число менше за вгадуване число. Спробуйте ще раз."
            } else if guess > generatedNumber {
                    alertMessage = "Ваше число більше за вгадуване число. Спробуйте ще раз."
            }
        } else {
            alertMessage = "Будь ласка, введіть правильне число."
            valueOfPlayer = ""
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
