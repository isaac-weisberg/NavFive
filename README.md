# NavFive

The state of reactive navigation art - reactive coordinator tree.

This projects aims to achieve the following goals:

1. Establish a FLUX-alike state machine driven by a set of rules defined as `(Action, ViewState) => ViewState`.
1. Be better than RxFlow by being statically typed with reliance on a heavy use of generics.
1. Be "deep links"-ready for coherent imperative link injections - a staple of nowadays deeplinking architecture.
1. Establish a pattern of an iOS view the lifecycle of which is wrapped into a reactive primitive.

As of now, the project looks like shit-shit. Currently I am completely satisfied with the implementation of the `SequetialCoordinator`. It is a good and concise tree of flux components and I've figured out how would I make a public interface for the injection of deep linkage events.

There are a few questions, more in the philosophical domain though, when it comes down to the implementation of "coordinatable" views. There are several things that come to my mind:

1. How to describe a state of a coordinated `UINavigationController` when in midst of transition performed using the `interactivePopGestureRecognizer`?
1. How to descripe a state of a chain of modally presented `UIViewController`'s when there is an interactive, cancelable transition happening at the top.

Cut to the chase, there is no problem when the state of a coordinated view changes really is all about presence or absence of any of the views in question. You `pop` or `push` and the state of the controllers stack is constantly represented by one model - and array of `UIViewController`. Alternatively, a chain of modally presented `UIViewController`s is represented as a linked list in the Apple's frameworks or can be simplified to an array of `UIViewController`. This is by the way the reason why I called the current implementation a `SequentialCoordinator` - because its states model is a sequesce of views.

But the current problem which is implicitly bugging me already for 2 weeks straight is how the fuck do I handle the case of the `interactivePopGestureRecognizer` or any custom interactive transion. There a couple of options and they all suck my pee-pee dick.

# Another problematic field

What is currently hardly an achievable milestone is making an app that features a single reactive subscription. Theoritically it is possible to see the whole app's user spaces be comprised of zero dynamically allocated objects (excluding the common Foundation and UIKit suspects e.g. `UIApplication`). And thus the app at the beginning of its lifecycle would look like a bunch of unallocated closures and data structures, right until the `applicationDidFinishLaunching`.

What you see happenning during the synchronous pass of the `applicationDidFinishLaunching` is the following sequence of events:

1. A subscription to the main coordinator gets created.
1. A `UIWindow` (retained by the subscription) gets instantiated by the main coordinator, recieves `makeKey` message and gets mounted into the `UIApplication.windows` array, gets a root view controller.
1. A child coordinator gets instantiated. It mounts a bunch of view controllers to the window. It maps a bunch of possible view state changes one into another and feeds the results of state changes uptop into the parent coordinator.
