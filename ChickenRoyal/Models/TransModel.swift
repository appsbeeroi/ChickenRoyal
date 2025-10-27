import SwiftUI

struct TransModel: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var destination: String
    var resason: ReasonBird
    var modelBird: ModelBird
}
