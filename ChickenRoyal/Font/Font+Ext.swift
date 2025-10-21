

import SwiftUI

extension Font {
    static let titan = "TitanOne"
}

extension Text {
    
    func Titan(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.custom(Font.titan, size: size))
            .foregroundStyle(color)
        
    }
    
    
    func SFBold(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
    
}

extension View {
    
    func Titan(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.custom(Font.titan, size: size))
            .foregroundStyle(color)
        
    }
    
    
    func SFBold(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .bold))
            .foregroundStyle(color)
    }
    
    func SFMedium(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .medium))
            .foregroundStyle(color)
    }
    
    func SFRegular(_ size: CGFloat = 20, color: Color = .white) -> some View {
        self
            .font(.system(size: size, weight: .regular))
            .foregroundStyle(color)
    }
    
}





