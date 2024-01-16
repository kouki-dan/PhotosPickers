//
//  ContentView.swift
//  PhotosPickers
//
//  Created by Kouki Saito on 2024/01/17.
//

import SwiftUI
import PhotosUI

struct WholePicker: View {
    @State
    private var photosPickerItems: [PhotosPickerItem] = []
    @State
    private var messages: [Message] = []

    var body: some View {
        VStack {
            MessagesView(messages: messages)
            PhotosPicker(
                "送信する画像を選択",
                selection: $photosPickerItems,
                matching: .images
            ).padding()
        }
        .onChange(of: photosPickerItems) {
            if !photosPickerItems.isEmpty {
                messages.append(
                    Message(pickerItems: photosPickerItems)
                )
                photosPickerItems.removeAll()
            }
        }
    }
}

struct InlinePicker: View {
    @State
    private var photosPickerItems: [PhotosPickerItem] = []
    @State
    private var messages: [Message] = []

    var body: some View {
        VStack {
            MessagesView(messages: messages)
            HStack {
                if photosPickerItems.isEmpty {
                    Text("写真を選択してください")
                } else {
                    Text("\(photosPickerItems.count)個の写真を選択中です")
                    Button("選択解除") {
                        photosPickerItems.removeAll()
                    }
                }
                Spacer()
                Button("送信") {
                    messages.append(
                        Message(pickerItems: photosPickerItems)
                    )
                    photosPickerItems.removeAll()
                }
                .disabled(photosPickerItems.isEmpty)
            }.padding(.horizontal)
            PhotosPicker(
                "Picker",
                selection: $photosPickerItems,
                selectionBehavior: .continuous,
                matching: .images
            )
                .photosPickerStyle(.compact)
                .photosPickerAccessoryVisibility(.hidden)
                .frame(height: 150)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            WholePicker()
                .tabItem {
                    Label("全画面", systemImage: "photo")
                }
            InlinePicker()
                .tabItem {
                    Label("インライン", systemImage: "photo.artframe.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
