//
//  ContentView.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import SwiftUI

class UIEmojiTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
           return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                self.keyboardType = .default // do not remove this
                self.tintColor = UIColor.clear
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.delegate = context.coordinator
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}




@Observable
class Habits {
    var items = [Habit]() {
            didSet {
                if let encoded = try? JSONEncoder().encode(items) {
                    UserDefaults.standard.set(encoded,forKey:"Items")
                }
            }
        }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = [ ]
    }
}

struct ContentView: View {
    
    @State private var ShowAddView = false
    var habits = Habits()
    
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(habits.items) { habit in
                    NavigationLink("\(habit.emoji) \(habit.name)"){
                        List{
                            if habit.description.isEmpty {
                            } else {
                                Section("Description"){
                                    Text(habit.description)
                                }
                            }
                            
                            Section("Amount") {
                                HStack {
                                    Text("\(habit.amount)")
                                    Spacer()
                                    Button("Add One More ") {
                                        // you may like to practice erase this code and try to put it again
                                        // This code adds one more to the amount of habitsd
                                        
                                        if let index = habits.items.firstIndex(of: habit){
                                            habits.items[index].amount += 1
                                        
                                        }
                                    }
                                }
                            }
                        }
                        .navigationTitle("\(habit.emoji) \(habit.name)")
                    }
                }
                .onDelete(perform: test)
            }
            .navigationTitle("Habits")
            .toolbar {
                Button("Add"){
                    ShowAddView = true
                }
            }
        }
        .sheet(isPresented: $ShowAddView, content: {
            AddView(habits: habits)
        })

    }
    
    func test(at offsets: IndexSet){
        habits.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
