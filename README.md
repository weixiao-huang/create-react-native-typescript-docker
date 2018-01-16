# React-native init scaffold

## Replacement

### `tsconfig.json`

```Json
{
    "compilerOptions": {
        // other options here
    },
    "include": ["./src/"]
}
```

### `package.json`

we'll open up our `package.json` and replace the `jest` field with the following:

```
"jest": {
    "preset": "react-native",
    "moduleFileExtensions": [
        "ts",
        "tsx",
        "js"
    ],
    "transform": {
        "^.+\\.(js)$": "<rootDir>/node_modules/babel-jest",
        "\\.(ts|tsx)$": "<rootDir>/node_modules/ts-jest/preprocessor.js"
    },
    "testRegex": "(/__tests__/.*|\\.(test|spec))\\.(ts|tsx|js)$",
    "testPathIgnorePatterns": [
        "\\.snap$",
        "<rootDir>/node_modules/",
        "<rootDir>/lib/"
    ],
    "cacheDirectory": ".jest/cache"
}
```

This will configure Jest to run `.ts` and `.tsx` files with `ts-jest`.

### files in `./src`

the replacements include:

- Replace `import React, {Component} from 'react';` with `import * as React from 'react';`
- Replace old references to `Component` to `React.Component<object, object>`.

That should fix things right up. Some of this has to do with differences in how Babel and TypeScript interoperate with CommonJS modules. In the future, the two will stabilize on the same behavior.

Next, we'll move our tests over to TypeScript as well. Just change the extension of all files in `src/__tests__/` from `.js`to `.tsx` and apply the following fixes:

- Replace `import React, {Component} from 'react';` with `import * as React from 'react';`
- Replace `import renderer from 'react-test-renderer';` with `import * as renderer from 'react-test-renderer';`
- Rewrite imports from `import Index from '../index.ios.js';` to `import Index from '../index.ios';`, and likewise for Android. In other words, drop the `.js` extension from your imports.

First, run TypeScript on our source:

```
./node_modules/.bin/tsc
```

Now we can make sure our tests still run and that the app can still correctly deploy. If running on an emulator/device still works, and tests are still passing, you're all set to start building out with TypeScript! As a checkpoint, consider committing your files into version control.

### `.gitignore`

For your source control, you'll want to start ignoring the `.jest` and `lib` folders. If you're using git, we can just add entries to our `.gitignore` file.

```
# TypeScript
#
lib/

# Jest
#
.jest/
```

