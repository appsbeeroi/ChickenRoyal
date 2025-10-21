import SwiftUI

struct BirdCard: View {
    let model: ModelBird
    var withButton: Bool = false
    var isSelected: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .overlay(alignment: .leading) {
                HStack {
                    Image(uiImage: model.image ?? UIImage(named: "test")!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipped()
                        .cornerRadius(10)
                        .padding(6)
                    VStack(alignment: .leading) {
                        Text(model.name)
                            .Titan(20, color: .black)
                            .minimumScaleFactor(0.5)
                        Spacer()
                        Text(model.species)
                            .Titan(11, color: .black)
                            .opacity(0.5)
                        Spacer()
                        Text("Age: \(model.age)")
                            .Titan(15, color: .black)
                            .minimumScaleFactor(0.5)
                    }
                    .padding(.vertical, 6)
                    
                    Spacer()
                    
                    if withButton {
                        Circle()
                            .stroke(Color(hex: "F3B142"), lineWidth: 2)
                            .frame(width: 30, height: 30)
                            .overlay {
                                if isSelected {
                                    Circle()
                                        .fill(Color(hex: "F3B142"))
                                        .frame(width: 18, height: 18)
                                }
                            }
                            .padding(.trailing, 10)
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 84, maxHeight: 84)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        BirdCard(model: ModelBird(
            imageData: UIImage(named: "test")!.jpegData(compressionQuality: 1.0)!,
            name: "Bella",
            species: "Parrot",
            age: 2,
            state: .active
        ), withButton: true, isSelected: true)
        .padding()
    }
}
