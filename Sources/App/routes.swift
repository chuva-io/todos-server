import Vapor

// Register routes
public func routes(_ router: Router) throws {

    // MARK: Todo Controller

    let todoController = TodoController()
    let todoRoot = "todos"

    router.get(todoRoot, use: todoController.index)
    router.post(Todo.self, at: todoRoot, use: todoController.create)
    router.delete(todoRoot, Todo.parameter, use: todoController.delete)

    router.put(Todo.self, at: todoRoot, Todo.parameter) { req, newTodo in
        try req.parameters.next(Todo.self)
            .flatMap { existingTodo -> Future<Todo> in
                newTodo.id = existingTodo.id
                return newTodo.save(on: req)
        }
    }

}
