# bumn_eid

Kementrian BUMN Executive Informational Dashboard mobile application

## How to add more pages

to add more pages, I've already created a simple script for you.
To do so, just run this script from the main directory (bumn_eid):

`bash ./scripts/create_widget.sh PageName`

where the page name is the page you're going to develop and you need to make it camel case so it will look pretty.
So for example:

`bash ./scripts/create_widget.sh LoginPage`

and then, you'll see that a `login_page.dart` will be created inside `ui/pages/` folder.

After that, you can develop the pages that you wanted to create.

## Dependency Injection

In this project, we implement dependency injection. [Read more](https://en.wikipedia.org/wiki/Dependency_injection).

The best way to get this work, is to create a widget from the scripts I've
created, and explained above.

To create a dependency, go to `injector.dart` and see if there's already
a dependency for your widget to consume, if there aren't any yet. You had
to create and inject it to `Injector.appInstance`.

To get a dependency inside a widget, all you need to do is just create a
new variable inside the widget and left it uninitialized.

Then, inside the graph file (e.g. `di/login_page.graph`), use this line below:

```
subject.dependencyName = getDependency<DependencyType>();
```

## How to navigate between pages

In this project, I've implemented Redux to navigate between pages so it will be much more organized.

To read more about redux, [click here](https://redux.js.org/).

There are currently five actions to navigate between pages. And will be explained more below:

- `NavigateToNextAction`

In this action, the current page will be added by another page on top of it.
While the current page isn't deleted just yet.

- `NavigateToNextAndReplaceAction`

In this action, the current page will be replaced by another page. So, the
current page is practically deleted.

- `ShowDialogAction`

In this action, we will show a dialog (be it Alert dialog, Pop up dialog, you name it).

- `ShowBottomSheetAction`

In this action, we will show a dialog (be it Alert dialog, Pop up dialog, you name it).

- `NavigateBackAction`

In this action, we will delete the most top page that the user currently sees.
If there's only one page left, we can't delete the current page or the user will be
left with a blank screen on their phone. Be wise when using this!

All of those five actions, except the `NavigateBackAction`, needed
a `NavigationDestination` for it to work. A destination is just simply a new page that
we want the user to discover. So after creating a page, we also need to
create a `NavigationDestination` for our navigation scheme to recognize that.

To create a `NavigationDestination`, just open `navigation_destinations.dart`

and add a new destination on the very bottom of the file, with the same format as
preceding destinations.