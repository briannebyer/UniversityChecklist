//
//  TitleView.swift
//  Checklist
//
//  Created by Brianne Byer on 23/3/2023.
//

import SwiftUI

struct TitleView: View {
    @State var title: String
    @State var img: String
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .bold()
                .padding()
            Image(systemName: img)
                .imageScale(.large)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "University Tasks", img: "book")
    }
}
