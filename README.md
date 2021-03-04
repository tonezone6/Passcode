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
Then, in order to present passcode modal screen, just use `present(using:)` 

```swift
let mySecureStorage = SecureStorage()
Passcode.present(using: mySecureStorage)
```

Passcode also support dark mode.

![Passcode](Sources/light.png)
![Passcode](Sources/dark.png)
