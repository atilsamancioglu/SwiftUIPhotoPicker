//
//  ContentView.swift
//  SwiftUIPhotoPicker
//
//  Created by Atil Samancioglu on 6.08.2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var selectedItems : [PhotosPickerItem] = []
    @State var data : Data?
    
    var body: some View {
        VStack {
            if let data = data {
                if let selectedImage = UIImage(data:  data) {
                    Spacer()

                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 300,height: 250,alignment: .center)
                        
                }
            }
                Spacer()

                    PhotosPicker(selection: $selectedItems, maxSelectionCount: 1,  matching: .images) {
                        Text("Select Image")
                    
                    }.onChange(of: selectedItems) { newValue in
                        guard let item = selectedItems.first else {
                            return
                        }
                        item.loadTransferable(type: Data.self) { result in
                            switch result {
                            case .success(let data):
                                if let data = data {
                                    self.data = data
                                }
                            case .failure(let error):
                                print(error)
                            }
                            
                        }
                    }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
