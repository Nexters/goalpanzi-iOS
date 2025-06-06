//
//  MyHistoryView+FooterView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 6/1/25.
//

import SwiftUI

extension MyHistoryView {
    
    struct FooterView: View {
        
        let size: CGSize
        @State var progressViewID: UUID = .init()
        
        @ViewBuilder
        var body: some View {
            VStack {
                ProgressView()
                    .controlSize(.regular)
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
                    .id(progressViewID)
                    .onDisappear {
                        progressViewID = .init()
                    }
            }
            .frame(width: size.width, height: 100)
        }
    }
}
