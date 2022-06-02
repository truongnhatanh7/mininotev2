//
//  mininotev2App.swift
//  mininotev2
//
//  Created by Truong Nhat Anh on 02/06/2022.
//

import SwiftUI

@main
struct mininotev2App: App {
    @StateObject private var myNotes = MyNotes()
    var body: some Scene {
        WindowGroup {
            ContentView(myNotes: myNotes)
        }
    }
}
