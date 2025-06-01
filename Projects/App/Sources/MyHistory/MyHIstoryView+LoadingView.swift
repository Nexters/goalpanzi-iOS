//
//  MyHIstoryView+LoadingView.swift
//  MissionMate
//
//  Created by Haeseok Lee on 6/1/25.
//

import SwiftUI

extension MyHistoryView {
    
    struct LoadingView: View {
        
        @ViewBuilder
        var body: some View {
            VStack {
                ProgressView()
                    .controlSize(.regular)
                    .progressViewStyle(.circular)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
