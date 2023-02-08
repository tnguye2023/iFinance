//
//  AddItem.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/12/22.
// Resources: https://medium.com/swlh/how-to-open-the-camera-and-photo-library-in-swiftui-9693f9d4586b

import SwiftUI
import CoreData

struct AddItem: View {
    @State var title: String = ""
    @State var category: String = "Grocery"
    @State var location: String = ""
    @State var amount: Double?
//    @State var date: Date?
    @State var image: Data?

    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var items: FetchedResults<Item>
    
    @State private var isAddView = true
    
    @Environment(\.dismiss) var dismiss
    
    let categories = ["Grocery", "Restaurant", "Entertainment"]
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text("Title")
                    .fontWeight(.light)
                    .padding(.bottom, -5.0)
                    .padding(.top, 10)
                TextField("enter title", text: $title)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Category")
                            .fontWeight(.light)
                            .padding(.bottom, -5.0)
                            .padding(.top, 10)
                        Picker("Category", selection: $category){
                            ForEach(categories, id: \.self){
                                Text($0)
                            }
                        }
                        .frame(maxWidth: 150)
                        .clipped()
                    }
                    VStack(alignment: .leading) {
                        Text("Amount Spent")
                            .fontWeight(.light)
                            .padding(.bottom, -5.0)
                            .padding(.top, 10)
                        TextField("amount", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                    }
                    
                }
                VStack(alignment: .leading) {
                    Text("Location")
                        .fontWeight(.light)
                        .padding(.bottom, -5.0)
                        .padding(.top, 10)
                    TextField("location", text: $location)
                        .keyboardType(.numberPad)
                }
                VStack(alignment: .leading){
                    Button("Camera") {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }.padding([.top, .leading])
                                    
                    Button("Upload Photo") {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }
                }
                .sheet(isPresented: self.$isImagePickerDisplay) {
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                    }
                
                HStack{
                    Button("Add"){
                        addItem()
                    }
                    Button("Clear"){
                        title = ""
                        category = ""
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
//                List{
//                    ForEach(items){item in
//                        HStack{
//                            Text(item.title ?? "Not found")
//                            Spacer()
//                            Text(item.category ?? "Not found")
//                            Spacer()
//                            Text("\(item.amount, specifier: "%.2f")")
//                            Spacer()
//                            Text(item.location ?? "Not found")
////                            Text(timeSince(date: item.date!))
//                            if selectedImage != nil {
//                                                Image(uiImage: selectedImage!)
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .clipShape(Circle())
//                                                    .frame(width: 50, height: 50)
//                                            } else {
//                                                Image(systemName: "snow")
//                                                    .resizable()
//                                                    .aspectRatio(contentMode: .fit)
//                                                    .clipShape(Circle())
//                                                    .frame(width: 50, height: 50)
//                                            }
//                        }
//                    }
//                    .onDelete(perform: deleteItem)
//                }
            }
            .padding(.horizontal, 30)
            .padding(.top, -30)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("cancel"){
                        dismiss()
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem(placement: .principal){
                    Text("ADD TRANSACTION")
                        .fontWeight(.ultraLight)
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("add"){
                        addItem()
                        dismiss()
                    }
                    .foregroundColor(Color("darkBlue"))
                }
            }
        }
//        .navigationBarBackButtonHidden(true)
        
    }
    
    private func addItem() {
        withAnimation{
            let item = Item(context: viewContext)
            item.title = title
            item.category = category
            item.amount = amount ?? 0
            item.location = location
//            item.date = Date.now
//            item.image = selectedImage?.jpegData(compressionQuality: 0.8)
            item.image = selectedImage?.pngData()

            
            saveContext()
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

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
