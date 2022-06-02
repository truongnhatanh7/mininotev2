//
//  MyNotes.swift
//  mininotev2
//
//  Created by Truong Nhat Anh on 02/06/2022.
//

import Foundation

class MyNotes: ObservableObject {
    @Published var folders = [Folder]()
}

struct Folder: Identifiable {
    var id = UUID()
    var name: String
    var notes: [Note] = testNotes
}


struct Note: Identifiable {
    var id = UUID()
    var title: String
    var noteText: String = ""
}

var testFolders = [
    Folder(name: "Folder 1"),
    Folder(name: "Folder 2")
]

var testNotes = [
    Note(title: "Note 1"),
    Note(title: "Note 2")
]
