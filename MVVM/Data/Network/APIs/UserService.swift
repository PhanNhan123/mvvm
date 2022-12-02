
import RxSwift

/// UserService
/// Make all request APIs of USER domain
enum UserPath {
    case users
    case user(username: String)
    var path : String {
        switch self {
        case .users:
            return "users/"
        case .user(let username):
            return "users/\(username)"
        }
    }
}

protocol UserServiceProtocol {
    func getUsers() -> Observable<[UserModel]>
    func getUser(username : String) -> Observable<UserModel>
}

class UserService: BaseService,  UserServiceProtocol {
    func getUsers() -> Observable<[UserModel]> {
        let path = UserPath.users.path
        return get(path: path, parameters: nil)
    }
    
    func getUser(username: String) -> Observable<UserModel> {
        let path = UserPath.user(username: username).path
        return get(path: path, parameters: nil)
    }
}


