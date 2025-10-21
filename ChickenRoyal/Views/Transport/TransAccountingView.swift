

import SwiftUI

struct TransAccountingView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var isDirectNavigation: Bool = false
    @State private var isOpenEditor: Bool = false
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        Background {
            VStack {
                header
                
                if vm.transport.isEmpty {
                    emptyContent
                } else {
                    notEptyContent
                }
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $isDirectNavigation) {
            AddCarriage().navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $isOpenEditor) {
            if let index = selectedIndex {
                EditTransport(birdIndex: index).navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    TransAccountingView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}


extension TransAccountingView {
    
    private var header: some View {
        Text("Transport \naccounting")
            .Titan(35, color: .black)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding(.vertical, 24)
    }
    
    private var emptyContent: some View {
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
                    
                    Spacer()
                    Text("No bird has yet traveled")
                        .Titan(18, color: .black)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                    Spacer()
                    CustomButton(text: "Add carriage") {
                        isDirectNavigation = true
                    }
                    
                }
                .padding()
            }
            .padding(50)
    }
    
    
    private var notEptyContent: some View {
        VStack{
            ScrollView{
                LazyVStack {
                    ForEach(vm.transport, id: \.id) {item in
                        CardTransporting(transport: item)
                            .onTapGesture {
                                if let index = vm.transport.firstIndex(where: { $0.id == item.id }) {
                                                selectedIndex = index
                                                isOpenEditor = true
                                            }
                            }
                        
                    }
                }
            }
            
            CustomButton(text: "Add carriage") {
                isDirectNavigation = true
            }
            .padding(.horizontal)
        }
    }
    
}


struct CardTransporting: View {
    let transport: TransModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .overlay(alignment: .leading){
                HStack {
                    Image(transport.resason.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(.vertical, 9)
                    
                    VStack(alignment: .leading ){
                        HStack {
                            Image(uiImage: transport.modelBird.image ?? UIImage(named: "test")!)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 25)
                                .cornerRadius(17)
                                .clipped()
                            Text(transport.modelBird.name)
                                .Titan(15,color: .black)
                        }
                        
                        HStack {
                            Image("calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 17)
                            Text(transport.date)
                                .Titan(15,color: .black)
                        }
                    }
                }
                .padding(.leading, 7)
            }
            .frame(maxWidth: .infinity, minHeight: 92, maxHeight: 92)
            .padding(.horizontal, 16)
    }
}
