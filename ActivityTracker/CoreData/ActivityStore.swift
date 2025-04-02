import Foundation
import CoreData

final class ActivityStore: ObservableObject {
    @Published var activities: [ActivityCoreData] = []
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchActivities()
    }
    convenience init() {
        let defaultContext = DataStore.shared.getContext()
        self.init(context: defaultContext)
    }
    func fetchActivities() {
        let request = NSFetchRequest<ActivityCoreData>(entityName: "ActivityCoreData")
        do {
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            activities = try context.fetch(request)
        } catch {
            print("Ошибка загрузки данных: \(error)")
        }
    }
    func addActivity(name: String, hoursPerDay: Double) {
        let newActivity = ActivityCoreData(context: context)
        newActivity.id = UUID().uuidString
        newActivity.name = name
        newActivity.hoursPerDay = hoursPerDay
        saveContext()
    }
    private func saveContext() {
        do {
            try context.save()
            fetchActivities()
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
}
