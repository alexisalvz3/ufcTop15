import SwiftUI

struct ContentView: View {
    @State private var selectedWeightClass = WeightClass.default
    @State private var fighters: [Fighter] = []

    var body: some View {
        VStack {
            Picker("Select Weight Class", selection: $selectedWeightClass) {
                ForEach(WeightClass.allCases, id: \.self) { weightClass in
                    Text(weightClass.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            
            List(fighters, id: \.id) { fighter in
                FighterView(fighter: fighter)
            }
        }
        .onAppear() {
            fetchFighters()
        }
        .onChange(of: selectedWeightClass) { newValue in
            fetchFighters()
        }
    }

    func fetchFighters() {
        guard let csvURL = Bundle.main.url(forResource: "rankings_history", withExtension: "csv") else {
            return
        }

        do {
            let csvData = try String(contentsOf: csvURL)
            let parsedData = parseCSV(csvData)
            let filteredFighters = filterFighters(parsedData)
            fighters = filteredFighters
        } catch {
            print("Error reading CSV file: \(error)")
        }
    }

    func parseCSV(_ csvData: String) -> [Fighter] {
        var fighters: [Fighter] = []

        let rows = csvData.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count == 4 {
                let date = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let weightClass = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
                let fighter = columns[2].trimmingCharacters(in: .whitespacesAndNewlines)
                let rank = columns[3].trimmingCharacters(in: .whitespacesAndNewlines)
                
                if date == "2024-03-05" {
                    if let weightClass = WeightClass(rawValue: weightClass) {
                        if let rank = Int(rank) {
                            let fighter = Fighter(fighter: fighter, rank: rank, weightClass: weightClass)
                                fighters.append(fighter)
                        }
                    } else {
                        print("Invalid weight class: \(weightClass)")
                    }
                }
            }
        }

        return fighters
    }


    func filterFighters(_ fighters: [Fighter]) -> [Fighter] {
        // Filter fighters based on selected weight class and the most recent date
        // Return the filtered array of Fighter objects
        return fighters.filter { $0.weightClass == selectedWeightClass }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
