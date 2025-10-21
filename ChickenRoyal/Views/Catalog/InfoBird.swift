

import SwiftUI

struct InfoBird: View {
    @EnvironmentObject private var vm: ViewModel
     let birdIndex: Int

    @State private var isShowAlert: Bool = false
    @State private var isShowSheet: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    private var model: ModelBird? {
        guard vm.catalog.indices.contains(birdIndex) else { return nil }
        return vm.catalog[birdIndex]
    }
    
    var body: some View {
        Background{
            VStack {
                buttons
                scrollContent

//                CustomButton(text: "Mark as archived") {
//                    
//                }
//                .padding(.horizontal)
            }
        }
        .alert(isPresented: $isShowAlert) {
            callAlert
        }
        .sheet(isPresented: $isShowSheet) {
            AddBirdView(title: "Edit bird", buttonIsVisible: false, modelBird: model)
        }
    }
}

#Preview {
    let vm = ViewModel()

    vm.catalog.append(
        ModelBird(
            imageData: UIImage(named: "test")!.jpegData(compressionQuality: 1.0)!,
            name: "Bella",
            species: "Husk of Sussex",
            age: 2,
            state: .active
        )
    )
    
    return InfoBird(birdIndex: 0)
        .environmentObject(vm)
}


extension InfoBird {
    private var scrollContent: some View {
            ScrollView {
                VStack {
                    if let model = model {
                        Image(uiImage: model.image ?? UIImage(named: "test")!)
                            .resizable()
                               .scaledToFill()
                               .frame(maxWidth: .infinity)
                               .clipped()
                               .cornerRadius(17)
                        
                        RoundedRectangle(cornerRadius: 17)
                            .fill(.white)
                            .overlay {
                                VStack(spacing: 10) {
                                    Image(model.state.textImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 48)
                                        .hLeading()
                                    
                                    Text(model.name)
                                        .Titan(25, color: .black)
                                        .hLeading()
                                    
                                    HStack {
                                        Text("Species")
                                            .Titan(14, color: .black).opacity(0.5)
                                        Spacer()
                                        Text(model.species)
                                            .Titan(20, color: .black)
                                    }
                                    
                                    HStack {
                                        Text("Age")
                                            .Titan(14, color: .black).opacity(0.5)
                                        Spacer()
                                        Text("\(model.age) years")
                                            .Titan(20, color: .black)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
            }
        }
    
    private var buttons: some View {
        HStack(spacing: 20){
            BackButton()
                .hLeading()
            ImagButton(image: "pencil") {
                isShowSheet = true
            }
            ImagButton(image: "trash") {
                isShowAlert = true
            }
            
        }
        .padding(.horizontal)
    }

    
    private var callAlert: Alert {
        Alert(
            title: Text("Delete"),
            message: Text("Are you sure you want to get rid of this chicken?"),
            primaryButton: .destructive(Text("Delete")) {
                deleteBirdSafelyAndDismiss()
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }
    
    private func deleteBirdSafelyAndDismiss() {
        let bird = vm.catalog[birdIndex]
        
        if let index = vm.catalog.firstIndex(where: { $0.id == bird.id }) {
            vm.catalog.remove(at: index)
            DispatchQueue.main.async {
                dismiss()
            }
        }
    }
    
}

struct ImagButton: View {
    let image: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        }label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 42)
        }
    }
}
