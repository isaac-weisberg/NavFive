public protocol WindowCoordinator {
    associatedtype NavigationState: WindowNavigationState
    associatedtype Action
    
    func convert(action: Action, navigation: NavigationState) -> NavigationState
}
