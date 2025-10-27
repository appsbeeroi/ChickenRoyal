

import SwiftUI


enum AppState {
    case load
    case main
}

final class ViewModel: ObservableObject {
    @Published var selectedView: AppState = .load
    
    
    @Published var catalog: [ModelBird] = [
    ] {
        didSet {
            UserDefaultsStorage.saveData(catalog, forKey: "catalog")
        }
    }
    
    @Published var transport: [TransModel] = [TransModel(date: Date(), destination: "Destination", resason: .sale, modelBird: ModelBird(imageData: Data(), name: "Name", species: "Specis", age: 12, state: .active))] {
        didSet{
            UserDefaultsStorage.saveData(transport, forKey: "transport")
        }
    }
    
    
    init(){
        if let savedCatalog: [ModelBird] = UserDefaultsStorage.loadData(forKey: "catalog") {
            catalog = savedCatalog
        }
        
        if let savedtransport: [TransModel] = UserDefaultsStorage.loadData(forKey: "transport") {
            transport = savedtransport
        }
    }
    
    
}


extension ViewModel {
    func clear(){
        transport = []
        catalog = []
    }
}

