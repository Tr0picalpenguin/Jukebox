//
//  PlaylistController.swift
//  StatefulJukebox
//
//  Created by Scott Cox on 5/16/22.
//

import Foundation

class PlaylistController {
    
    // MARK: - Singleton
    static let sharedInstance = PlaylistController()
    
    // MARK: - Source of Truth
    private(set) var playlists: [Playlist] = []
    
    // MARK: - Initializers
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD functions
    
    func createPlaylist(title: String) {
        let playlist = Playlist(title: title)
        playlists.append(playlist)
        saveToPersistentStore()
    }
    
    func updatePlaylist(playlistToUpdate: Playlist, title: String) {
        playlistToUpdate.title = title
        saveToPersistentStore()
    }
    
    func deletePlaylist(playlistToDelete: Playlist) {
        guard let index = playlists.firstIndex(of: playlistToDelete) else {return}
        playlists.remove(at: index)
        saveToPersistentStore()
    }

    // MARK: - Persistence
    func saveToPersistentStore() {
        guard let url = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: url)
        } catch let error {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = fileURL else {return}
        do {
            let data = try Data(contentsOf: url)
            let playlists = try JSONDecoder().decode([Playlist].self, from: data)
            self.playlists = playlists
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
    
    
    
    
    
    
    


