public enum ViewState<NavigationState> {
    case uncoordinated
    case coordinated(NavigationState)
}

extension ViewState {
    var asOptional: NavigationState? {
        switch self {
        case .coordinated(let state):
            return state
        case .uncoordinated:
            return nil
        }
    }
}
