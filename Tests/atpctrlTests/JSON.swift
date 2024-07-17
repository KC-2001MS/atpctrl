//
//  JSON.swift
//  atpctrl
//  
//  Created by Keisuke Chinone on 2024/07/18.
//


import Foundation

extension Bundle {
    /// Jsonファイルのデコードを行い、``Codable``に準拠した構造体に変換する関数
    ///
    ///jsonファイルからSwiftの構造体を生成できます。以下のコードを利用して変換が可能です。
    ///```swift
    ///    let initialValue: InitialValueData =  Bundle.main.decodeJSON("InitialValue.json")
    ///```
    ///この例では、引数ににjsonファイルを指定することによって、initialValue変数にInitialValueData型の構造体としてJSONファイル値を代入することができます。
    ///
    ///ただし、InitialValueDataが完全に``Decodable``に準拠している必要があります。さらに、構造体にjsonファイル側に存在しない変数があるとクラッシュするので注意してください。
    ///
    /// - Parameter file: デコードを行うJSONファイルの文字列
    /// - Returns: Codableに準拠する構造体
    func decodeJSON<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Faild to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
