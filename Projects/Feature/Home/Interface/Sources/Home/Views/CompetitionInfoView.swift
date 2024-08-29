//
//  CompetitionInfoView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/15/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

struct CompetitionInfoView: View {
    
    let store: StoreOf<HomeFeature>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(store.competition?.info[.title] ?? "")
                .font(.pretendard(kind: .heading_md, type: .bold))
                .foregroundStyle(SharedDesignSystemAsset.Colors.gray1.swiftUIColor)
            Text(store.competition?.info[.subtitle] ?? "")
                .font(.pretendard(kind: .body_lg, type: .bold))
                .foregroundColor(SharedDesignSystemAsset.Colors.gray2.swiftUIColor)
        }
        .padding(.top, 28)
        .padding(.bottom, 16)
    }
}
