import SwiftUI

struct FighterView: View {
    let fighter: Fighter

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(fighter.rank). \(fighter.fighter)")
                .font(.headline)
            Text("Weight Class: \(fighter.weightClass.rawValue)")
                .font(.subheadline)
            Text("Rank: \(fighter.rank)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct FighterView_Previews: PreviewProvider {
    static var previews: some View {
        FighterView(fighter: Fighter(fighter: "Jon Jones", rank: 1, weightClass: .lightHeavyweight))
    }
}
