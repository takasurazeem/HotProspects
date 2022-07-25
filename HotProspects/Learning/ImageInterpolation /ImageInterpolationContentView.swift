//
//  ImageInterpolationContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI

struct ImageInterpolationContentView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ImageInterpolationContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationContentView()
    }
}
