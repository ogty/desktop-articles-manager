<h1 align="center">Desktop Articles Manager</h1>

<div>
  <img src="./sample/sample.png" alt="sample image" />
</div>

## ⚙️ Setup

```zsh
$ cd ~/
$ git clone https://github.com/ogty/desktop-articles-manager.git
$ source ./desktop-articles-manager.git/setup.sh
```

## 📖 Usage

```zsh
$ source main.sh
```

## ✏️ Example

**~/Desktop/articles/articles_about_docker.md**

```md
---
icon: "docker-original"
---
# Articles About Docker
```

> **Note**<br />
> If `icon` is not specified, the `pdf` icon will be displayed.

## <img src="https://avatars.githubusercontent.com/u/20685754?s=200&v=4" width="2.5%" /> When using Marp

```md
---
icon: "docker-original"
marp: true
theme: "gaia"
---
# Articles About Docker
```

> **Note**<br />
> By preparing your own CSS design file directly under `marp`,<br />
> you can set the file name to theme and that design will be applied.
> ```md
> ---
> marp: true
> theme: "dracula"
> ---
> ```

## 📍 Items that can be specified

| Key    | Value   | Description                             |
| ------ | ------- | --------------------------------------- |
| icon   | string  | Icon name of PDF file                   |
| marp   | boolean | Whether to create in Marp               |
| create | boolean | Whether to create it in the first place |
| theme  | string  | Marp Theme                              |
