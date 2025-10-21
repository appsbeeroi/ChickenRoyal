import SwiftUI

struct AddBirdView: View {
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var image: UIImage? = nil
    @State private var name: String = ""
    @State private var species: String = ""
    @State private var age: String = ""
    @State private var selectedState: StateBird? = nil
    @State private var isShowGallery: Bool = false
    
    @State private var editingIndex: Int? = nil
    var title: String = "Add bird"
    var buttonIsVisible: Bool = true
    var modelBird: ModelBird? = nil
    
    var body: some View {
        Background {
            VStack(spacing: 24) {
                header
                
                ScrollView {
                    addPhotoRectangle
                    inputFields
                    stateSelection
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                actionButtons
            }
            .padding(.vertical)
        }
        .addDoneButton()
        .onAppear{
            addData()
        }
        .sheet(isPresented: $isShowGallery) {
            CameraView { selectedImage in
                self.image = selectedImage
            }
        }
    }
}

extension AddBirdView {
    
    private func addData() {
        guard let model = modelBird else { return }
        image = model.image
        name = model.name
        species = model.species
        age = String(model.age)
        selectedState = model.state
        
        if let index = vm.catalog.firstIndex(where: { $0.id == model.id }) {
               editingIndex = index
           }
    }
    private var header: some View {
        ZStack {
            Text(title)
                .Titan(35, color: .black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            if buttonIsVisible {
                HStack {
                    BackButton()
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var addPhotoRectangle: some View {
        Button {
            isShowGallery = true
        } label: {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .overlay(
                        Image("addPhoto")
                            .resizable()
                            .scaledToFit()
                            .padding(40)
                    )
                    .cornerRadius(20)
                
                
            } else {
                Rectangle()
                    .fill(Color.white)
                    .scaledToFit()
                    .frame(height: 200)
                    .overlay(
                        Image("addPhoto")
                            .resizable()
                            .scaledToFit()
                            .padding(40)
                    )
                    .cornerRadius(20)
            }
        }
        
    }
    
    private var inputFields: some View {
        VStack(spacing: 16) {
            CustomTextField(placeholder: "Name", text: $name)
            CustomTextField(placeholder: "Species", text: $species)
            CustomTextField(placeholder: "Age", text: $age, keyboardType: .numberPad)
        }
        .padding(.horizontal)
    }
    
    private var stateSelection: some View {
        HStack(spacing: 0) {
            ForEach(StateBird.allCases, id: \.self) { state in
                BirdStateCard(state: state, isSelected: selectedState == state)
                    .onTapGesture {
                        selectedState = state
                    }
            }
        }
        .padding(.horizontal)
        .hLeading()
    }
    
    private var actionButtons: some View {
        CustomButton(text: "Save") {
            addBird()
            dismiss()
        }
        .padding(.horizontal)
        .disabled(!isFormValid)
    }
    
    func addBird() {
        let newBird = ModelBird(
            imageData: image?.jpegData(compressionQuality: 1.0) ?? UIImage(systemName: "photo")!.jpegData(compressionQuality: 1.0)!,
            name: name,
            species: species,
            age: Int(age) ?? 0,
            state: selectedState ?? .active
        )
        if let index = editingIndex {
                 vm.catalog[index] = newBird
             } else {
                 vm.catalog.append(newBird) 
             }
    }
    
    
    
    private var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !species.trimmingCharacters(in: .whitespaces).isEmpty &&
        !age.trimmingCharacters(in: .whitespaces).isEmpty &&
        image != nil &&
        selectedState != nil
    }
}




#Preview {
    AddBirdView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}

struct BirdStateCard: View {
    var state: StateBird
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image(state.textImage)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(7)
                .background(isSelected ? Color.white : Color.clear)
                .cornerRadius(20)
            
            Text(state.textImage)
                .Titan(16, color: .black)
        }
        
    }
}
