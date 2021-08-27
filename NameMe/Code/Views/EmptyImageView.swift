//
//  EmptyImageView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/19/21.
//

import SwiftUI

struct EmptyImageView: View {
    let width: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.secondary)
                .opacity(0.5)
            
            Text("Add Image")
                .font(.title3)
                .foregroundColor(.white)
                .opacity(0.8)
        }
        .frame(width: width, height: width)
    }
}

struct EmptyImageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImageView(width: UIScreen.main.bounds.width)
    }
}
