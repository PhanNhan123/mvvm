
import UIKit
import RxSwift

class UsersViewController: BaseViewController<UserViewModel> {
    
    @IBOutlet weak var userTableView: UITableView!
    
//    @IBOutlet weak var userTableViewsc: UITableView!
    override func setupUI() {
        super.setupUI()
        userTableView.refreshControl = UIRefreshControl()
    }
    override func viewDidLoad() {
        print("view controller")
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        viewModel = UserViewModel()
        
        viewModel.base.loading
            .bind(to: (userTableView.refreshControl?.rx.isRefreshing)!)
            .disposed(by: disposeBag)
        
        viewModel.outUsers
            .bind(to: userTableView.rx.items(cellIdentifier: UsersTableViewCell.reuseID , cellType: UsersTableViewCell.self)) { index, user, cell in
                cell.bind(user: user)
        }.disposed(by: disposeBag)
        
        userTableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] () in
                self?.viewModel?.inReload.onNext(())
            }).disposed(by: disposeBag)
        
        userTableView.rx.modelSelected(User.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
//                let vc = DetailViewController.create(user: user)
//                self.navigator.push(target: vc, sender: self)
            }).disposed(by: disposeBag)
    }
    
    override func setupData() {
        viewModel?.inReload.onNext(())
    }
}
