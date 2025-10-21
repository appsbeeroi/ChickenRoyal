import SwiftUI

struct AddCarriage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: ViewModel
    @State private var indexMenu: Int = 0
    @State private var selectedDate: Date? = nil
    @State private var destination: String = ""
    @State private var selectedReason: ReasonBird? = nil
    @State private var showCalendar: Bool = false
    
    @State private var selectedCard: ModelBird? = nil
    var title: String = "Add carriage"
    var buttonIsVisible: Bool = true
    var modelBird: ModelBird? = nil
    
    var editMode: Bool = false
    var transportIndex: Int? = nil
    var existingTransport: TransModel? = nil
    
    var body: some View {
        ZStack {
            Background {
                VStack(spacing: 16) {
                    if buttonIsVisible {
                        header
                    }
                    
                    if indexMenu == 0 {
                        scrollContent
                    } else {
                        finishAdd
                    }
                    
                   
                }
            }
            
            if showCalendar {
                calendarView
            }
        }
        .onAppear {
            if let existingTransport {
                selectedCard = existingTransport.modelBird
                destination = existingTransport.destination
                selectedReason = existingTransport.resason
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                if let parsedDate = formatter.date(from: existingTransport.date) {
                    selectedDate = parsedDate
                }
                indexMenu = 1
            }
        }
        
    }
}


extension AddCarriage {
    
    private var calendarView: some View {
        ZStack {
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    showCalendar = false
                }
            
            VStack(spacing: 16) {
                
                DatePicker(
                    "",
                    selection: Binding(
                        get: { selectedDate ?? Date() },
                        set: { selectedDate = $0 }
                    ),
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .labelsHidden()
                
                
                Button(action: {
                    
                    if selectedDate == nil {
                        selectedDate = Date()
                    }
                    showCalendar = false
                }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }               }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            .padding(32)
            .preferredColorScheme(.light)
        }
        .animation(.easeInOut, value: showCalendar)
        .transition(.opacity)
    }
    
    
    private var header: some View {
        ZStack {
            Text(title)
                .Titan(35, color: .black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            HStack {
                BackButton()
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    
    private var scrollContent: some View {
            VStack(alignment: .leading){
                Text("Choose a bird")
                    .Titan(20, color: .black)
                ScrollView {
                    LazyVStack {
                        ForEach(vm.catalog , id: \.id) {item in
                            BirdCard(
                                model: item,
                                withButton: true,
                                isSelected: selectedCard == item ? true : false
                            )
                            .onTapGesture {
                                selectedCard = item
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                
                CustomButton(text: "Next") {
                   indexMenu = 1
                }
                .disabled(selectedCard == nil)
           
            }
            .padding(.horizontal)
        }
    
    private func updateTransport() {
        guard let index = transportIndex,
              let model = selectedCard else { return }
        
        vm.transport[index] = TransModel(
            id: vm.transport[index].id,
            date: selectedDate != nil ? formattedDate(selectedDate!) : "Date",
            destination: destination,
            resason: selectedReason ?? .sale,
            modelBird: model
        )
    }
    private var finishAdd: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Bird")
                .Titan(20, color: .black)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    VStack(spacing: 16) {
                        if let card = selectedCard {
                            BirdCard(model: card, withButton: true, isSelected: true)
                        }
                       
                        
                        
                        Button {
                            showCalendar = true
                        }label: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .overlay{
                                    HStack {
                                        Text(selectedDate != nil ? formattedDate(selectedDate!) : "Date")
                                            .Titan(16, color: .black)
                                        
                                        Spacer()
                                        
                                        
                                        Image("calendar")
                                            .resizable()
                                            .scaledToFit()
                                        
                                    }
                                    .padding()
                                }
                                .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                            
                            
                        }
                        
                        
                        
                        CustomTextField(placeholder: "Destination", text: $destination)
                        
                        
                        VStack {
                            Text("Reason")
                                .Titan(18, color: .black)
                                .hLeading()
                            
                            HStack(spacing: 0) {
                                ForEach(ReasonBird.allCases, id: \.self) { state in
                                    Spacer()
                                    BirdStateCar(state: state, isSelected: selectedReason == state)
                                        .onTapGesture {
                                            selectedReason = state
                                        }
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        
                        
                    }
                    
                    
                }
            }
            .scrollIndicators(.hidden)
            
            CustomButton(text: "Save") {
                if editMode {
                        updateTransport()
                    } else {
                        addTransport()
                    }
                dismiss()
            }
            .disabled(!isValid)
        }
        .padding(.horizontal)
    }
    
    private var isValid: Bool {
        selectedDate != nil &&
        !destination.isEmpty &&
        selectedReason != nil
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    struct BirdStateCar: View {
        var state: ReasonBird
        var isSelected: Bool
        
        var body: some View {
            VStack(spacing: 8) {
                Image(state.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding(7)
                    .background(isSelected ? Color.white : Color.clear)
                    .cornerRadius(20)
                
                Text(state.imageName)
                    .Titan(16, color: .black)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
            }
          
        }
    }

    private func addTransport() {
        guard let model = selectedCard else { return }
        vm.transport.append(
            TransModel(
                date: selectedDate != nil ? formattedDate(selectedDate!) : "Date",
                destination: destination,
                resason: selectedReason ?? .sale,
                modelBird: model
            )
        )
    }
    
}


#Preview {
    AddCarriage()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}


enum ReasonBird: CaseIterable, Codable {
    case veterinary
    case sale
    case exhibition
    
    var imageName: String {
        switch self {
        case .veterinary:
            return "Veterinary"
        case .sale:
            return "Sale"
        case .exhibition:
            return "Exhibition"
        }
    }
}


