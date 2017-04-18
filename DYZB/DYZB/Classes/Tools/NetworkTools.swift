import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools{
    
    class func SendRequest(methodType:MethodType,urlString:String,params:[String:String]? = nil,finishCallBack: @escaping(_ respnseObject : Any?) -> ()){
     
        let method = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: method, parameters: params).responseJSON { (response) in
            
            //获取结果
            guard let result = response.result.value else {
                debugPrint("请求\(urlString)失败原因:\(response.result.error)")
                return
            }
            // 将结果回调出去
            finishCallBack(result)
            
        }
        
    }

}
