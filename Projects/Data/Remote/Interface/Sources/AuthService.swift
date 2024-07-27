import DomainAuthInterface
import ComposableArchitecture
import CoreNetworkInterface


struct AuthService: AuthServicable {
    func signInWithApple(identityToken: String) async throws -> DomainAuthInterface.SignIn {
        let endpoint = Endpoint<SignInResponseDTO>(path: "api/auth/login/apple", httpMethod: .post, bodyParameters: SignInRequestDTO(identityToken: identityToken))
        let response = try await NetworkProvider.shared.sendRequest(endpoint)
        return response.toEntity
            
    }
}


extension AuthServiceKey: DependencyKey {
    public static var liveValue: DomainAuthInterface.AuthServicable {
        AuthService()
    }
}

extension SignInResponseDTO {
    var toEntity: DomainAuthInterface.SignIn {
        .init(accessToken: accessToken, refreshToken: refreshToken, isProfileSet: isProfileSet)
    }
}
