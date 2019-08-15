public enum ViewState<NavigationState> {
    case uncoordinated
    case coordinated(NavigationState)
}
