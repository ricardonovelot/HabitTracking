//
//  ContentView.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import SwiftUI

class Habits {
    var items = [Habit]()
}

struct ContentView: View {
    
    @State private var ShowAddView = false
    @State private var habits = Habits()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(habits.items) { habit in
                    /*@START_MENU_TOKEN@*/Text(habit.name)/*@END_MENU_TOKEN@*/
                }
            }
            .navigationBarTitle("Habits")
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
}

#Preview {
    ContentView()
}
