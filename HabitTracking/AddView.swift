//
//  AddView.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @Environment (\.dismiss) var dismiss
    
    var habits: Habits
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Habit Name", text: $name)
            }
            .toolbar{
                Button("Save"){
                    AddItem()
                }.disabled(name.isEmpty)
            }
        }
    }
    
    func AddItem(){
        habits.items.append(Habit(name: name, amount: 0))
        print("Item Added")
        dismiss()
    }
}

#Preview {
    AddView(habits: Habits())
}
