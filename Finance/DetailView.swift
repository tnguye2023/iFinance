//
//  DetailView.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/14/22.
// Resources: https://developer.apple.com/library/archive/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    let item: Item
    
    var body: some View {
        VStack{
            Button(action: {
                dismiss()
            }){
                Text("Go Back")
            }
            Text(item.title ?? "No title")
                .font(.title)
                .fontWeight(.bold)
            Text("$ \(item.amount, specifier: "%.2f")")
            HStack{
                Text(item.category ?? "No Category")
                Text("|")
                Text(item.location ?? "No location")
                Button(action: {
                    openMap(Location: item.location ?? "no location")
//                    openMap(Location: "941,Emmet,St,N,Charlottesville,,VA")
                }){
                    Text("GO")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
            }.font(.caption)
            .foregroundColor(Color.gray)
            
        }
        
    }
    func openMap(Location:String){
//        UIApplication.shared.open(NSURL(string:"https://maps.apple.com/?q=\(Location)")! as URL)
        UIApplication.shared.open(NSURL(string:"https://maps.apple.com/?daddr=\(Location)")! as URL)
    }
}

