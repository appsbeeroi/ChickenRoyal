
import SwiftUI

struct CatalogView: View {
    @State private var selectedCategory: StateBird = .active
    @EnvironmentObject private var vm: ViewModel
    @State private var isDirectNavigation: Bool = false
    @State private var isOpenEditor: Bool = false
    @State private var selectedIndex: Int? = nil
    var body: some View {
        Background {
            VStack {
                header
                if vm.catalog.isEmpty {
                    emptyCatalog
                }else {
                    notEmptyCatalog
                }
                
            Spacer()
            }
        }
        .navigationDestination(isPresented: $isDirectNavigation) {
            AddBirdView().navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $isOpenEditor) {
            if let index = selectedIndex {
                 InfoBird(birdIndex: index)
                  
                     .navigationBarBackButtonHidden()
             }
           
        }
    }
}

#Preview {
    CatalogView()
    
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
        
}


extension CatalogView {
    private var header: some View {
        Text("Catalogue \nof birds")
            .Titan(35,color: .black)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding(.vertical, 24)
    }
    
    
    private var emptyCatalog: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .scaledToFit()
            .overlay {
                VStack {
                    Image("empty")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 60)
                        .frame(height: 150)
                    
                    
                    Text("For now it is empty, as in a new chicken coop")
                        .Titan(18, color: .black)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                    
                    CustomButton(text: "Add bird") {
                        isDirectNavigation = true
                    }
                    
                }
                .padding()
            }
            .padding(50)
    }
    
    @ViewBuilder
    private var notEmptyCatalog: some View {
        VStack {
            HStack {
                ForEach(StateBird.allCases, id: \.self) {item in
                    Button {
                        selectedCategory = item
                    }label: {
                        ChooseButton(state: item, color: selectedCategory == item ? Color(hex: "FFAD15") : .white)
                    }
                
                }
            }
            
       
                ScrollView {
                    LazyVStack {
                        ForEach(vm.catalog.filter { $0.state == selectedCategory }, id: \.id) { item in
                            BirdCard(
                                model: ModelBird(
                                    imageData: item.imageData,
                                    name: item.name,
                                    species: item.species,
                                    age: item.age,
                                    state: item.state
                                )
                            )
                            .onTapGesture {
                                if let index = vm.catalog.firstIndex(where: { $0.id == item.id }) {
                                                selectedIndex = index
                                                isOpenEditor = true
                                            }
                            }
                    }
                }
            }
            
            CustomButton(text: "Add bird") {
                isDirectNavigation = true
            }
        }
        .padding(.horizontal, 16)
    }
    
    
    struct ChooseButton: View {
        let state: StateBird
        let color: Color
        var body: some View {
            RoundedRectangle(cornerRadius: 14)
                .fill(color)
                .overlay {
                    HStack {
                        Image(state.textImage)
                            .resizable()
                            .scaledToFit()
                            .padding(.vertical, 6)
                        Text(state.textImage)
                            .Titan(17, color: .black)
                            .minimumScaleFactor(0.3)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 2)
                }
                .frame(maxWidth: .infinity, maxHeight: 46)
        }
    }
}


