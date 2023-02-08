//
//  mainCard.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/13/22.
// Resources: https://www.hackingwithswift.com/quick-start/swiftui/swiftuis-built-in-shapes

import SwiftUI
import CoreData

struct mainCard: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var items: FetchedResults<Item>
    
    var total: Int = 0
//    var limit: Int = 2000
    var left: Int = 0
    
    @Binding var limit: Double
    
    var body: some View {
        VStack(alignment: .leading) {
           
            Text("Welcome,")
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(Color.gray)
            Text("John Doe")
                .foregroundColor(.black)
    
            
            VStack{
                Text("Total Spending")
                    .fontWeight(.semibold)
                    .padding(.top, 30)
                Text("This Month")
                    .font(.caption)
                Text("$ \(calcTotal(), specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 10.0)
                HStack{
                    VStack(alignment: .leading){

                        Text("Remaining")
                            .font(.caption)
                            .fontWeight(.semibold)
                            
                        Text("$ \(calcRemaining(), specifier: "%.0f")")
                            .fontWeight(.bold)
        
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Spending Limit")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Text("$ \(limit, specifier: "%.0f")")
                            .fontWeight(.bold)
                    }
                }
                .padding([.leading, .bottom, .trailing], 20)
            }
    //        .border(.black)
    //        .padding(.horizontal, 30)
    //        .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.blue)).padding(30)
            .background(RoundedRectangle(cornerRadius: 20).fill(Gradient(colors: [Color("darkBlue"), Color("lightPurple")])))
        }
        .foregroundColor(.white)
        .padding(.all, 30)
        
    }
    
    private func calcTotal() -> Double{
        var currentTotal = 0.0
        for item in items{
            currentTotal += item.amount
        }
        return currentTotal
    }
    
    private func calcRemaining() -> Double {
        var currentTotal = 0.0
        for item in items{
            currentTotal += item.amount
        }
        return Double(limit) - currentTotal
    }
}

//
//struct mainCard_Previews: PreviewProvider {
//    static var previews: some View {
//        mainCard()
//            .background(.clear)
//            .previewLayout(.fixed(width: 400, height: 100))
//    }
//}
