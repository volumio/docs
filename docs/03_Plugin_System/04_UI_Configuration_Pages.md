## The Configuration Pages

To allow an easy development of plugin, we need a structured but still flexible way to configure plugins. Volumio uses a json based markup languages to describe the visual and functional aspects of configuration pages. This supports multilanguage and should be flexible enough to allow any kind of setting to be modified. If you feel your case is not covered, feel free to open an issue or discussion at

[https://github.com/volumio/Volumio2/](https://github.com/volumio/Volumio2/)

## Introduction

Configurations resides on single .json files, pertaining to a core component or a specific plugin. This file is `UIConfig.json` and it's interpreted by the `getUIConfig` function present in every plugin. The very same system is used by both Volumio core plugins and community developed plugins, the only difference is that for core functions (such as Wi-fi browser, NAS Browser and some others) we developed special controllers in the UI. You can take a look at them in the  [core elements part of Volumio2 UI](https://github.com/volumio/Volumio2-UI/tree/master/src/app/plugin/core-plugin) .
