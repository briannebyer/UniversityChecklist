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
                Spacer()
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                Image(systemName: img)
                    .padding()
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "University Tasks", img: "book")
    }
}
