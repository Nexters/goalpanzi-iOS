//
//  MissionInfoView.swift
//  FeatureHomeInterface
//
//  Created by Haeseok Lee on 8/4/24.
//

import SwiftUI
import SharedUtil
import ComposableArchitecture

public struct MissionInfoView: View {
    
    @Bindable private var store: StoreOf<MissionInfoFeature>
    @State private var scale = 0.5
    
    public init(store: StoreOf<MissionInfoFeature>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .transition(.opacity)
            
            VStack(spacing: 16) {
                Text("시작일까지 초대된 인원과\n경쟁이 자동으로 시작돼요!")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("경쟁인원은 최소 2명부터 최대 10명 입니다!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 16) {
                    ForEach(Array(["A", "Z", "1", "1"].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 50, height: 50)
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                }
                
                Button(action: {
                    // 친구 초대 코드 복사 액션
                }) {
                    Text("친구 초대 코드 복사")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    store.send(.didTapCloseButton)
                }) {
                    Text("닫기")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 40)
            .scaleEffect(scale)
            .animate(using: .spring(response: 0.3, dampingFraction: 0.8, blendDuration: 0)) {
                scale = 1.0
            }
        }
    }
}
