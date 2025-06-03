# Lunar's (Nix) Library

[builders.mkHost]: lib/builders/mkHost.nix
[builders.mkNovavimPackage]: lib/builders/mkNovavimPackage.nix
[generators.mkCosmicSettings]: lib/generators/mkCosmicSettings.nix
[generators.ron]: lib/generators/ron.nix
[generators.toHyprconf]: lib/generators/toHyprconf.nix
[generators.toSwaylockConf]: lib/generators/toSwaylockConf.nix
[importers.listFilesRecursiveClean]: lib/importers/listFilesRecursiveClean.nix
[importers.listNixRecursive]: lib/importers/listNixRecursive.nix
[systems.forAllSystems]: lib/systems/forAllSystems.nix

A repository of functions that I have used in my Nix projects.

## Functions

| Generator Name                      | Description                                                                                     | License                |
| ----------------------------------- | ----------------------------------------------------------------------------------------------- | ---------------------- |
| [builders.mkHost]                   | A helper function for building nixosConfigurations with flake-parts.                            | [GPLv3]                |
| [builders.mkNovavimPackage]         | A helper function for building nvim packages through [nvf].                                     | [GPLv3]                |
| [generators.mkCosmicSettings]       | A function to convert an attrset of nix settings and convert into RON for COSMIC configuration. | [GPLv3]                |
| [generators.ron]                    | A set of functions for converting to and from RON code.                                         | [MIT (Cosmic Manager)] |
| [generators.toHyprconf]             | A generator for turning Nix into Hyprconf.                                                      | [MIT (Home Manager)]   |
| [generators.toSwaylockConf]         | A generator for turning Nix into Swaylockconf.                                                  | [MIT (Home Manager)]   |
| [importers.listFilesRecursiveClean] | A rewrite of `listFilesRecursive` in a pipe function plus filtering files prefixed with `_`.    | [GPLv3]                |
| [importers.listNixRecursive]        | `listFilesRecursiveClean` but only listing Nix files.                                           | [GPLv3]                |
| [systems.forAllSystems]             | A simple function to manage flake outputs with multiple systems.                                | [GPLv3]                |

[GPLv3]: ./LICENSE
[nvf]: https://github.com/notashelf/nvf
[MIT (Cosmic Manager)]: https://github.com/HeitorAugustoLN/cosmic-manager/blob/main/LICENSE-MIT
[MIT (Home Manager)]: https://github.com/nix-community/home-manager/blob/master/LICENSE

## Usage & Contribution

Feel free to use any in your own config. If you do use any, please star the
repository. If there are any breaking bugs, you can leave an issue. If you think
you can optimize any of the functions, feel free to open a PR. If you want to
yell at me for anything I did, open an issue.

## License

Please keep in mind that any files written by me are available under GPLv3 as
according to the [LICENSE], unless explicitly stated otherwise. While it is also
highlighted in the table above, please see this outlined list of functions that
are _not_ entirely written by me and therefore available under a different
license, which you can also see in the file itself.

- [generators.ron]
- [generators.toHyprconf]
- [generators.toSwaylockConf]

[LICENSE]: ./LICENSE
