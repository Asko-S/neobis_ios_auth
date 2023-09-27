import UIKit
import SnapKit

class EmailViewController: UIViewController, ForgotPasswordViewModelDelegate {

    // MARK: - Properties

    let mainView = EmailView()
    var userViewModel: AuthViewModelProtocol!

    // MARK: - Initialization

    init(userViewModel: AuthViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.forgotPasswordDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Сброс пароля"

        let backButton = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(goBackButtonPressed))
        navigationItem.leftBarButtonItem = backButton

        mainView.continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }

    // MARK: - Button Actions

    @objc func continueButtonPressed() {
        guard let email = mainView.emailTextField.text else {
            // Show error message to the user
            print("Email is empty.")
            return
        }

        userViewModel.resetPassword(email: email)
    }

    @objc func goBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - View Setup

    func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - ForgotPasswordViewModelDelegate

    func didForgotPassword(user: PasswordResetEmailSerializers) {
        print("Successfully sent email")
        // Handle the success case, e.g., show a confirmation message
    }

    func didFail(with error: Error) {
        print("Failed to send email. Error: \(error.localizedDescription)")
        // Handle the failure case, e.g., show an error message to the user
    }
}
