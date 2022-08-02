//
//  OnBoardingFirstViewController.swift
//  Yetda
//
//  Created by Geunil Park on 2022/07/21.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import CryptoKit

class OnBoardingFirstViewController: UIViewController {
    
    private var currentNonce: String?
    
    private let leftSide: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.makeTitleLabel()
        self.makeSubtitleLabel1()
        self.makeSubtitleLabel2()
        self.makeOnBoardingImage()
        self.makeOnBoardingButton()
    }
    
    func makeTitleLabel() {
        let titleLabel = UILabel()
        
        titleLabel.text = "옜다!"
        titleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 30)
        titleLabel.textColor = UIColor(named: "YettdaMainBlue")
        
        self.view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 1.6).isActive = true
        
    }
    
    func makeSubtitleLabel1() {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = "소중한 사람에게"
        subTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
        
        self.view.addSubview(subTitleLabel)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 345).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeSubtitleLabel2() {
        let subTitleLabel = UILabel()
        
        subTitleLabel.text = "마음을 담아 선물하세요"
        subTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 25)
        
        self.view.addSubview(subTitleLabel)
        
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 382).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: leftSide).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        subTitleLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeOnBoardingImage() {
        let imageView: UIImageView
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: "OnBoardingView")
        
        self.view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: -1).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 1.6).isActive = true
    }
    
    func makeOnBoardingButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setImage(UIImage(systemName: "applelogo"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20, weight: .regular, scale: .default), forImageIn: .normal)
        button.setTitle("Sign in with Apple", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 4
        
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(moveToSecondView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func moveToSecondView() {
        startSignInWithAppleFlow()
        let userId: String? = Auth.auth().currentUser?.email
        guard let userId = userId else { return }

        UserDefaults.standard.set(userId, forKey: "UserId")
        let pageViewController = self.parent as! OnBoardingViewController
        pageViewController.goToNextPage(index: 1)
    }
}

extension OnBoardingFirstViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
            }
        }
    }
}

//Apple Sign in
extension OnBoardingFirstViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension OnBoardingFirstViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
