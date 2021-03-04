//
//  Created by tonezone6 on 02.03.2021.
//

/**
 Confirm your storage to this protocol in order to store the passcode */
public protocol PasscodeStorageProtocol {
    
    var passcode: String? { get }
    func save(passcode: String)
}
