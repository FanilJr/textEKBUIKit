//
//  ImageViewController.swift
//  FromEKBCity
//
//  Created by Фаниль on 19.06.2024.
//

import UIKit

class ImageViewController: UIViewController {

    let viewModel: ImageViewModel
    
    let image: CustomImageView = {
        let image = CustomImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true
        return image
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.tintColor = .systemGreen
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGreen
        button.setTitle("скрыть NavBar", for: .normal)
        return button
    }()
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        image.loadImage(urlString: viewModel.image)
    }
    
    @objc private func tap() {
        guard let navigationController else { return }
        viewModel.hideNavBar(bar: navigationController)
        viewModel.hide ? button.setTitle("показать NavBar", for: .normal) : button.setTitle("скрыть NavBar", for: .normal)
        button.backgroundColor = viewModel.hide ? .systemRed : .systemGreen
    }
    
    @objc private func pinchMethod(_ sender: UIPinchGestureRecognizer) {
        guard let view = sender.view else { return }
        view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1.0
        switch sender.state {
        case .ended:
            UIView.animate(withDuration: 0.1) {
                view.transform = .identity
            }
        default:
            break
        }
    }
    
    private func layout() {
        [image,button].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.widthAnchor.constraint(equalTo: view.widthAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -40),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchMethod(_:)))
        image.addGestureRecognizer(gesture)
    }
}

#Preview("Image", traits: .defaultLayout, body: {
    let viewModel = ImageViewModel(image: "")
    let viewController = ImageViewController(viewModel: viewModel)
    return viewController
})
