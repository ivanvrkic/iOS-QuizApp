//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Ivan Vrkic on 14.04.2021..
//
import Foundation
import UIKit


class LoginViewController: UIViewController {
    private var router: AppRouterProtocol!
    private var popQuizLabel: UILabel!
    private var emailTextF: UITextField!
    private var passwordTextF: UITextField!
    private var loginButton: UIButton!
    private var passwordButton: UIButton!
    private var iconClick: Bool = true
    private var emailView: UIView!
    private var passwordView: UIView!
    private var gradientLayer: CAGradientLayer!
    private let loginLogic = LoginLogic(networkService: NetworkService())
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        animate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        addConstraints()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
          ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    private func buildViews() {
        popQuizLabel = UILabel()
        view.addSubview(popQuizLabel)
        popQuizLabel.text = "PopQuiz"
        popQuizLabel.textAlignment = .center
        popQuizLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.black)
        popQuizLabel.textColor = .white
        emailView = UIView()
        emailTextF = UITextField()
        view.addSubview(emailView)
        emailTextF.bounds.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        setTextF(viewField: emailView, textF: emailTextF, text: "E-mail")
        passwordView = UIView()
        passwordTextF = UITextField()
        view.addSubview(passwordView)
        passwordTextF.isSecureTextEntry.toggle()
        setTextF(viewField: passwordView, textF: passwordTextF, text: "Password")
        passwordTextF.addTarget(self, action: #selector(focus), for: .editingDidBegin)
        passwordTextF.addTarget(self, action: #selector(unfocus), for: .editingChanged)
        loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.cornerRadius = 25
        loginButton.backgroundColor = .white
        loginButton.alpha = 0.5
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
    }
    
    private func addConstraints() {

        popQuizLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popQuizLabel.widthAnchor.constraint(equalToConstant: 200),
            popQuizLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popQuizLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            popQuizLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        emailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailView.widthAnchor.constraint(equalToConstant: 330),
            emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        emailTextF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextF.widthAnchor.constraint(equalToConstant: 300),
            emailTextF.centerXAnchor.constraint(equalTo: emailView.centerXAnchor),
            emailTextF.topAnchor.constraint(equalTo: emailView.topAnchor),
            emailTextF.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordView.heightAnchor.constraint(equalToConstant: 50),
            passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 10),
            passwordView.widthAnchor.constraint(equalTo: emailView.widthAnchor)
        ])
        
        passwordTextF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextF.widthAnchor.constraint(equalToConstant: 300),
            passwordTextF.centerXAnchor.constraint(equalTo: passwordView.centerXAnchor),
            passwordTextF.topAnchor.constraint(equalTo: passwordView.topAnchor),
            passwordTextF.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 10),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: emailView.widthAnchor)
        ])
    }
    
    private func setTextF(viewField: UIView,textF: UITextField, text: String){
        textF.addTarget(self, action: #selector(focus), for: .editingDidBegin)
        textF.addTarget(self, action: #selector(unfocus), for: .editingDidEnd)
        textF.attributedPlaceholder = NSAttributedString(string: text, attributes:  [NSAttributedString.Key.foregroundColor: UIColor.white])
        textF.textColor = .white
        textF.tintColor = .white
        textF.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        textF.autocapitalizationType = .none
        viewField.layer.cornerRadius = 25
        viewField.clipsToBounds = true
        viewField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        viewField.addSubview(textF)
        
    }
    
    private func animate() {
        popQuizLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        popQuizLabel.alpha = 0
        emailView.transform = emailView.transform.translatedBy(x: -self.view.frame.width, y: 0)
        emailView.alpha = 0
        passwordView.transform = passwordView.transform.translatedBy(x: -self.view.frame.width, y: 0)
        passwordView.alpha = 0
        loginButton.transform = loginButton.transform.translatedBy(x: -self.view.frame.width, y: 0)
        
        //animate pop label
        UIView.animate(withDuration: 1.5,
           animations: {
                self.popQuizLabel.alpha = 1
                self.popQuizLabel.transform = .identity
            }
        )
        UIView.animate(withDuration: 1.5, delay: 0,
            options: [.curveEaseOut],
            animations: {
                self.emailView.transform = .identity
                self.emailView.alpha = 1
            }
        )
        UIView.animate(withDuration: 1.5, delay: 0.25,
            options: [.curveEaseOut],
            animations: {
                self.passwordView.transform = .identity
                self.passwordView.alpha = 1
            }
        )
        UIView.animate(withDuration: 1.5, delay:0.5,
            options: [.curveEaseOut],
            animations: {
                self.loginButton.transform = .identity
                self.loginButton.alpha = 1
            }
        )
    }

    @objc
    private func focus() {
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.layer.masksToBounds = true
        emailView.layer.borderWidth = 1
        
    }
    
    @objc
    private func unfocus() {
        emailView.layer.borderWidth = 0
    }
    
    @objc
    private func login(){
        loginLogic.login(username: emailTextF.text!, password: passwordTextF.text!) { loginStatus in
            UIView.animate(withDuration: 0.1,
                           animations: {self.loginButton.alpha = 1},
                           completion: { _ in self.loginButton.alpha = 0.5})
            switch loginStatus {
                case LoginStatus.success:
                    UIView.animate(withDuration: 1.5, animations: {
                            self.popQuizLabel.transform = CGAffineTransform(translationX: 0, y:  -self.view.frame.height)
                    })
                    UIView.animate(withDuration: 1.5, delay: 0.25,
                    animations: {
                            self.emailView.transform = CGAffineTransform(translationX: 0, y:  -self.view.frame.height)
                    })
                    UIView.animate(withDuration: 1.5, delay: 0.50,
                                   animations: {
                            self.passwordView.transform = CGAffineTransform(translationX: 0, y:  -self.view.frame.height)
                    })
                    UIView.animate(withDuration: 1.5, delay: 0.75,
                    animations: {
                            self.loginButton.transform = CGAffineTransform(translationX: 0, y:  -self.view.frame.height)
                    },
                    completion: {_ in
                        self.router.setTabBarController()
                    })
                case LoginStatus.error(_, _):
                    print(loginStatus)
            }
        }
    }
}

