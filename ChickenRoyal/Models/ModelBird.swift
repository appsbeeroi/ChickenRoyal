import SwiftUI

struct ModelBird: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var imageData: Data
    var name: String
    var species: String
    var age: Int
    var state: StateBird
    
    var image: UIImage? {
        get {
            UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0) ?? Data()
        }
    }
    static func == (lhs: ModelBird, rhs: ModelBird) -> Bool {
          lhs.id == rhs.id
      }
}

enum StateBird: String, Codable, CaseIterable {
    case active
    case archival
    
    var textImage: String {
        switch self {
        case .active:
            return "Active"
        case .archival:
            return "Archival"
        }
    }
}
