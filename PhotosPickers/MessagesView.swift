//
//  MessagesView.swift
//  PhotosPickers
//
//  Created by Kouki Saito on 2024/01/17.
//

import SwiftUI
import PhotosUI

struct Message {
    var uuid = UUID()
    var pickerItems: [PhotosPickerItem]
}

struct PickerItemImageView: View {
    var item: PhotosPickerItem
    @State
    private var imageData: Data?

    var body: some View {
        ZStack {
            if let imageData {
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .padding()
            }
        }
        .task {
            self.imageData = try? await item.loadTransferable(type: Data.self)
        }
    }
}

struct MessagesView: View {
    var messages: [Message]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(messages, id: \.uuid) { message in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(message.pickerItems, id: \.hashValue) {
                                PickerItemImageView(item: $0)
                            }
                        }
                    }
                    .frame(height: 250)
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    MessagesView(messages: [])
}
