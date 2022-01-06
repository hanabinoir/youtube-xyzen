# YouTube XYZen

A Customized YouTube App which blocks ads.

## Summary

With the initial commit, the app basically works, but there are some runtime bugs and some error with the project.

__Bugs that impact the performance__

- A JavaScript variable `idDefined` is being declared every time when WebView is refreshed
- The condition for skipping ads should be updated to prevent it being executed multiple times.
- When a promotion div is being removed, the view can flash hardly. Make it softer.

__Updates required for the project__

- Errors in build.gradle which does not affect the runtime, but annoying, and better to be solved.
- The local properties for android build is better to be created.

## LICENSE

```
MIT License

Copyright (c) 2022 Vincent Shen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```