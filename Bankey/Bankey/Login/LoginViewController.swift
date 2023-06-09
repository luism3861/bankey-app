//
//  ViewController.swift
//  Bankey
//
//  Created by Luis Eduardo Madina Huerta on 05/05/22.
//

import UIKit


protocol LogoutDelegate: AnyObject{
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject{
    func didLogin()
}

class LoginViewController: UIViewController {
    let imageView = UIImageView()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let authenticationButton = UIButton(type: .system)
    let resetPasswordButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    private let biometricIDAuth =  BiometicIDAuth()
    
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String?{
        return loginView.userNameTextField.text
    }
    
    var password: String?{
        return loginView.passwordTextField.text
    }
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    
    
    var imageLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        prepMainViewDisable()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        loginView.userNameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
}


extension LoginViewController{
    private func style(){
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named:"bank.png")
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.baseBackgroundColor = .systemMint
        signInButton.layer.cornerRadius =  5
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        authenticationButton.translatesAutoresizingMaskIntoConstraints = false
        authenticationButton.configuration = .filled()
        authenticationButton.configuration?.baseBackgroundColor = .systemCyan
        authenticationButton.layer.cornerRadius =  5
        authenticationButton.setTitle("Authenticate", for: [])
        authenticationButton.addTarget(self, action: #selector(authenticateTapped), for: .primaryActionTriggered)
        
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.setTitle("Forgot Password", for: [])
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .red
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.adjustsFontSizeToFitWidth = true
        errorMessageLabel.isHidden = true
    }
    
    private func layout(){
        view.addSubview(imageView)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(authenticationButton)
        view.addSubview(resetPasswordButton)
        view.addSubview(errorMessageLabel)
        
        //Image Layout
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            imageView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
        ])
        
        imageLeadingAnchor = imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leadingEdgeOffScreen)
        imageLeadingAnchor?.isActive = true
        
        
        //Subtitle layout
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        //LoginView Layout
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2)
        ])
        
        //Button Layout
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 3),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 3),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 3)
        ])
        
        //Error Label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 1),
            errorMessageLabel.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
        //Button Authentication
        NSLayoutConstraint.activate([
            authenticationButton.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 5),
            authenticationButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            authenticationButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resetPasswordButton.topAnchor.constraint(equalToSystemSpacingBelow: authenticationButton.bottomAnchor, multiplier: 2),
            resetPasswordButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
    }
}

extension LoginViewController{
    @objc func signInTapped(sender: UIButton){
        errorMessageLabel.isHidden = true
        login()
    }
    
    @objc func authenticateTapped(){
        biometricIDAuth.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                // Face ID/Touch ID may not be available or configured
                return
            }
            biometricIDAuth.evaluate { [weak self] (success, error) in
                guard success else {
                    // Face ID/Touch ID may not be configured
                    return
                }
                if success{
                    DispatchQueue.main.async {
                        self?.delegate?.didLogin()
                    }
                }
            }
        }
    }

    
    @objc func resetPasswordTapped(sender: UIButton){
        navigationController?.pushViewController(PasswordResetViewController(), animated: true)
    }
    
    
    private func login(){
        guard let username = username,let password = password else{
            assertionFailure("Username / password should never be nil")
            return
        }
        
//        if username.isEmpty || password.isEmpty{
//            configureView("Username / password cannot be blank!")
//            return
//        }
        
        if username == "" && password == ""{
            signInButton.configuration?.showsActivityIndicator = true
            errorMessageLabel.isHidden = true
            delegate?.didLogin()
        }else{
            configureView("Incorrect Username / Password")
            loginView.userNameTextField.text = ""
            loginView.passwordTextField.text = ""
        }
    }
    
    private func configureView(_ message: String){
        errorMessageLabel.isHidden = false
        animateShake()
        errorMessageLabel.text = message
    }
    
    
    func animateShake() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

extension LoginViewController{
    private func animate(){
        let duration = 0.8
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut){
            self.imageLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        let animator2 = UIViewPropertyAnimator(duration: duration*2,curve:.easeInOut){
            self.imageView.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.6)
    }
}



