//
//  ListRowView.swift
//  Checklist
//
//  Created by Brianne Byer on 26/3/2023.
//

import SwiftUI

struct ListRowView: View {
    @State var model: [Study]
    var body: some View {
        
        HStack {
            Text(task.course)
                .bold()
                .fixedSize()
            Text(task.task)
                .fixedSize()
            Spacer()
            Image(systemName: task.checkbox)
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(model: testStudy)
    }
}
