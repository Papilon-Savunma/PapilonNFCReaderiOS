# PapilonNFCReaderiOS

This package is a NFC reader of ID cards and Passports.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

PapilonNFCReaderiOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PapilonNFCReaderiOS'
```

## Usage

Before the using the SDK you need to create a key called MRZKey for the input of the `passportReader` function.

This key is generated by birth date, expiry date and serial number of the ID card or passport.
You can get this values by scanning the MRZ areas of the ID via [PapilonMRZScanner](https://github.com/Papilon-Savunma/PapilonMRZScanner-iOS) library; 

MRZ key should be; 

```swift
var mrzKey = documentNumber + checkSumofDocNum + 
             birthDate + checkSumofBirthDate + 
             expiryDate + checkSumofExpiryDate
```
Checksum can be calculated as in the exapmle function:

```swift
func calcCheckSum( _ checkString : String ) -> Int {
        let characterDict  = ["0" : "0", "1" : "1", "2" : "2", "3" : "3", "4" : "4", "5" : "5", "6" : "6", "7" : "7", "8" : "8", "9" : "9", "<" : "0", " " : "0", "A" : "10", "B" : "11", "C" : "12", "D" : "13", "E" : "14", "F" : "15", "G" : "16", "H" : "17", "I" : "18", "J" : "19", "K" : "20", "L" : "21", "M" : "22", "N" : "23", "O" : "24", "P" : "25", "Q" : "26", "R" : "27", "S" : "28","T" : "29", "U" : "30", "V" : "31", "W" : "32", "X" : "33", "Y" : "34", "Z" : "35"]
        
        var sum = 0
        var m = 0
        let multipliers : [Int] = [7, 3, 1]
        for c in checkString {
            guard let lookup = characterDict["\(c)"],
                let number = Int(lookup) else { return 0 }
            let product = number * multipliers[m]
            sum += product
            m = (m+1) % 3
        }
        
        return (sum % 10)
    }
    
```

Then, you can call `passportReader` function as;

```swift 
passportReader.readPassport(mrzKey: mrzKey, tags: [.DG1, .DG2], completed: { (error) in
   ...
}
```

The parameter `tags` is for the what Data Groups you want to call. For instance, DG1, DG2, etc. This library supports COM, DG1, DG2, DG7, DG11 and DG12.

We are working on other data groups.

Do not forget to add NFC (Near Field Communication Tag Reading) capability from your app targets.


## License

See the LICENSE file for more info.
