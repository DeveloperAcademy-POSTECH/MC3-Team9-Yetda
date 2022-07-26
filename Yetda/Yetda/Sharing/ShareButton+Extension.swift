import UIKit

extension UIViewController {
    func configureShareButton(_ target: Any?, action: Selector) -> UIButton {
        let shareButton = UIButton()
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.setPreferredSymbolConfiguration(.init(pointSize: 22, weight: .regular), forImageIn: .normal)
        self.view.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.widthAnchor.constraint(equalToConstant: 42),
            shareButton.heightAnchor.constraint(equalToConstant: 42),
        ])
        shareButton.backgroundColor = .white.withAlphaComponent(0.8)
        shareButton.layer.cornerRadius = 5
        shareButton.addTarget(target, action: action, for: .touchUpInside)
        return shareButton
    }
}
