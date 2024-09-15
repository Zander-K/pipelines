# Pipeline CLI

This CLI can be used to gather and create a file with all the  information from the latest production build.

---

## Installing

In ``rank_mobile_core/`` use the following to *install* the CLI:

```bash
make cli
```

or

```sh
dart pub global activate -s path ./pipeline_cli
dart pub global run ./pipeline_cli
```

Use the following to confirm the installation:

```bash
dart pub global list  
```

with output looking something like `pipeline 0.0.2 at path "/Users/...`

Unistall to update then reinstall install:

```bash
dart pub global deactivate pipeline  
dart pub global activate -s path ./pipeline_cli
```

**Alternatively:**
Use `make cli` to reinstall all CLI's.

---

## Usage

```bash
pipe --welcome
```

OR

```bash
pipe -w
```

### Generate contents

To extract and generate a build's info, use the `-g` flag and pass in the branch name requested interactively where the workflow is running from. Alternatively, use `-b <branch_name>` with `-g`:

```sh
pipe -g
```

or without the interactivity

```sh
pipe -g --branch <branch-name>
```

**Write to File**
To write the contents to a file, use

```sh
pipe -g --branch <branch-name> >> fileName.txt
```

---

## Features

`-g or --generate`: Used along side `-b` to generate the build info as a string

`-b or --branch`: Used with flag `-g` to generate output

`-h or --help`: Used to display all features and usage

`-v or --verbose`: Used as verbose

`-V or --version`: Used to check CLI version

`-w or --welcome`: Used to display a welcome message

---

## Additional information

*Documentation* can be found here: [Pipeline CLI and Slack Bot](https://daubltd.atlassian.net/wiki/x/OACMMzI)

Author: Zander Kotze
Date: 20 Aug 2024
