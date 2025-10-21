import SwiftUI


struct UserDefaultsStorage {
    static func saveData<T: Codable>(_ data: T, forKey key: String) {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(data)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
        
        }
    }
    
    static func loadData<T: Codable>(forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
        
            return nil
        }
    }
}
