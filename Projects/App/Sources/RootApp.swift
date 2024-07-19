import SwiftUI
import CoreNetwork
import CoreNetworkInterface
import SharedThirdPartyLib
import Alamofire

@main
struct MissionMateApp: App {
  var body: some Scene {
    WindowGroup {
        ContentView().onAppear(perform: {
            Task {
                let response = try await NetworkProvider.shared.sendRequest(Test.test())
                print(response)
            }
        })
    }
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      Text("Hello, world!")
    }
  }
}


struct ResponseDTO: Decodable {
    let ip: String
}

struct Test {
    static func test(_ requestDTO: Encodable = EmptyRequest()) -> Endpoint<ResponseDTO> {
        return Endpoint<ResponseDTO>(path: "http://ip.jsontest.com", httpMethod: HTTPMethod.get, queryParameters: requestDTO)
    }
}
