# React-native init scaffold

## Introduction

A react-native project generator developed by `docker`. This scaffold generator makes your project usually latest.

## Prerequirements

You should make sure `docker` and `GNU Make` is installed in your computer.

## Usage

### Javascript

For generating a react-native javascript project scaffold, just run

```Bash
$ make PROJ=YOUR_PROJ_NAME
```

### Typescript

If you want to make a typescript react-native project, after the command `make PROJ=YOUR_PROJ_NAME` above, you should also run

```bash
$ make tsc
```

then you should do some file replacements described below:

#### `tsconfig.json`

```Json
{
    "compilerOptions": {
        // other options here
    },
    "include": ["./src/"]
}
```

#### `package.json`

we'll open up our `package.json` and replace the `jest` field with the following:

```Json
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

Then Add typescript scripts into `package.json`:

```Json
"scripts": {
  "clean": "rm -rf lib",
  "tsc:w": "tsc -w",
  "tsc": "tsc",
  ...
},
```

#### `.gitignore`

For your source control, you'll want to start ignoring the `.jest` and `lib` folders. If you're using git, we can just add entries to our `.gitignore` file.

```
# TypeScript
#
lib/

# Jest
#
.jest/
```

#### files in `./src`

##### `./src/App.tsx`

- Replace `import React, {Component} from 'react';` with `import * as React from 'react';`
- Replace old references to `Component` to `React.Component<object, object>`.

##### `./src/__test__/App.tsx`

- Replace `import React, {Component} from 'react';` with `import * as React from 'react';`
- Replace `import renderer from 'react-test-renderer';` with `import * as renderer from 'react-test-renderer';`
