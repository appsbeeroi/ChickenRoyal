

import SwiftUI

struct EditTransport: View {
    @EnvironmentObject private var vm: ViewModel
 
    @Environment(\.dismiss) private var dismiss
    @State private var isShowAlert: Bool = false
    @State private var isShowSheet: Bool = false
    let birdIndex: Int
    
    private var model: TransModel? {
        guard vm.transport.indices.contains(birdIndex) else { return nil }
        return vm.transport[birdIndex]
    }
    
    
    var body: some View {
        Background {
            VStack {
                buttons
                
                ScrollView {
                    VStack {
                        if let model = model {
                            
                            Text("Bird")
                                .Titan(20 ,color: .black)
                                .hLeading()
                                .padding(.horizontal)
                            BirdCard(model: model.modelBird, withButton: true, isSelected: true).padding(.horizontal)
                            
                            VStack(alignment: .leading, spacing: 10){
                                HStack {
                                    Image("calendar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 20)
                                    Text("Date")
                                        .Titan(14,color: .black).opacity(0.5)
                                    
                                    Spacer()
                                    
                                    Text(model.date.formatted(.dateTime.year().month(.twoDigits).day()))
                                        .Titan(20,color: .black)
                                }
                                
                                Text("Destination")
                                    .Titan(14,color: .black).opacity(0.5)
                                
                                Text(model.destination)
                                    .Titan(20,color: .black)
                                
                                Text("Reason")
                                    .Titan(14,color: .black).opacity(0.5)
                                
                                Image(model.resason.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 80)
                                Text(model.resason.imageName)
                                    .Titan(15,color: .black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert(isPresented: $isShowAlert) {
            callAlert
        }
        .sheet(isPresented: $isShowSheet) {
            AddCarriage(
                buttonIsVisible: false,
                editMode: true,
                transportIndex: birdIndex,
                existingTransport: model
            )
        }
    }
}

#Preview {
    EditTransport(birdIndex: 0)
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}


extension EditTransport {
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
            message: Text("Are you sure you want to get rid of this shipment?"),
            primaryButton: .destructive(Text("Delete")) {
                deleteBirdSafelyAndDismiss()
            },
            secondaryButton: .cancel(Text("Cancel"))
        )
    }
    
    private func deleteBirdSafelyAndDismiss() {
        let bird =  vm.transport[birdIndex]
        
        if let index =  vm.transport.firstIndex(where: { $0.id == bird.id }) {
            vm.transport.remove(at: index)
            DispatchQueue.main.async {
                dismiss()
            }
        }
    }
}
