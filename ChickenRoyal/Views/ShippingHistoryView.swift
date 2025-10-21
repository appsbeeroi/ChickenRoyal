
import SwiftUI

struct ShippingHistoryView: View {
    @EnvironmentObject private var vm: ViewModel
    @State private var text: String = ""
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        Background{
            VStack {
                header
                if vm.transport.isEmpty {
                    emptyContent
                }else {
                    notEmptyContent
                }
                
              Spacer()
            }
        }
    }
}

#Preview {
    ShippingHistoryView()
        .wrappedInNavigation()
        .withAutoPreviewEnvironment()
}


extension ShippingHistoryView {
    
    private var header: some View {
        Text("Shipping \nhistory")
            .Titan(35, color: .black)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding(.vertical, 24)
    }
    
    
    private var notEmptyContent: some View {
        VStack(spacing: 20){
            SearchBar(text: $text, isFocused: $isFocused)
                .padding(.horizontal, 16)
            ScrollView {
                LazyVStack {
                    ForEach(filteredTransport, id: \.id) { item in
                        CardTransporting(transport: item)
                    }
                
                    if filteredTransport.isEmpty {
                        Text("No results found")
                            .Titan(18, color: .gray)
                            .padding()
                    }
                }
              
            }
            .scrollIndicators(.hidden)
        }
      
    }
    
    @ViewBuilder
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
                    Text("The story is as clean as a fresh page")
                        .Titan(18, color: .black)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                    Spacer()
   
                    
                }
                .padding()
            }
            .padding(50)
    }
    
    struct SearchBar: View {
        @Binding var text: String
        
        @FocusState.Binding var isFocused: Bool
        
        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.trailing, 20)
                    .padding(.leading, 8)
                
                TextField("", text: $text)
                    .Titan(20, color: .black)
                    .placeholder(when: text.isEmpty) {
                        Text("Search by name or date")
                            .Titan(20, color: .black).opacity(0.4)
                    }
                    .padding(.trailing)
                    .padding(.vertical, 12)
                    .focused($isFocused)
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                        isFocused = false 
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 8)
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.2), value: text)
                }
                
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.white))
            )
        }
    }
    
    private var filteredTransport: [TransModel] {
         if text.isEmpty {
             return vm.transport
         } else {
             return vm.transport.filter { item in
                 let lowercasedText = text.lowercased()
                 return item.modelBird.name.lowercased().contains(lowercasedText)
                 || item.date.lowercased().contains(lowercasedText)
             }
         }
     }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}
