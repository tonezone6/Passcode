# Passcode

### A simple passcode screen to protect your app.

Firstly, extend your preffered storage to conform with the `PasscodeStorageProtocol` protocol.

```swift
struct SecureStorage { ... }

extension SecureStorage: PasscodeStorageProtocol {

    public var passcode: String? {
        load(key: "passcode")
    }
    
    public func save(passcode: String) {
        save(passcode, withKey: "passcode")
    }
}
```
and then just call `present(using:)` method

```swift
let mySecureStorage = SecureStorage()
Passcode.present(using: mySecureStorage)
```

Passcode also supports dark mode.

![Passcode](Sources/light.png)
![Passcode](Sources/dark.png)
