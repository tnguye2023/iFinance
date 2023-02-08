//
//  ContentView.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/12/22.
// Resources : https://serialcoder.dev/text-tutorials/swiftui/working-with-the-tab-view-in-swiftui/

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isAddView = false
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
//
//    @State var title: String = ""
//    @State var category: String = ""
//    @State var amount: Double = 0
//
//    @State var navIndex = 0
//
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
//    private var items: FetchedResults<Item>
//
//    let icons = ["house", "chart.pie", "plus", "person", "gear"]
//

    
    var body: some View {
        TabView(selection: $selectedItem){
            
            MainView()
                .tabItem{
                    Image(systemName: "house")
                }.tag(1)
            Summary()
                .tabItem{
                    Image(systemName: "chart.pie")
                }.tag(2)
            Text("")
                .tabItem{
                    Image(systemName: "plus")
                }.tag(3)
            Text("Empty")
                .tabItem{
                    Image(systemName: "person")
                }.tag(4)
            Text("Empty")
                .tabItem{
                    Image(systemName: "gear")
                }.tag(5)
      
            
        }
        
        .onChange(of: selectedItem){
            if 3 == selectedItem{
                self.isAddView = true
            } else{
                self.oldSelectedItem = $0
            }
        }
        .sheet(isPresented: $isAddView, onDismiss: {
            self.selectedItem = self.oldSelectedItem
        }){
            AddItem()
        }
        
//        VStack{
//
//
//            mainCard()
//            List{
//                ForEach(items){item in
//                    HStack{
//                        Text(item.title ?? "Not found")
//                        Spacer()
//                        Text(item.category ?? "Not found")
//                        Spacer()
//                    }
////                    ItemCard(item: item)
//                }
//                .onDelete(perform: deleteItem)
//
//            }
//
//            Button("ADD"){
//                isAddView = true
//            }
//            .sheet(isPresented: $isAddView){
//                    AddItem()
//            }
//
//
//        }
//
//    }
//
//    private func saveContext() {
//        do {
//            try viewContext.save()
//        } catch {
//            let error = error as NSError
//            fatalError("ERROR: \(error)")
//        }
//    }
//    private func deleteItem(offsets: IndexSet){
//        withAnimation{
//            offsets.map{items[$0]}.forEach(viewContext.delete)
//            saveContext()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
