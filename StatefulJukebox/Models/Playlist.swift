//
//  Playlist.swift
//  StatefulJukebox
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class Playlist: Codable {
    
    let id: UUID
    var title: String
    var playlists: [Playlist]
    
    init(id: UUID = UUID(), title: String, playlists: [Playlist] = []) {
        self.id = id
        self.title = title
        self.playlists = playlists
    }
    
} // End of Class

extension Playlist: Equatable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.id == rhs.id
    }
}
