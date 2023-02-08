//
//  Coordinator.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/14/22.
// Resources: https://medium.com/swlh/how-to-open-the-camera-and-photo-library-in-swiftui-9693f9d4586b
import Foundation
import UIKit

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}
