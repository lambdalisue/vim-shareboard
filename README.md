shareboard.vim
=============================================================================

Version
:   0.1.3

shareboard.vim is a HTML preview software for vim inspired by [mkdpreview-vim][].

![shareboard.vim screenshot](https://raw.github.com/lambdalisue/shareboard.vim/master/static/screenshot001.png "Screenshot")

[mkdpreview-vim]: https://github.com/mattn/mkdpreview-vim


Quick Usage
-----------------------------------------------------------------------------

1.  Install [Pandoc][] with

    Windows & Mac OS X
    :   There is a package installer at pandoc's
        [download page](http://code.google.com/p/pandoc/downloads/list)
    Linux
    :   Try your package manager such as `apt-get`, `yum` or `rpm`

    See http://johnmacfarlane.net/pandoc/installing.html for more detail

2.  Install [Shareboard][] with

    Windows
    :   Use [easy_install][] to install Shareboard. See
        http://packages.python.org/distribute/easy_install.html for more detail

            $ easy_install shareboard

    Mac OS X & Linux
    :   Use [pip][] or [easy_install][] to install Shareboard.

            $ pip shareboard

3.  Confirm Pandoc and Shareboard are correctly installed with command below

    $ pandoc --help
    $ shareboard --help

4.  Create `helloworld.md` and write some Markdown, type `<Leader>v` to show
    Shareboard viewer

[easy_install]: http://packages.python.org/distribute/easy_install.html
[pip]: http://www.pip-installer.org/en/latest/

    
Install
-----------------------------------------------------------------------------

shareboard.vim use [Shareboard][] to display the preview, so you have to install
it with the commands below

    $ pip install shareboard

After you install Shareboard, you can install shareboard.vim with [vim-pathogen][]
, [vundle][] or simply copy the files into your `.vim` directory

And also, if you want to use shareboard.vim with [Markdown][],
[reStructuredText][], or [Textlie][] file, you need to install [Pandoc][] to
convert these types of files into HTML file.

If you want to use different programs to convert files such as [Markdown.pl][],
you can change `g:shareboard_command` variable.

[Shareboard]: https://github.com/lambdalisue/Shareboard
[vim-pathogen]: https://github.com/tpope/vim-pathogen
[vundle]: https://github.com/gmarik/vundle
[Markdown]: http://daringfireball.net/projects/markdown/
[reStructuredText]: http://docutils.sourceforge.net/rst.html
[Textlie]: http://textile.thresholdstate.com/
[Pandoc]: http://johnmacfarlane.net/pandoc/
[Markdown.pl]: http://search.cpan.org/~sekimura/Text-Markdown-Discount-0.04/xt/MarkdownXS.pl

Usage
-----------------------------------------------------------------------------

In default, shareboard.vim activate two key mappings in following file type

-   Html
-   Markdown
-   reStructuredText
-   Textlie

The key mappings activated are

`<Leader>v`
:   Show the preview window. After you show the preview window, the preview
    will automatically be updated when you save the file with `:w` command
`<Leader>c`
:   Compile the data with command specified in `g:shareboard_command`


Configure
-----------------------------------------------------------------------------

### Variables

`g:shareboard_path`
:   Specify the path of Shareboard. Default is `shareboard`
`g:shareboard_host`
:   Specify the host name of Shareboard server. Default is `localhost`
`g:shareboard_port`
:   Specify the port number of Shareboard server. Default is `8081`
`g:shareboard_command`
:   Specify the compile command. Default is `pandoc -Ss --toc -m -t html`
`g:shareboard_compile_ext`
:   Specify the ext name of compiled file. Default is `.html`


### Functions

`ShareboardStart`
:   Start Shareboard server with specified settings. It also execute
`ShareboardUpdate`
:   Update Shareboard with the current buffer. The Shareboard must be exected
    before.
`ShareboardPreview`
:   Call `ShareboardStart` and `ShareboardUpdate`
`ShareboardCompile`
:   Compile current buffer with specified settings.


### Key mappings

`<Leader>v`
:   Show the preview window. After you show the preview window, the preview
    will automatically be updated when you save the file with `:w` command
`<Leader>c`
:   Compile the data with command specified in `g:shareboard_command`
