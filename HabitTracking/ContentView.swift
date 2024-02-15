//
//  ContentView.swift
//  HabitTracking
//
//  Created by Ricardo on 16/01/24.
//

import SwiftUI

@Observable
class Habits {
    var items = [Habit]()
}

struct ContentView: View {
    
    @State private var ShowAddView = false
    var habits = Habits()
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(habits.items) { habit in
                    NavigationLink(habit.name){
                        List{
                            Section("Description"){
                                Text(habit.description)
                            }
                            
                            Section("Amount") {
                                HStack {
                                    Text("\(habit.amount)")
                                    Spacer()
                                    Button("Add One More ") {
                                        // you may like to practice erase this code and try to put it again
                                        if let index = habits.items.firstIndex(of: habit) {
                                            habits.items[index].amount += 1
                                        }
                                    }
                                }
                            }
                            
                        }
                        .navigationTitle(habit.name)
                    }
                }
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
}

#Preview {
    ContentView()
}
