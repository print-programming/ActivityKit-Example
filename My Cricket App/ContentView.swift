//print()

import SwiftUI
import ActivityKit

var activityId = ""

struct ContentView: View {
    @State var scoreText = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            TextField("Add score here", text: self.$scoreText)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                )
            HStack(spacing: 20) {
                Button {
                    let activityAttributes = LiveScoreAttributes(title: "India vs West Indies")
                    let contentState = LiveScoreAttributes.LiveScoreStatus(score: self.scoreText)
                    do {
                        if let existingActivity = Activity<LiveScoreAttributes>.activities.filter({$0.id == activityId}).first {
                            Task {
                                await existingActivity.update(using: contentState)
                            }
                        }
                        else {
                            let deliveryActivity = try Activity<LiveScoreAttributes>.request(
                                attributes: activityAttributes,
                                contentState: contentState,
                                pushType: nil)
                            activityId = deliveryActivity.id
                            print("Requested a Live Activity \(deliveryActivity.id)")
                        }

                    } catch (let error) {
                        print("Error \(activityId.isEmpty ? "requesting" : "updating") Live Activity \(error.localizedDescription)")
                    }
                } label: {
                    Text("Submit")
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.blue, lineWidth: 1)
                )
                Button {
                    do {
                        Activity<LiveScoreAttributes>.activities.forEach { existingActivity in
                            Task {
                                await existingActivity.end(using: existingActivity.contentState, dismissalPolicy: .immediate)
                            }
                        }
                    } catch (let error) {
                        print("Error ending Live Activity \(error.localizedDescription)")
                    }
                } label: {
                    Text("End all Activity")
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.blue, lineWidth: 1)
                )

            }
        }
        .padding(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
