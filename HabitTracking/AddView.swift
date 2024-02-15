//
//  AddView.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var description = ""
    @Environment (\.dismiss) var dismiss
    
    var habits: Habits
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Habit Name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save"){
                        AddItem()
                    }.disabled(name.isEmpty)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func AddItem(){
        habits.items.append(Habit(name: name, description: description, amount: 0))
        print("Item Added")
        dismiss()
    }
}

#Preview {
    AddView(habits: Habits())
}
