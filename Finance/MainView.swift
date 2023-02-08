//
//  MainView.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/14/22.
// Resources: https://stackoverflow.com/questions/64103934/swiftui-tab-view-display-sheet
// https://www.answertopia.com/swiftui/a-swiftui-core-data-tutorial/

import SwiftUI
import CoreData

struct MainView: View {
    @State private var isAddView = false
    @State private var selectedItem: Item?
    @State private var changeLimit = false
    
    @State var title: String = ""
    @State var category: String = ""
    @State var amount: Double = 0
    
    @State var navIndex = 0
    
    @State var limit:Double = 2000
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var items: FetchedResults<Item>
    
    let icons = ["house", "chart.pie", "plus", "person", "gear"]
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Button( action: {
                changeLimit = true
            }){
                mainCard(limit: $limit)
            }
            .alert("Change Spending Limit", isPresented: $changeLimit, actions: {
                Text("hi")
                TextField("limit", value: $limit, format: .number)
            })
            
                
           

            List{
                Text("Recent Transactions")
                    .fontWeight(.medium)
                ForEach(items){item in
                    Button{
                        selectedItem = item
                    }
                label: {
                        HStack{
                            if(item.category == "Grocery"){
                                Image(systemName: "carrot")
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .background(Color("coral"))
                                    .clipShape(Circle())
                                    .padding(.trailing, 20)
                            } else if (item.category == "Restaurant"){
                                Image(systemName: "fork.knife")
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .background(Color("lightPurple"))
                                    .clipShape(Circle())
                                    .padding(.trailing, 20)
                            } else{
                                Image(systemName: "gamecontroller")
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .background(Color("darkBlue"))
                                    .clipShape(Circle())
                                    .padding(.trailing, 20)
                            }
                            
                            VStack(alignment: .leading){
                                Text(item.title ?? "Not found")
                                    .foregroundColor(Color.black)
                                Text(item.category ?? "Not found")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.gray)
                                    
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("$ \(item.amount, specifier: "%.2f")")
                                    .foregroundColor(Color.black)
                                Text("Just Now")
                                    .font(.caption)
                                    .fontWeight(.light)
                                    .foregroundColor(Color.gray)
                            }

                        }
                        .padding(.vertical, 5)
                    }
                    
//                    ItemCard(item: item)
                }
                .onDelete(perform: deleteItem)
                .sheet(item: $selectedItem){ item in
                    DetailView(item: item)
                }
                
            }
            
        }
        
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("ERROR: \(error)")
        }
    }
    private func deleteItem(offsets: IndexSet){
        withAnimation{
            offsets.map{items[$0]}.forEach(viewContext.delete)
            saveContext()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
