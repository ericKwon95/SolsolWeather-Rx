//
//  ViewController.swift
//  WeatherAppRx
//
//  Created by 권승용 on 2023/03/06.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Weather"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30)
        label.textColor = UIColor(named: "mainTextColor")
        return label
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupLayout()
        setupConstraints()
    }

    func setupStyle() {
        self.view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func setupLayout() {
        view.addSubview(weatherLabel)
    }
    
    func setupConstraints() {
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.widthAnchor.constraint(equalToConstant: 125).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}


// MARK: - 프리뷰 기능
#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
}

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable().previewDisplayName("iPhone 14")
    }
}
#endif
