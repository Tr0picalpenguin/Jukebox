//
//  Song Controller.swift
//  StatefulJukebox
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class SongController {
    
    // MARK: - Singleton
    static let sharedInstance = SongController()
    
    // MARK: - Source of Truth
    private(set) var songs: [Song] = []
    
    // MARK: - Initializers
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD functions
    
    func createSong(songTitle: String, artist: String) {
        let song = Song(songTitle: songTitle, artist: artist, songs: songs)
        songs.append(song)
        saveToPersistentStore()
    }
    
    func updateSong(songToUpdate: Song, songTitle: String) {
        songToUpdate.songTitle = songTitle
        saveToPersistentStore()
    }
    
    func deleteSong(songToDelete: Song) {
        guard let index = songs.firstIndex(of: songToDelete) else {return}
        songs.remove(at: index)
        saveToPersistentStore()
    }

    // MARK: - Persistence
    func saveToPersistentStore() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = fileURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let songs = try JSONDecoder().decode([Song].self, from: data)
            self.songs = songs
        } catch let error {
            print(error.localizedDescription)
        }
    }
        // Computed Property
        private var fileURL: URL? {
            // find the directory
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
            // Choose the url
            let url = documentsDirectory.appendingPathComponent("playlists.json")
            return url
        }
    } // End of Class
    
