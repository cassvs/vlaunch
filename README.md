## vlaunch

A rewrite of `browser-launcher` in Vala.

### Building

Clone the repo, then enter the directory and run `make`.

### Structure

Two files must remain in the same directory as the executable: `vlaunch.glade`, the layout file for the GUI, and `config.json`, the configuration file. If either of these is missing or broken, `vlaunch` will crash at runtime.

### Configuration File

| Key                  | Value |
|----------------------|-------|
| `browser-exec`       | The name of your browser's exeutable. `firefox` for Firefox and `chrome-browser` for Chrome. |
| `private-option`     | The command-line flag that tells your browser to open a private or incognito tab. You can run `<browser-exec> --help` to determine this. |
| `new-tab-option`     | The command-line flag that makes your browser open a new tab, rather than a new window. |
| `search-engine-url`  | The query URL of your search engine of choice. To find this out, search for something, then copy the URL that's in your browser's address bar, excluding the term you searched for. For example, `https://www.google.com/search?q=` for Google, or `https://duckduckgo.com/?q=` for DuckDuckGo. |
| `default-to-private` | If this is `true`, the switch for private tabs is on by default. If `false`, it defaults to off. |

Be careful when editing the config file. If it is syntactically invalid, `vlaunch` may crash with an error on startup, and if you've mapped `vlaunch` to a keyboard shortcut, you probably won't see this error.

### Comparison with the Perl Version

| `browser-launcher` (Perl) | `vlaunch` (Vala) |
|---------------------------|------------------|
| Interpreted at runtime 🐢 | Compiled 🐇 |
| GUI layout in source file | GUI layout in external XML, parsed at runtime 🐢 |
| Configuration in source file | Configuration in external JSON file 🐢 |
| Tk Perl module required | Gtk+ libraries pre-installed on many distros |
| Questionable Windows/Mac compatibility: Perl interpreter and Tk required | GNOME-native |
| Shell injection bug (not dangerous, just annoying) 🐞 | Queries not processed by the shell |
