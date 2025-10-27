import SwiftUI

struct StatisticsView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    @State private var selectedDateType: DateTypes = .year
    
    var filteredTransport: [TransModel] {
        let calendar = Calendar.current
        let component: Calendar.Component = switch selectedDateType {
            case .week:
                    .day
            case .month:
                    .month
            case .year:
                    .year
        }
        
        let prevDate = calendar.date(
            byAdding: component,
            value: selectedDateType == .week ? -7 : -1,
            to: Date()
        ) ?? Date()
        
        return vm.transport.filter { $0.date > prevDate }
    }
    
    var mostFrequentDestination: (destination: String, count: Int)? {
        let grouped = Dictionary(grouping: filteredTransport, by: { $0.destination })
        let sorted = grouped.sorted { $0.value.count > $1.value.count }
        if let mostFrequent = sorted.first {
            return (mostFrequent.key, mostFrequent.value.count)
        }
        return nil
    }
    
    var topBirdSpecies: [(species: String, count: Int)] {
        let grouped = Dictionary(grouping: filteredTransport, by: { $0.modelBird.species })
        let sorted = grouped.sorted { $0.value.count > $1.value.count }
        return Array(sorted.prefix(3)).map { ($0.key, $0.value.count) }
    }
    
    var body: some View {
        Background {
            VStack {
                chickenHeader
                
                if vm.transport.isEmpty {
                    emptyStatistics
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 13) {
                            tripNumber
                            frequentDestination
                            birdSpacies
                        }
                        .padding(.top, 5)
                        .padding(.horizontal, 35)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var chickenHeader: some View {
        Text("Reports &\nStatistics")
            .Titan(35,color: .black)
    }
    
    private var emptyStatistics: some View {
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
                    
                    
                    Text("There’s nothing here yet...")
                        .Titan(18, color: .black)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.5)
                }
                .padding()
            }
            .padding(50)
    }
    
    private var tripNumber: some View {
        VStack(spacing: 14) {
            Text("Total number of trips")
                .Titan(18, color: .black)
            
            HStack(spacing: 16) {
                ForEach(DateTypes.allCases) { type in
                    Button {
                        selectedDateType = type
                    } label: {
                        Text(type.rawValue)
                            .Titan(18,
                                   color: selectedDateType == type ?
                                   Color(hex: "FFAD15") :
                                    Color(hex: "230000").opacity(0.5))
                    }
                }
            }
            
            Text(filteredTransport.count.formatted())
                .Titan(48, color: .black)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.white)
        .cornerRadius(25)
    }
    
    private var frequentDestination: some View {
        VStack(spacing: 10) {
            Text("Most frequent destinations")
                .Titan(18, color: .black)
            
            if let data = mostFrequentDestination {
                HStack {
                    Text(data.destination)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .Titan(14, color: Color(hex: "808080"))
                    
                    Text("\(data.count) times")
                        .Titan(18, color: .black)
                }
            } else {
                Text("No frequent destinations yet")
                    .Titan(14, color: Color(hex: "808080"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(.white)
        .cornerRadius(25)
    }
    
    private var birdSpacies: some View {
        VStack(spacing: 10) {
            Text("Bird species")
                .Titan(18, color: .black)
            
            HStack {
                ForEach(topBirdSpecies, id: \.species) { spacieTupple in
                    VStack {
                        Text(spacieTupple.species)
                            .Titan(14, color: Color(hex: "808080"))
                        
                        Text(spacieTupple.count.formatted())
                            .Titan(36, color: .black)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(.white)
        .cornerRadius(25)
    }
}

#Preview {
    StatisticsView()
        .environmentObject(ViewModel())
}

enum DateTypes: String, Identifiable, CaseIterable {
    var id: Self { self }
    
    case week = "Week"
    case month = "Month"
    case year = "Year"
}
