import Alamofire
import SwiftyJSON
import UIKit
class UsersViewModel {
    func getURL(completion: @escaping ([UserModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Basic 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"
        ]
        let url = "https://api.github.com/users"
        DispatchQueue.global(qos: .background).async {
            AF.request(url,headers: headers).responseJSON {response in
                switch (response.result) {
                case .success( _):
                    do {
                        let users = try JSONDecoder().decode([ UserModel].self, from: response.data!)
                        for item in users {
                            print(item.login)
                        }
                        DispatchQueue.main.async {
                            print("dispatched to main")
                            completion(users)
                        }
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Request error: \(error.localizedDescription)")
                }
            }
        }
    }
}
