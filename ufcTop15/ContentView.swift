import SwiftUI

struct ContentView: View {
    @State private var selectedWeightClass = WeightClass.default
    @State private var fighters: [Fighter] = []

    var body: some View {
        VStack {
            // picker that holds each weight class and men's and women's pound for pound rankings
            Picker("Select Weight Class", selection: $selectedWeightClass) {
                ForEach(WeightClass.allCases, id: \.self) { weightClass in
                    Text(weightClass.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            // display list of top 15 fighters for picked weight class
            List(fighters, id: \.id) { fighter in
                FighterView(fighter: fighter)
            }
        }
        .onAppear() {
            fetchFighters()
        }
        // re-render page after new weight class is picked
        .onChange(of: selectedWeightClass) { newValue in
            fetchFighters()
        }
    }
    // function that fetches top 15 fighters data from csv file
    func fetchFighters() {
        // creating csv file variable where data is stored
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
    
    // function to parse data from csv file
    func parseCSV(_ csvData: String) -> [Fighter] {
        // array to hold list of fighters to display in view
        var fighters: [Fighter] = []

        let rows = csvData.components(separatedBy: "\n")
        // parsing data into seperate columns
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count == 4 {
                let date = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let weightClass = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
                let fighter = columns[2].trimmingCharacters(in: .whitespacesAndNewlines)
                let rank = columns[3].trimmingCharacters(in: .whitespacesAndNewlines)
                // fetch rows from most recent data updated
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
        // return entire list of fighters with appropriate data based on most recent date
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
