# In this document, we'll talk about some of the approaches used across the app

## assert when using postfix ! operator
basically, everywhere we use `!`, we first do a null check, and if `null`, we assert(false) to throw a runtime error in `debug` mode, and provide a fallback so the app does not fall apart in `release` mode.

example:

```dart
int? foo;

int bar(int? foo) {
    if(foo==null) {
        // throw runtime error in debug mode
        assert(false);

        // fallback in release mode
        return 0;
    }

    return foo;
}
```

## `TODO` and `FAR_FUTURE`
every thing that is urgent is marked as `TODO`, and everything that is good to be done in the far future but not urgent is marked as `FAR_FUTURE`.

there is also `DYNAMIC_GAME_TODO` which is not really important, just gives idea of what could be done to improve them, we'll probably just blow that whole system up soon.