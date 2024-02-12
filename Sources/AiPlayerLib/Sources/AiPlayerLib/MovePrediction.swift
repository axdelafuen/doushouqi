import Foundation
import Model
import CoreML
import CreateML

@available(macOS 10.14, *)
public struct MovePrediction{
    public var df:MLDataTable!
    public var trainingData:MLDataTable!
    public var testingData:MLDataTable!
    
    public func start() {
        let df:MLDataTable? = loadDatas()

        if let df {
            let (trainingData, testingData) = splitDatas(df:df)
            let eval:MLClassifierMetrics? = classifier(trainingData: trainingData, testingData: testingData)
            if let eval {
                print(accuracy(evaluation: eval))
            }
        }
    }
    
    
    public func loadDatas() -> MLDataTable?{
        do {
             return try MLDataTable(contentsOf: URL(fileURLWithPath: "./gamesSample.csv"))
        } catch {
            print("Erreur lors de la lecture du fichier CSV : \(error)")
        }
        return nil
    }
    
    public func splitDatas(df:MLDataTable) -> (MLDataTable, MLDataTable){
         return df.randomSplit(by: 0.8)
    }
    
    public func classifier(trainingData:MLDataTable, testingData:MLDataTable) -> MLClassifierMetrics? {
        /*do {
            let classifier //= try MLImageClassifier(trainingData: trainingData, featureColumns: ["Weight", "Color"], labelColumn: "Label")
            return classifier.evaluation(on: testingData)
        } catch {
            print("Erreur lors de l'apprentissage : \(error)")
        }*/
        return nil
        
    }
    
    public func accuracy(evaluation:MLClassifierMetrics) -> Double{
        return (1.0 - evaluation.classificationError) * 100
    }
    
    public init() {}
}
