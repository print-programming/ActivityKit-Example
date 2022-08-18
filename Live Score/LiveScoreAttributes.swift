//print()

import Foundation
import ActivityKit

struct LiveScoreAttributes: ActivityAttributes {
    public typealias LiveScoreStatus = ContentState
    
    var title: String
    public struct ContentState: Codable, Hashable {
        var score: String
    }
}
