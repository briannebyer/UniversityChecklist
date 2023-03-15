//
//  ListRowView.swift
//  Checklist
//
//  Created by Brianne Byer on 15/3/2023.
//

import SwiftUI

struct ListRowView: View {
    var item: [String]
    var body: some View {
        HStack{
            Text(item[0]).bold().fixedSize()
            Text(item[1]).fixedSize()
            Spacer()
            Image(systemName:item[2])
        }
    }
}
