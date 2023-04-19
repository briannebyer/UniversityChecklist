//
//  DetailTitleView.swift
//  Checklist
//
//  Created by Brianne Byer on 18/4/2023.
//

import SwiftUI

struct DetailTitleView: View {
    @State var titleName: String
    @State var titleCode: String
    var body: some View {
        VStack {
                Text(titleName)
                .font(.headline)
                .fontWeight(.bold)
                Text(titleCode)
                .font(.subheadline)
        }
    }
}
