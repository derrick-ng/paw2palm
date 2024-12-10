//
//  TitleView.swift
//  paw2palm
//
//  Created by Derrick Ng on 12/8/24.
//

import SwiftUI

//do i just change this to TitleView????
struct TitleComponent: View {
    var body: some View {
        VStack{
            Image(.IMG_7588)
                .resizable()
                .scaledToFit() // Maintain aspect ratio
                .frame(width: 70, height: 70) // Set a small size for the image
                .alignmentGuide(.leading) { _ in 0 } // Align to the leading (left)
                .alignmentGuide(.top) { _ in 0 } // Align to the top
         
            
        }

//add styling
    }
}
