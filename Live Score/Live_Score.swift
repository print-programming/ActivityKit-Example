//print()

import WidgetKit
import SwiftUI
import ActivityKit

@main
struct LiveScoreActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(attributesType: LiveScoreAttributes.self) { context in
            ZStack {
                Color.cyan
                VStack {
                    Text(context.attributes.title)
                    HStack {
                        Text(context.state.score)
                    }
                }
            }.activitySystemActionForegroundColor(Color.cyan)
        }
    }
}
