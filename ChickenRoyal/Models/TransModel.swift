
import SwiftUI

struct TransModel: Identifiable, Codable {
    var id = UUID()
    var date: String
    var destination: String
    var resason: ReasonBird
    var modelBird: ModelBird
}
