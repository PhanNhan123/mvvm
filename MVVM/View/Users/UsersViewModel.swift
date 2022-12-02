
import UIKit
import RxSwift
class UserViewModel: BaseViewModel {
    // MARK: - Inputs
    let inReload = PublishSubject<Void>()
    
    // MARK: - Outputs
    let outUsers = PublishSubject<[UserModel]>()
    
    override init() {
        super.init()
        /// subscribe inputs here
        inReload.subscribe(onNext: { () in
            self.loadUsers()
        }).disposed(by: disposeBag)
    }
    
    private func loadUsers() {
        /// show loading
        loading(true)
        /// call request API
        UserRepository.shared.getUsers()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext : { [weak self] users in
                    self?.outUsers.onNext(users)
                },
                onError: { [weak self] error in
                    self?.loading(false)
                    self?.alert(error.localizedDescription)
                },
                onCompleted: { [weak self] () in
                    self?.loading(false)
                }
        ).disposed(by: disposeBag)
        
    }
}
