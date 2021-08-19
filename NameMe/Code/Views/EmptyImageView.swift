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
                .foregroundColor(.gray)
                .opacity(0.5)
            
            Text("Add Image")
                .font(.title2)
                .foregroundColor(.white)
        }
        .frame(width: width, height: width)
    }
}

struct EmptyImageView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyImageView(width: UIScreen.main.bounds.width)
    }
}
