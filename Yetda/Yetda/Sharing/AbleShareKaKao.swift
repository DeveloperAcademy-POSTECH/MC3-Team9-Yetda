import UIKit
import KakaoSDKShare
import KakaoSDKTemplate
import KakaoSDKCommon

protocol ShareKaKao {
    func shareKaKao(_ target: UIViewController?, key: String, value: String, completeHandler: @escaping () -> ())
    func showAlert(_ target: UIViewController?, msg: String)
}
extension ShareKaKao {
    func shareKaKao(_ target: UIViewController? = nil, key: String, value: String, completeHandler: @escaping () -> ()) {
//        if let image = UIImage(named: "appstore") {
//            ShareApi.shared.imageUpload(image:image) {(imageUploadResult, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("imageUpload() success.")
//                    print(imageUploadResult)
//                }
//            }
//        }
        
        if ShareApi.isKakaoTalkSharingAvailable(){
            // key value
            let appLink = Link(iosExecutionParams: [key: value])
            let button = Button(title: "앱에서 보기", link: appLink)
            let content = Content(title: "선물",
                                  imageUrl: URL(string:"https://k.kakaocdn.net/dn/DbqW9/bl3IxWKFPKd/waz6ph8WvF99T4jPnowzR1/kakaolink40_original.png")!,
                                  description: "선물이 도착했습니다! 앱에서 확인 해보세요.",
                                  link: appLink)
            let template = FeedTemplate(content: content, buttons: [button])
            
            //메시지 템플릿 encode
            if let templateJsonData = (try? SdkJSONEncoder.custom.encode(template)) {
                //생성한 메시지 템플릿 객체를 jsonObject로 변환
                if let templateJsonObject = SdkUtils.toJsonObject(templateJsonData) {
                    ShareApi.shared.shareDefault(templateObject:templateJsonObject) {(linkResult, error) in
                        if let error = error {
                            print("error : \(error)")
                        }
                        else {
                            print("defaultLink(templateObject:templateJsonObject) success.")
                            guard let linkResult = linkResult else { return }
                            UIApplication.shared.open(linkResult.url, options: [:]) { openResult in
                                if openResult { // 카카오톡 열기 성공 시
                                    completeHandler()
                                } else { // 실패시
                                    showAlert(target, msg: "링크공유에 실패했습니다.")
                                }
                            }
                            
                        }
                    }
                }
            }
        }
        else {
            print("카카오톡 미설치")
            showAlert(target, msg: "카카오톡 미설치 디바이스")
        }
    }
    
    func showAlert(_ target: UIViewController? = nil, msg: String) {
        let alert = UIAlertController(title: "알림", message: msg, preferredStyle: UIAlertController.Style.alert)
        let defaultAction =  UIAlertAction(title: "default", style: UIAlertAction.Style.default)
        alert.addAction(defaultAction)
        target?.present(alert, animated: false)
    }
}
