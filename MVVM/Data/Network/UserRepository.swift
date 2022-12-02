
import Foundation
import RxSwift

class UserRepository: Repository {
    
    static let shared = UserRepository()
    private let userService:UserServiceProtocol
    
    override init() {
        self.userService = UserService()
    }
    
    func getUsers() -> Observable<[UserModel]> {
        return userService.getUsers()
    }
    
    func getUser(username:String) -> Observable<UserModel> {
        return userService.getUser(username: username)
    }
    
    
}
