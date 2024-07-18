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
                let provider = try await NetworkProvider.shared.sendRequest(Test.test(RequestDTO()))
                print(provider)
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

struct RequestDTO: Encodable {
    
}

struct ResponseDTO: Decodable {
    let ip: String
}

struct Test {
    static func test(_ requestDTO: RequestDTO) -> Endpoint<ResponseDTO> {
        return Endpoint<ResponseDTO>(path: "http://ip.jsontest.com", httpMethod: HTTPMethod.get, bodyParameters: requestDTO)
    }
}

