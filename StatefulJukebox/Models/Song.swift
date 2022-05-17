//
//  Song.swift
//  StatefulJukebox
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class Song: Codable {
    
    let id: UUID
    var songTitle: String
    var artist: String
    var songs: [Song]
    
    init(id: UUID = UUID(), songTitle: String, artist: String, songs: [Song]) {
        self.id = id
        self.songTitle = songTitle
        self.artist = artist
        self.songs = songs
    }
    
} // End of Class
extension Song: Equatable {
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id
    }
}
