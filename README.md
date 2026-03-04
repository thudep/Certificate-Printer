# Certificates Printer

A sh script to print certificates.

The script generates a 10-character verification code based on SHA256.

## How to use

### Install dependencies

- `typst`: a LaTeX alternative, its [package name](https://repology.org/project/typst/versions) hardly vary on different platforms
- Source Han Serif: font used in the template

### Provide a name list

The input file `list.csv` for `award.typ` should be like this:

```text
清小华,2024,地球中微子暑期学校,三等奖
华小清,2024,地球中微子暑期学校,二等奖
```

The input file `list.csv` for `depsast.typ` should be like this:

```text
清小华,33,科协主席
华小清,33,技术口干事
```

### (Optional) Modify or Choose the template

You may modify the default template `award.typ` to customize the style.

Alternatively, you can prepare multiple template files and select one using the `-t` option when running the script.

### Run the script

There are several ways to run the script. Here are some examples, and you can use `-h` to show the help message.

#### 1. Use the default secret(stored in `secret.txt`) and default template

Create a `secret.txt` file with the secret in it, then run:

```bash
./generate.sh
```

#### 2. Use a custom secret

```bash
./generate.sh -s <your_secret>
```

#### 3. Use a custom template

```bash
./generate.sh -t <your_template>
```

#### 4. Use both a custom secret and custom template

```bash
./generate.sh -s <your_secret> -t <your_template>
```
