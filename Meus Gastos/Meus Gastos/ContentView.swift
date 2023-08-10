//
//  ContentView.swift
//  Meus Gastos
//
//  Created by Biel on 10/08/23.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Pessoal"}
    }
    
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Negócios"}
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
        
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    
    @StateObject var expenses = Expenses()
    
    
    var body: some View {
        NavigationView {
            Form{
                Section("Pessoal 🙋‍♂️") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("\(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                .foregroundColor(item.amount < 50 ? .green : item.amount < 120 ? .yellow : .red)
                        }
                    }.onDelete(perform: removePersItems)
                  
//                    if !expenses.personalItems.isEmpty {
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("Total")
//                                    .font(.headline)
//                            }
//                            Spacer()
//                            Text("")
//                        }
//                    }
                }
                
                Section("Negócios 💼") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text("\(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                .foregroundColor(item.amount < 50 ? .green : item.amount < 120 ? .yellow : .red)
                        }
                    }.onDelete(perform: removeBusItems)
                }
                
            }
            .navigationTitle("Meus Gastos 💸")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removePersItems(at offsets: IndexSet){
        removeItems(at: offsets, in: expenses.personalItems)
    }
    
    func removeBusItems (at offsets: IndexSet){
        removeItems(at: offsets, in: expenses.businessItems)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
