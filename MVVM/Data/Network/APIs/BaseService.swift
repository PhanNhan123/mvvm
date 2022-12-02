import RxSwift
import Alamofire

/**
 BaseService for all  Restful api services
 */
class BaseService {
    
    /// Base url by enviroment  configuration
    private static let baseURL = "https://api.github.com"
    
    /// Queue for worker thread
    private let queue = DispatchQueue(label: "BaseService.Network.Queue")
    
    /// Common headers
    private let headers: HTTPHeaders = [
        "Accept": "application/json"
    ]
    
    init() {}
    
    /// make get method
    func get<T:Codable>(path: String, parameters:[String : Any]?) -> Observable<T> {
        return request(method: .get, path: path, parameters: parameters)
    }
    
    /// make post method
    func post<T:Codable>(path: String, parameters:[String : Any]?) -> Observable<T> {
        return request(method: .post, path: path, parameters: parameters)
    }
    
    func request<T:Codable>(method: HTTPMethod, path: String, parameters: [String : Any]?) -> Observable<T> {
        let url = "\(BaseService.self.baseURL)/\(path)"
        print("api method=\(method) url=\(url)")
        return Observable.create { observer in
            let request = AF.request(url, method: method, parameters: parameters, headers: self.headers)
                .responseDecodable(queue: self.queue) { (response:AFDataResponse<T>) in
                    switch response.result {
                    case .success(let data):
                        print("api success data=\(data)")
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        print("api failure error=\(error)")
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
