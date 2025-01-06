//
//  Settings.swift
//  Traffic light
//
//  Created by Serhii Prysiazhnyi on 06.01.2025.
//

import Foundation

enum KeysUserDefaults {
    static let settingsGame = "settingsGame"
    static let recordGame = "recordGame"
}

struct SettingsGame : Codable {
    var timeForRedLight: Int
    var timeForYellowLight: Int
    var timeForGreenLight: Int
}

class Settings {
    
    static var shared = Settings()
    
    private let defaultSettings = SettingsGame(timeForRedLight: 7, timeForYellowLight: 6, timeForGreenLight: 5)
    var currentSettings : SettingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsGame) as? Data {
                do {
                    let decodedSettings = try PropertyListDecoder().decode(SettingsGame.self, from: data)
                    return decodedSettings
                } catch {
                    print("Ошибка декодирования настроек: \(error)")
                    return defaultSettings
                }
                
            }else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsGame)
            }
        }
    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
}
