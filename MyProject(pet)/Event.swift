import Foundation


class TodayResult {
    
    var date: Date
    var result: String
    
    static var List = [TodayResult]()
    static var selectedList = [TodayResult]()
    
    init(date: Date, result: String) {
        self.date = date
        self.result = result
    }
}
