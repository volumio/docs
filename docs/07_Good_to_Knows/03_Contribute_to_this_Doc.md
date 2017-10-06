
Everyone knows how tedious it is to write documentation. But it is extremely important for every project, especially for Volumio. So if you find something incomplete, missing or
 wrong feel free to edit this doc and improve it.
 
If you don't feel like editing this doc yourself, you can at least tell us what you would change [here](https://volumio.org/forum/documentation-feedback-t6425.html)!

 #### How this doc works

 This DOC is powered by [DAUX.IO](http://daux.io/) and the source is hosted on the [Github Volumio docs repository](https://github.com/volumio/docs). To edit it, simply clone it, edit the
 pages located under /docs and issue a pull request. You can do so either via command line or with a graphical tool, I personally suggest  [GitKraken](https://www.gitkraken.com/).


 #### Cloning and issuing a Pull request

 1. Clone it
```bash
 https://github.com/volumio/docs.git
```

2. Edit it
  * I suggest [Atom.io IDE](https://atom.io/) together with  [Markdown Preview](https://atom.io/packages/markdown-preview) but any text editor will do
  * Make sure you comply with [DAUX rules](http://daux.io/Getting_Started) (if you create a new page, don't use spaces but _ and make sure the name ends with .md)
  * This doc is written in Markdown language, and automatically converted to html. See the [Markdown Cheatsheet](../Good_to_Knows/Markdown_Cheatsheet) to get used to it

3. Commit it

```bash
git commit -m "Hey I changed this and that"
```

4. Issue a pull request

5. Once your PR gets accepted, in 2 minutes your contribution will be available to the whole community.


#### See changes live

To see your changes live, just download and launch any  [XAMMP environment](https://www.apachefriends.org/it/index.html) to expose a php-capable local web server, and clone the docs
under your htdocs folder. Docs will update in realtime and will be available under `http://localhost/docs`
