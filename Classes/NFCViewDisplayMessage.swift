//
//  File.swift
//  
//
//  Created by Papilon Savunma on 11.01.2022.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public enum NFCViewDisplayMessage {
    case requestPresentPassport
    case authenticatingWithPassport(Int)
    case readingDataGroupProgress(DataGroupId, Int)
    case error(NFCPassportReaderError)
    case successfulRead
}

@available(iOS 13, macOS 10.15, *)
extension NFCViewDisplayMessage {
    public var description: String {
        switch self {
            case .requestPresentPassport:
                return "iPhone'unuzu NFC özellikli bir pasaportun ya da kimlik kartının önünde tutun."
            case .authenticatingWithPassport(let progress):
                let progressString = handleProgress(percentualProgress: progress)
                return "Kimlik ya da pasaport doğrulanıyor.....\n\n\(progressString)"
            case .readingDataGroupProgress(let dataGroup, let progress):
                let progressString = handleProgress(percentualProgress: progress)
                return "\(dataGroup) Okunuyor.....\n\n\(progressString)"
            case .error(let tagError):
                switch tagError {
                    case NFCPassportReaderError.TagNotValid:
                        return "Etiket geçerli değil"
                    case NFCPassportReaderError.MoreThanOneTagFound:
                        return "Birden fazla etiket bulundu. Lütfen bir adet kimlik veya pasaport okutun."
                    case NFCPassportReaderError.ConnectionError:
                        return "Bağlantı hatası. Lütfen tekrar deneyin."
                    case NFCPassportReaderError.InvalidMRZKey:
                        return "MRZ bilgileri bu belge için geçerli değil."
                    case NFCPassportReaderError.ResponseError(let description, let sw1, let sw2):
                        return "Maalesef pasaport veya kimlik okunurken bir sorun oluştu. \(description) - (0x\(sw1), 0x\(sw2)"
                    default:
                        return "Maalesef pasaport veya kimlik okunurken bir sorun oluştu. Lütfen tekrar deneyin."
                }
            case .successfulRead:
                return "Pasaport ya da kimlik başarıyla okundu."
        }
    }
    
    func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress/10)
        let full = String(repeating: "🔴 ", count: p)
        let empty = String(repeating: "⚪️ ", count: 10-p)
        return "\(full)\(empty)"
    }
}
