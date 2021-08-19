//
//  CircleImageView.swift
//  NameMe
//
//  Created by Antonio Vega on 8/12/21.
//

import SwiftUI

struct CircleImageView: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(image: Image("example"))
    }
}
