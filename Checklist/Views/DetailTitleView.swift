//
//  DetailTitleView.swift
//  Checklist
//
//  Created by Brianne Byer on 18/4/2023.
//

import SwiftUI

struct DetailTitleView: View {
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
